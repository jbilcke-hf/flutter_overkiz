class LocalToken {
  const LocalToken({
    required this.label,
    required this.gatewayId,
    required this.gatewayCreationTime,
    required this.uuid,
    required this.scope,
    this.expirationTime,
  });

  factory LocalToken.fromJson(Map<String, dynamic> json) {
    return LocalToken(
      label: json['label'] as String,
      gatewayId: json['gateway_id'] as String,
      gatewayCreationTime: json['gateway_creation_time'] as int,
      uuid: json['uuid'] as String,
      scope: json['scope'] as String,
      expirationTime: json['expiration_time'] as int?,
    );
  }

  final String label;
  final String gatewayId;
  final int gatewayCreationTime;
  final String uuid;
  final String scope;
  final int? expirationTime;

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'gateway_id': gatewayId,
      'gateway_creation_time': gatewayCreationTime,
      'uuid': uuid,
      'scope': scope,
      'expiration_time': expirationTime,
    };
  }

  @override
  String toString() => 'LocalToken(label: $label, gatewayId: $gatewayId, uuid: $uuid)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalToken &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}