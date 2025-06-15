# Flutter OverKiz API

A fully async and easy to use API client for the (internal) OverKiz API. You can use this client to interact with smart devices connected to the OverKiz platform, used by various vendors like Somfy TaHoma and Atlantic Cozytouch.

This Flutter package provides an easy-to-use API client for the OverKiz platform and supports all major platforms (iOS, Android, macOS, Windows, Linux, and Web).

## Supported hubs

- Atlantic Cozytouch
- Bouygues Flexom
- Brandt Smart Control **\***
- Hitachi Hi Kumo
- Nexity Eugénie
- Rexel Energeasy Connect **\***
- Sauter Cozytouch
- Simu (LiveIn2)
- Somfy Connexoon IO
- Somfy Connexoon RTS
- Somfy TaHoma
- Somfy TaHoma Switch
- Thermor Cozytouch

\[*] _These servers utilize an authentication method that is currently not supported by this library. To use this library with these servers, you will need to obtain an access token (by sniffing the original app) and create a local user on the Overkiz API platform._

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_overkiz: ^0.0.0
```

## Getting started

### Cloud API

```dart
import 'package:flutter_overkiz/flutter_overkiz.dart';

const String username = 'your_username';
const String password = 'your_password';

Future<void> main() async {
  final client = OverkizClient(
    username: username,
    password: password,
    server: supportedServers[Server.somfyEurope]!,
  );

  try {
    await client.login();
    print('Logged in successfully');

    final devices = await client.getDevices();
    for (final device in devices) {
      print('${device.label} (${device.id}) - ${device.controllableName}');
      print('${device.widget.value} - ${device.uiClass.value}');
    }

    // Fetch events continuously
    while (true) {
      final events = await client.fetchEvents();
      if (events.isNotEmpty) {
        print('Received ${events.length} events');
        for (final event in events) {
          print('Event: ${event.name.value}');
        }
      }
      await Future.delayed(Duration(seconds: 2));
    }

  } catch (e) {
    print('Error: $e');
  } finally {
    client.dispose();
  }
}
```

### Local API

```dart
import 'package:flutter_overkiz/flutter_overkiz.dart';

const String localGateway = 'gateway-xxxx-xxxx-xxxx.local'; // or use IP address
const bool verifySSL = true; // set to false if you don't use .local hostname
const String token = 'your_generated_token';

Future<void> main() async {
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
    print('Local API connection successful!');

    final version = await client.getApiVersion();
    print('API Version: $version');

    final devices = await client.getDevices();
    for (final device in devices) {
      print('${device.label} (${device.id}) - ${device.controllableName}');
    }

  } catch (e) {
    print('Error: $e');
  } finally {
    client.dispose();
  }
}
```

### Generate Local Token

To use the local API, you first need to generate a token using the cloud API:

```dart
import 'package:flutter_overkiz/flutter_overkiz.dart';

Future<void> generateToken() async {
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
      print('Token for ${gateway.id}: $token');
      // Save this token for future local API usage
    }
  } finally {
    client.dispose();
  }
}
```

## Features

- ✅ **Cross-platform**: Works on all Flutter/Dart platforms (iOS, Android, macOS, Windows, Linux, Web)
- ✅ **Fully async**: All API calls are asynchronous and return Futures
- ✅ **Type-safe**: Strong typing with comprehensive model classes and enums
- ✅ **Authentication**: Supports multiple authentication methods (Somfy, CozyTouch, etc.)
- ✅ **Local API**: Support for local gateway connections
- ✅ **Event streaming**: Real-time event listening
- ✅ **Device control**: Execute commands and scenarios
- ✅ **Comprehensive**: Full API coverage including setup, devices, gateways, executions

## API Reference

### Main Classes

- `OverkizClient` - Main API client
- `Device` - Represents a smart device
- `Gateway` - Represents a gateway/hub
- `Command` - Device command
- `Event` - Real-time event
- `Scenario` - Automation scenario
- `Setup` - Complete setup information

### Supported Operations

- `login()` - Authenticate with the API
- `getSetup()` - Get complete setup information
- `getDevices()` - List all devices
- `getGateways()` - List all gateways
- `getState(deviceUrl)` - Get device states
- `executeCommand(deviceUrl, command)` - Execute device command
- `getScenarios()` - List scenarios
- `executeScenario(oid)` - Execute scenario
- `fetchEvents()` - Get real-time events
- `generateLocalToken(gatewayId)` - Generate local API token

## Error Handling

The library provides comprehensive error handling with specific exception types:

```dart
try {
  await client.login();
} on BadCredentialsException {
  print('Invalid username or password');
} on TooManyRequestsException {
  print('Rate limited - too many requests');
} on ServiceUnavailableException {
  print('Service is temporarily unavailable');
} on OverkizException catch (e) {
  print('General Overkiz error: ${e.message}');
}
```

## Platform Support

This library is designed to work on all platforms supported by Dart/Flutter:

- ✅ **Android** - Full support
- ✅ **iOS** - Full support  
- ✅ **macOS** - Full support
- ✅ **Windows** - Full support
- ✅ **Linux** - Full support
- ✅ **Web** - Full support (with CORS considerations)

## Development

To contribute to this package:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Run `dart test`
6. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

This Flutter library provides a clean, async API for interacting with OverKiz smart home devices.