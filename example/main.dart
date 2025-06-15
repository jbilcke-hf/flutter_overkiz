import 'dart:async';
import 'package:flutter_overkiz/flutter_overkiz.dart';

const String username = ''; // Your username
const String password = ''; // Your password

Future<void> main() async {
  await cloudApiExample();
  await localApiExample();
}

/// Cloud API example
Future<void> cloudApiExample() async {
  print('=== Cloud API Example ===');
  
  final client = OverkizClient(
    username: username,
    password: password,
    server: supportedServers[Server.somfyEurope]!,
  );

  try {
    await client.login();
    print('✓ Logged in successfully');

    final devices = await client.getDevices();
    print('Found ${devices.length} devices:');

    for (final device in devices) {
      print('  ${device.label} (${device.id}) - ${device.controllableName}');
      print('  Widget: ${device.widget.value} - UI Class: ${device.uiClass.value}');
    }

    // Fetch events in a loop (demo only - limit to 5 iterations)
    print('\nFetching events...');
    var eventCount = 0;
    while (eventCount < 5) {
      final events = await client.fetchEvents();
      if (events.isNotEmpty) {
        print('Received ${events.length} events');
        for (final event in events) {
          print('  Event: ${event.name.value} - ${event.deviceUrl}');
        }
      }
      await Future.delayed(Duration(seconds: 2));
      eventCount++;
    }

  } catch (e) {
    print('Error: $e');
  } finally {
    client.dispose();
  }
}

/// Local API example
Future<void> localApiExample() async {
  print('\n=== Local API Example ===');
  
  const localGateway = 'gateway-xxxx-xxxx-xxxx.local'; // or use IP address
  const verifySSL = true; // set to false if you don't use .local hostname
  const token = ''; // you can set the token here for testing

  if (token.isEmpty) {
    print('⚠️  Local API example requires a token. Please generate one first using the cloud API.');
    return;
  }

  final localServer = generateLocalServer(
    host: localGateway,
    name: 'Somfy TaHoma (local)',
  );

  final client = OverkizClient(
    username: '',
    password: '',
    server: localServer,
    token: token,
    verifySSL: verifySSL,
  );

  try {
    await client.login();
    print('✓ Local API connection successful!');

    final version = await client.getApiVersion();
    print('API Version: $version');

    final setup = await client.getSetup();
    print('Setup: ${setup.toString()}');

    final devices = await client.getDevices();
    print('Found ${devices.length} devices:');

    for (final device in devices) {
      print('  ${device.label} (${device.id}) - ${device.controllableName}');
      print('  Widget: ${device.widget.value} - UI Class: ${device.uiClass.value}');
    }

  } catch (e) {
    print('Error: $e');
  } finally {
    client.dispose();
  }
}

/// Generate local token example
Future<void> generateTokenExample() async {
  print('\n=== Generate Local Token Example ===');
  
  final client = OverkizClient(
    username: username,
    password: password,
    server: supportedServers[Server.somfyEurope]!,
  );

  try {
    await client.login();
    final gateways = await client.getGateways();

    for (final gateway in gateways) {
      final token = await client.generateLocalToken(gateway.id);
      await client.activateLocalToken(
        gatewayId: gateway.id,
        token: token,
        label: 'Dart Overkiz API',
      );
      print('Token for ${gateway.id}:');
      print(token); // Save this token for future use
    }

  } catch (e) {
    print('Error: $e');
  } finally {
    client.dispose();
  }
}