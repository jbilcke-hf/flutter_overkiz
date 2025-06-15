import '../enums/gateway.dart';

class Partner {
  const Partner({
    required this.activated,
    required this.name,
    required this.id,
    required this.status,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      activated: json['activated'] as bool,
      name: json['name'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
    );
  }

  final bool activated;
  final String name;
  final String id;
  final String status;

  Map<String, dynamic> toJson() {
    return {
      'activated': activated,
      'name': name,
      'id': id,
      'status': status,
    };
  }
}

class Connectivity {
  const Connectivity({
    required this.status,
    required this.protocolVersion,
  });

  factory Connectivity.fromJson(Map<String, dynamic> json) {
    return Connectivity(
      status: json['status'] as String,
      protocolVersion: json['protocol_version'] as String,
    );
  }

  final String status;
  final String protocolVersion;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'protocol_version': protocolVersion,
    };
  }
}

class Gateway {
  const Gateway({
    required this.id,
    required this.gatewayId,
    required this.connectivity,
    this.partners = const [],
    this.functions,
    this.subType,
    this.alive,
    this.mode,
    this.placeOid,
    this.timeReliable,
    this.upToDate,
    this.updateStatus,
    this.syncInProgress,
    this.type,
  });

  factory Gateway.fromJson(Map<String, dynamic> json) {
    return Gateway(
      id: json['id'] as String,
      gatewayId: json['gateway_id'] as String,
      connectivity: Connectivity.fromJson(json['connectivity'] as Map<String, dynamic>),
      partners: (json['partners'] as List<dynamic>? ?? [])
          .map((e) => Partner.fromJson(e as Map<String, dynamic>))
          .toList(),
      functions: json['functions'] as String?,
      subType: _gatewaySubTypeFromJson(json['sub_type']),
      alive: json['alive'] as bool?,
      mode: json['mode'] as String?,
      placeOid: json['place_oid'] as String?,
      timeReliable: json['time_reliable'] as bool?,
      upToDate: json['up_to_date'] as bool?,
      updateStatus: _updateBoxStatusFromJson(json['update_status']),
      syncInProgress: json['sync_in_progress'] as bool?,
      type: _gatewayTypeFromJson(json['type']),
    );
  }

  final String id;
  final String gatewayId;
  final List<Partner> partners;
  final String? functions;
  final GatewaySubType? subType;
  final bool? alive;
  final String? mode;
  final String? placeOid;
  final bool? timeReliable;
  final Connectivity connectivity;
  final bool? upToDate;
  final UpdateBoxStatus? updateStatus;
  final bool? syncInProgress;
  final GatewayType? type;

  static GatewaySubType? _gatewaySubTypeFromJson(dynamic subType) {
    if (subType is int) return GatewaySubType.fromInt(subType);
    return null;
  }

  static int? _gatewaySubTypeToJson(GatewaySubType? subType) => subType?.value;

  static UpdateBoxStatus? _updateBoxStatusFromJson(dynamic status) {
    if (status is String) return UpdateBoxStatus.fromString(status);
    return null;
  }

  static String? _updateBoxStatusToJson(UpdateBoxStatus? status) => status?.value;

  static GatewayType? _gatewayTypeFromJson(dynamic type) {
    if (type is int) return GatewayType.fromInt(type);
    return null;
  }

  static int? _gatewayTypeToJson(GatewayType? type) => type?.value;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gateway_id': gatewayId,
      'connectivity': connectivity.toJson(),
      'partners': partners.map((e) => e.toJson()).toList(),
      'functions': functions,
      'sub_type': _gatewaySubTypeToJson(subType),
      'alive': alive,
      'mode': mode,
      'place_oid': placeOid,
      'time_reliable': timeReliable,
      'up_to_date': upToDate,
      'update_status': _updateBoxStatusToJson(updateStatus),
      'sync_in_progress': syncInProgress,
      'type': _gatewayTypeToJson(type),
    };
  }

  @override
  String toString() => 'Gateway(id: $id, gatewayId: $gatewayId, type: $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Gateway &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          gatewayId == other.gatewayId;

  @override
  int get hashCode => Object.hash(id, gatewayId);
}