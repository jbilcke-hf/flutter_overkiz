import '../enums/general.dart';
import '../enums/execution.dart';
import 'state.dart';

class Event {
  const Event({
    required this.name,
    this.timestamp,
    this.setupoid,
    this.ownerKey,
    this.type,
    this.subType,
    this.timeToNextState,
    this.failedCommands,
    this.failureTypeCode,
    this.failureType,
    this.conditionGroupoid,
    this.placeOid,
    this.label,
    this.metadata,
    this.cameraId,
    this.deletedRawDevicesCount,
    this.protocolType,
    this.gatewayId,
    this.execId,
    this.deviceUrl,
    this.deviceStates = const [],
    this.oldState,
    this.newState,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: _eventNameFromJson(json['name']),
      timestamp: json['timestamp'] as int?,
      setupoid: json['setupoid'] as String?,
      ownerKey: json['owner_key'] as String?,
      type: json['type'] as int?,
      subType: json['sub_type'] as int?,
      timeToNextState: json['time_to_next_state'] as int?,
      failedCommands: (json['failed_commands'] as List<dynamic>?)
          ?.cast<Map<String, dynamic>>(),
      failureTypeCode: _failureTypeFromJson(json['failure_type_code']),
      failureType: json['failure_type'] as String?,
      conditionGroupoid: json['condition_groupoid'] as String?,
      placeOid: json['place_oid'] as String?,
      label: json['label'] as String?,
      metadata: json['metadata'],
      cameraId: json['camera_id'] as String?,
      deletedRawDevicesCount: json['deleted_raw_devices_count'],
      protocolType: json['protocol_type'],
      gatewayId: json['gateway_id'] as String?,
      execId: json['exec_id'] as String?,
      deviceUrl: json['device_url'] as String?,
      deviceStates: (json['device_states'] as List<dynamic>? ?? [])
          .map((e) => EventState.fromJson(e as Map<String, dynamic>))
          .toList(),
      oldState: _executionStateFromJson(json['old_state']),
      newState: _executionStateFromJson(json['new_state']),
    );
  }

  final EventName name;
  final int? timestamp;
  final String? setupoid;
  final String? ownerKey;
  final int? type;
  final int? subType;
  final int? timeToNextState;
  final List<Map<String, dynamic>>? failedCommands;
  final FailureType? failureTypeCode;
  final String? failureType;
  final String? conditionGroupoid;
  final String? placeOid;
  final String? label;
  final dynamic metadata;
  final String? cameraId;
  final dynamic deletedRawDevicesCount;
  final dynamic protocolType;
  final String? gatewayId;
  final String? execId;
  final String? deviceUrl;
  final List<EventState> deviceStates;
  final ExecutionState? oldState;
  final ExecutionState? newState;

  static EventName _eventNameFromJson(dynamic name) {
    if (name is String) return EventName.fromString(name);
    return EventName.unknown;
  }

  static String _eventNameToJson(EventName name) => name.value;

  static FailureType? _failureTypeFromJson(dynamic type) {
    if (type is int) return FailureType.fromInt(type);
    return null;
  }

  static int? _failureTypeToJson(FailureType? type) => type?.value;

  static ExecutionState? _executionStateFromJson(dynamic state) {
    if (state is String) return ExecutionState.fromString(state);
    return null;
  }

  static String? _executionStateToJson(ExecutionState? state) => state?.value;

  Map<String, dynamic> toJson() {
    return {
      'name': _eventNameToJson(name),
      'timestamp': timestamp,
      'setupoid': setupoid,
      'owner_key': ownerKey,
      'type': type,
      'sub_type': subType,
      'time_to_next_state': timeToNextState,
      'failed_commands': failedCommands,
      'failure_type_code': _failureTypeToJson(failureTypeCode),
      'failure_type': failureType,
      'condition_groupoid': conditionGroupoid,
      'place_oid': placeOid,
      'label': label,
      'metadata': metadata,
      'camera_id': cameraId,
      'deleted_raw_devices_count': deletedRawDevicesCount,
      'protocol_type': protocolType,
      'gateway_id': gatewayId,
      'exec_id': execId,
      'device_url': deviceUrl,
      'device_states': deviceStates.map((e) => e.toJson()).toList(),
      'old_state': _executionStateToJson(oldState),
      'new_state': _executionStateToJson(newState),
    };
  }

  @override
  String toString() => 'Event(name: $name, timestamp: $timestamp, deviceUrl: $deviceUrl)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          timestamp == other.timestamp &&
          deviceUrl == other.deviceUrl;

  @override
  int get hashCode => Object.hash(name, timestamp, deviceUrl);
}