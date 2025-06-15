/// Class to describe an Overkiz server.
class OverkizServer {
  const OverkizServer({
    required this.name,
    required this.endpoint,
    required this.manufacturer,
    this.configurationUrl,
  });

  factory OverkizServer.fromJson(Map<String, dynamic> json) {
    return OverkizServer(
      name: json['name'] as String,
      endpoint: json['endpoint'] as String,
      manufacturer: json['manufacturer'] as String,
      configurationUrl: json['configuration_url'] as String?,
    );
  }

  final String name;
  final String endpoint;
  final String manufacturer;
  final String? configurationUrl;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'endpoint': endpoint,
      'manufacturer': manufacturer,
      'configuration_url': configurationUrl,
    };
  }

  @override
  String toString() => 'OverkizServer(name: $name, endpoint: $endpoint, manufacturer: $manufacturer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverkizServer &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          endpoint == other.endpoint &&
          manufacturer == other.manufacturer &&
          configurationUrl == other.configurationUrl;

  @override
  int get hashCode => Object.hash(name, endpoint, manufacturer, configurationUrl);
}