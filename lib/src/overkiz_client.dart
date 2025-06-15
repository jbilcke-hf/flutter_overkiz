import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'enums/server.dart';
import 'exceptions.dart';
import 'models/command.dart';
import 'models/device.dart';
import 'models/event.dart';
import 'models/gateway.dart';
import 'models/local_token.dart';
import 'models/overkiz_server.dart';
import 'models/scenario.dart';
import 'models/setup.dart';
import 'models/state.dart';

/// Interface class for the Overkiz API
class OverkizClient {
  OverkizClient({
    required this.username,
    required this.password,
    required this.server,
    this.verifySSL = true,
    this.token,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client() {
    _determineApiType();
  }

  final String username;
  final String password;
  final OverkizServer server;
  final bool verifySSL;
  final String? token;
  final http.Client _httpClient;

  Setup? setup;
  List<Device> devices = [];
  List<Gateway> gateways = [];
  String? eventListenerId;
  APIType apiType = APIType.cloud;

  String? _refreshToken;
  DateTime? _expiresIn;
  String? _accessToken;

  void _determineApiType() {
    if (server.endpoint.contains(localApiPath)) {
      apiType = APIType.local;
    } else {
      apiType = APIType.cloud;
    }
    _accessToken = token;
  }

  /// Close the HTTP client and cleanup resources
  void dispose() {
    if (eventListenerId != null) {
      // Best effort to unregister event listener
      try {
        unregisterEventListener();
      } catch (e) {
        // Ignore errors during cleanup
      }
    }
    _httpClient.close();
  }

  /// Authenticate and create an API session
  Future<bool> login({bool registerEventListener = true}) async {
    // Local authentication
    if (apiType == APIType.local) {
      if (registerEventListener) {
        await this.registerEventListener();
      } else {
        // Call a simple endpoint to verify if our token is correct
        await getGateways();
      }
      return true;
    }

    // Somfy TaHoma authentication using access_token
    if (server == supportedServers[Server.somfyEurope]!) {
      await _somfyTahomaGetAccessToken();
      if (registerEventListener) {
        await this.registerEventListener();
      }
      return true;
    }

    // CozyTouch authentication using jwt
    if ([
      supportedServers[Server.atlanticCozytouch]!,
      supportedServers[Server.thermorCozytouch]!,
      supportedServers[Server.sauterCozytouch]!,
    ].contains(server)) {
      final jwt = await _cozytouchLogin();
      final payload = {'jwt': jwt};
      final response = await _post('login', data: payload);
      if (response['success'] == true) {
        if (registerEventListener) await this.registerEventListener();
        return true;
      }
      return false;
    }

    // Regular authentication using userId+userPassword
    final payload = {'userId': username, 'userPassword': password};
    final response = await _post('login', data: payload);

    if (response['success'] == true) {
      if (registerEventListener) await this.registerEventListener();
      return true;
    }
    return false;
  }

  /// Get access token for Somfy TaHoma
  Future<String> _somfyTahomaGetAccessToken() async {
    final response = await _httpClient.post(
      Uri.parse('$somfyApi/oauth/oauth/v2/token/jwt'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'password',
        'username': username,
        'password': password,
        'client_id': somfyClientId,
        'client_secret': somfyClientSecret,
      },
    );

    final token = jsonDecode(response.body) as Map<String, dynamic>;

    if (token.containsKey('message') && token['message'] == 'error.invalid.grant') {
      throw SomfyBadCredentialsException(token['message']);
    }

    if (!token.containsKey('access_token')) {
      throw SomfyServiceException('No Somfy access token provided.');
    }

    _accessToken = token['access_token'] as String;
    _refreshToken = token['refresh_token'] as String;
    _expiresIn = DateTime.now().add(Duration(seconds: (token['expires_in'] as int) - 5));

    return _accessToken!;
  }

  /// Get JWT token for CozyTouch
  Future<String> _cozytouchLogin() async {
    // Request access token
    final tokenResponse = await _httpClient.post(
      Uri.parse('$cozytouchAtlanticApi/token'),
      headers: {
        'Authorization': 'Basic $cozytouchClientId',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'password',
        'username': 'GA-PRIVATEPERSON/$username',
        'password': password,
      },
    );

    final token = jsonDecode(tokenResponse.body) as Map<String, dynamic>;

    if (token.containsKey('error') && token['error'] == 'invalid_grant') {
      throw CozyTouchBadCredentialsException(token['error_description']);
    }

    if (!token.containsKey('token_type')) {
      throw CozyTouchServiceException('No CozyTouch token provided.');
    }

    // Request JWT
    final jwtResponse = await _httpClient.get(
      Uri.parse('$cozytouchAtlanticApi/magellan/accounts/jwt'),
      headers: {'Authorization': 'Bearer ${token['access_token']}'},
    );

    final jwt = jwtResponse.body.trim().replaceAll('"', '');
    if (jwt.isEmpty) {
      throw CozyTouchServiceException('No JWT token provided.');
    }

    return jwt;
  }

  /// Refresh the access token
  Future<void> refreshToken() async {
    if (server != supportedServers[Server.somfyEurope]!) return;

    if (_refreshToken == null) {
      throw ArgumentError('No refresh token provided. Login method must be used.');
    }

    final response = await _httpClient.post(
      Uri.parse('$somfyApi/oauth/oauth/v2/token/jwt'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'refresh_token',
        'refresh_token': _refreshToken!,
        'client_id': somfyClientId,
        'client_secret': somfyClientSecret,
      },
    );

    final token = jsonDecode(response.body) as Map<String, dynamic>;

    if (token.containsKey('message') && token['message'] == 'error.invalid.grant') {
      throw SomfyBadCredentialsException(token['message']);
    }

    if (!token.containsKey('access_token')) {
      throw SomfyServiceException('No Somfy access token provided.');
    }

    _accessToken = token['access_token'] as String;
    _refreshToken = token['refresh_token'] as String;
    _expiresIn = DateTime.now().add(Duration(seconds: (token['expires_in'] as int) - 5));
  }

  /// Get setup data
  Future<Setup> getSetup({bool refresh = false}) async {
    if (setup != null && !refresh) return setup!;

    final response = await _get('setup');
    final setupData = Setup.fromJson(response);

    // Cache response
    setup = setupData;
    gateways = setupData.gateways;
    devices = setupData.devices;

    return setupData;
  }

  /// Get devices
  Future<List<Device>> getDevices({bool refresh = false}) async {
    if (devices.isNotEmpty && !refresh) return devices;

    final response = await _get('setup/devices');
    final deviceList = (response as List).map((d) => Device.fromJson(d)).toList();

    // Cache response
    devices = deviceList;
    if (setup != null) {
      setup = Setup.fromJson({
        ...setup!.toJson(),
        'devices': response,
      });
    }

    return deviceList;
  }

  /// Get gateways
  Future<List<Gateway>> getGateways({bool refresh = false}) async {
    if (gateways.isNotEmpty && !refresh) return gateways;

    final response = await _get('setup/gateways');
    final gatewayList = (response as List).map((g) => Gateway.fromJson(g)).toList();

    // Cache response
    gateways = gatewayList;
    if (setup != null) {
      setup = Setup.fromJson({
        ...setup!.toJson(),
        'gateways': response,
      });
    }

    return gatewayList;
  }

  /// Get device states
  Future<List<State>> getState(String deviceUrl) async {
    final encodedUrl = Uri.encodeComponent(deviceUrl);
    final response = await _get('setup/devices/$encodedUrl/states');
    return (response as List).map((s) => State.fromJson(s)).toList();
  }

  /// Register event listener
  Future<String> registerEventListener() async {
    final response = await _post('events/register');
    final listenerId = response['id'] as String;
    eventListenerId = listenerId;
    return listenerId;
  }

  /// Fetch events
  Future<List<Event>> fetchEvents() async {
    await _refreshTokenIfExpired();
    final response = await _post('events/$eventListenerId/fetch');
    return (response as List).map((e) => Event.fromJson(e)).toList();
  }

  /// Unregister event listener
  Future<void> unregisterEventListener() async {
    await _refreshTokenIfExpired();
    await _post('events/$eventListenerId/unregister');
    eventListenerId = null;
  }

  /// Execute a command
  Future<String> executeCommand(
    String deviceUrl,
    Command command, {
    String label = 'dart-overkiz-api',
  }) async {
    return executeCommands(deviceUrl, [command], label: label);
  }

  /// Execute multiple commands
  Future<String> executeCommands(
    String deviceUrl,
    List<Command> commands, {
    String label = 'dart-overkiz-api',
  }) async {
    final payload = {
      'label': label,
      'actions': [
        {
          'deviceURL': deviceUrl,
          'commands': commands.map((c) => c.toJson()).toList(),
        }
      ],
    };
    final response = await _post('exec/apply', payload: payload);
    return response['execId'] as String;
  }

  /// Get scenarios
  Future<List<Scenario>> getScenarios() async {
    final response = await _get('actionGroups');
    return (response as List).map((s) => Scenario.fromJson(s)).toList();
  }

  /// Execute scenario
  Future<String> executeScenario(String oid) async {
    final response = await _post('exec/$oid');
    return response['execId'] as String;
  }

  /// Get API version (local only)
  Future<String> getApiVersion() async {
    final response = await _get('apiVersion');
    return response['protocolVersion'] as String;
  }

  /// Generate local token
  Future<String> generateLocalToken(String gatewayId) async {
    final response = await _get('config/$gatewayId/local/tokens/generate');
    return response['token'] as String;
  }

  /// Activate local token
  Future<String> activateLocalToken({
    required String gatewayId,
    required String token,
    required String label,
    String scope = 'devmode',
  }) async {
    final response = await _post(
      'config/$gatewayId/local/tokens',
      payload: {'label': label, 'token': token, 'scope': scope},
    );
    return response['requestId'] as String;
  }

  /// Get local tokens
  Future<List<LocalToken>> getLocalTokens(String gatewayId, {String scope = 'devmode'}) async {
    final response = await _get('config/$gatewayId/local/tokens/$scope');
    return (response as List).map((lt) => LocalToken.fromJson(lt)).toList();
  }

  /// HTTP GET request
  Future<dynamic> _get(String path) async {
    await _refreshTokenIfExpired();
    
    final headers = <String, String>{};
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }

    final response = await _httpClient.get(
      Uri.parse('${server.endpoint}$path'),
      headers: headers,
    );

    await _checkResponse(response);
    return jsonDecode(response.body);
  }

  /// HTTP POST request
  Future<dynamic> _post(
    String path, {
    Map<String, dynamic>? payload,
    Map<String, dynamic>? data,
  }) async {
    final headers = <String, String>{};

    if (path != 'login' && _accessToken != null) {
      await _refreshTokenIfExpired();
      headers['Authorization'] = 'Bearer $_accessToken';
    }

    http.Response response;
    if (data != null) {
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
      response = await _httpClient.post(
        Uri.parse('${server.endpoint}$path'),
        headers: headers,
        body: data,
      );
    } else {
      headers['Content-Type'] = 'application/json';
      response = await _httpClient.post(
        Uri.parse('${server.endpoint}$path'),
        headers: headers,
        body: payload != null ? jsonEncode(payload) : null,
      );
    }

    await _checkResponse(response);
    return jsonDecode(response.body);
  }

  /// Check HTTP response for errors
  Future<void> _checkResponse(http.Response response) async {
    if ([200, 204].contains(response.statusCode)) {
      return;
    }

    dynamic result;
    try {
      result = jsonDecode(response.body);
    } catch (e) {
      final body = response.body;
      if (body.contains('is down for maintenance')) {
        throw MaintenanceException('Server is down for maintenance');
      }
      if (response.statusCode == 503) {
        throw ServiceUnavailableException(body);
      }
      throw OverkizException('Unknown error while requesting ${response.request?.url}. ${response.statusCode} - $body');
    }

    if (result is Map && result.containsKey('errorCode')) {
      final message = (result['error'] as String?)?.replaceAll(RegExp(r'[".]$'), '') ?? '';

      if (message.contains('Too many requests')) {
        throw TooManyRequestsException(message);
      }
      if (message == 'Bad credentials') {
        throw BadCredentialsException(message);
      }
      if (message == 'Not authenticated') {
        throw NotAuthenticatedException(message);
      }
      if (message == 'Missing authorization token') {
        throw MissingAuthorizationTokenException(message);
      }
      if (message == 'Server busy, please try again later. (Too many executions)') {
        throw TooManyExecutionsException(message);
      }
      if (message.contains('No such command')) {
        throw InvalidCommandException(message);
      }
      if (message.contains('Invalid event listener id')) {
        throw InvalidEventListenerIdException(message);
      }
      if (message == 'No registered event listener') {
        throw NoRegisteredEventListenerException(message);
      }
      if (message == 'No such resource') {
        throw NoSuchResourceException(message);
      }
      if (message == 'too many concurrent requests') {
        throw TooManyConcurrentRequestsException(message);
      }
      if (message.contains('Execution queue is full on gateway')) {
        throw ExecutionQueueFullException(message);
      }
      if (message == 'Cannot use JSESSIONID and bearer token in same request') {
        throw SessionAndBearerInSameRequestException(message);
      }
      if (message == 'Too many attempts with an invalid token, temporarily banned') {
        throw TooManyAttemptsBannedException(message);
      }
      if (message.contains('Invalid token')) {
        throw InvalidTokenException(message);
      }
      if (message.contains('Not such token with UUID')) {
        throw NotSuchTokenException(message);
      }
      if (message.contains('Unknown user')) {
        throw UnknownUserException(message);
      }
      if (message == 'Unknown object') {
        throw UnknownObjectException(message);
      }
      if (message.contains('Access denied to gateway')) {
        throw AccessDeniedToGatewayException(message);
      }
    }

    throw OverkizException(result.toString());
  }

  /// Refresh token if expired
  Future<void> _refreshTokenIfExpired() async {
    if (_expiresIn != null &&
        _refreshToken != null &&
        _expiresIn!.isBefore(DateTime.now())) {
      await refreshToken();
      if (eventListenerId != null) {
        await registerEventListener();
      }
    }
  }
}