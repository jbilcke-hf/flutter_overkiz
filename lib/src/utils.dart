import 'constants.dart';
import 'models/overkiz_server.dart';

/// Generate OverkizServer class for connection with a local API (Somfy Developer mode).
OverkizServer generateLocalServer({
  required String host,
  String name = 'Somfy Developer Mode',
  String manufacturer = 'Somfy',
  String? configurationUrl,
}) {
  return OverkizServer(
    name: name,
    endpoint: 'https://$host$localApiPath',
    manufacturer: manufacturer,
    configurationUrl: configurationUrl,
  );
}

/// Return if gateway is Overkiz gateway. Can be used to distinguish between the main gateway and an additional gateway.
bool isOverkizGateway(String gatewayId) {
  final pattern = RegExp(r'\d{4}-\d{4}-\d{4}');
  return pattern.hasMatch(gatewayId);
}

/// Mask ID for privacy/logging purposes
String obfuscateId(String? id) {
  if (id == null) return '';
  return id.replaceAll(RegExp(r'(SETUP)?\d+-'), '****-');
}

/// Mask email for privacy/logging purposes
String obfuscateEmail(String? email) {
  if (email == null) return '';
  String cleanEmail = email.replaceAll('_-_', '@'); // Replace @ for _-_ (Nexity)
  return cleanEmail.replaceAll(RegExp(r'(.).*@.*(.\..*)'),'****@****');
}

/// Mask string for privacy/logging purposes
String obfuscateString(String input) {
  return input.replaceAll(RegExp(r'[a-zA-Z0-9_.-]'), '*');
}

/// Mask Overkiz JSON data to remove sensitive data
Map<String, dynamic> obfuscateSensitiveData(Map<String, dynamic> data) {
  bool maskNextValue = false;
  final result = Map<String, dynamic>.from(data);

  for (final entry in result.entries) {
    final key = entry.key;
    final value = entry.value;

    if (['gatewayId', 'id', 'deviceURL'].contains(key)) {
      result[key] = obfuscateId(value?.toString());
    }

    if ([
      'label',
      'city',
      'country',
      'postalCode',
      'addressLine1',
      'addressLine2',
      'longitude',
      'latitude',
    ].contains(key)) {
      result[key] = obfuscateString(value?.toString() ?? '');
    }

    if ([
      'core:NameState',
      'homekit:SetupCode',
      'homekit:SetupPayload',
      'core:SSIDState',
    ].contains(value)) {
      maskNextValue = true;
    }

    if (maskNextValue && key == 'value') {
      result[key] = obfuscateString(value?.toString() ?? '');
      maskNextValue = false;
    }

    // Recursively handle nested objects and arrays
    if (value is Map<String, dynamic>) {
      result[key] = obfuscateSensitiveData(value);
    } else if (value is List) {
      result[key] = value.map((item) {
        if (item is Map<String, dynamic>) {
          return obfuscateSensitiveData(item);
        }
        return item;
      }).toList();
    }
  }

  return result;
}