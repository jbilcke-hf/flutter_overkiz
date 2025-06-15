import '../enums/execution.dart';

class Execution {
  const Execution({
    required this.id,
    required this.description,
    required this.owner,
    required this.state,
    required this.actionGroup,
  });

  factory Execution.fromJson(Map<String, dynamic> json) {
    return Execution(
      id: json['id'] as String,
      description: json['description'] as String,
      owner: json['owner'] as String,
      state: json['state'] as String,
      actionGroup: (json['action_group'] as List<dynamic>)
          .cast<Map<String, dynamic>>(),
    );
  }

  final String id;
  final String description;
  final String owner;
  final String state;
  final List<Map<String, dynamic>> actionGroup;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'owner': owner,
      'state': state,
      'action_group': actionGroup,
    };
  }

  @override
  String toString() => 'Execution(id: $id, description: $description, state: $state)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Execution &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class HistoryExecutionCommand {
  const HistoryExecutionCommand({
    required this.deviceUrl,
    required this.command,
    required this.rank,
    required this.isDynamic,
    required this.state,
    required this.failureType,
    this.parameters,
  });

  factory HistoryExecutionCommand.fromJson(Map<String, dynamic> json) {
    return HistoryExecutionCommand(
      deviceUrl: json['device_url'] as String,
      command: json['command'] as String,
      parameters: (json['parameters'] as List?)?.cast<Object?>(),
      rank: json['rank'] as int,
      isDynamic: json['dynamic'] as bool,
      state: _executionStateFromJson(json['state']),
      failureType: json['failure_type'] as String,
    );
  }

  final String deviceUrl;
  final String command;
  final List<Object?>? parameters;
  final int rank;
  final bool isDynamic;
  final ExecutionState state;
  final String failureType;

  static ExecutionState _executionStateFromJson(Object? state) {
    if (state is String) return ExecutionState.fromString(state);
    return ExecutionState.unknown;
  }

  static String _executionStateToJson(ExecutionState state) => state.value;

  Map<String, dynamic> toJson() {
    return {
      'device_url': deviceUrl,
      'command': command,
      'parameters': parameters,
      'rank': rank,
      'dynamic': isDynamic,
      'state': _executionStateToJson(state),
      'failure_type': failureType,
    };
  }
}

class HistoryExecution {
  const HistoryExecution({
    required this.id,
    required this.eventTime,
    required this.owner,
    required this.source,
    required this.duration,
    required this.type,
    required this.state,
    required this.failureType,
    required this.commands,
    required this.executionType,
    required this.executionSubType,
    this.endTime,
    this.effectiveStartTime,
    this.label,
  });

  factory HistoryExecution.fromJson(Map<String, dynamic> json) {
    return HistoryExecution(
      id: json['id'] as String,
      eventTime: json['event_time'] as int,
      owner: json['owner'] as String,
      source: json['source'] as String,
      endTime: json['end_time'] as int?,
      effectiveStartTime: json['effective_start_time'] as int?,
      duration: json['duration'] as int,
      label: json['label'] as String?,
      type: json['type'] as String,
      state: _executionStateFromJson(json['state']),
      failureType: json['failure_type'] as String,
      commands: (json['commands'] as List)
          .map((e) => HistoryExecutionCommand.fromJson(e as Map<String, dynamic>))
          .toList(),
      executionType: _executionTypeFromJson(json['execution_type']),
      executionSubType: _executionSubTypeFromJson(json['execution_sub_type']),
    );
  }

  final String id;
  final int eventTime;
  final String owner;
  final String source;
  final int? endTime;
  final int? effectiveStartTime;
  final int duration;
  final String? label;
  final String type;
  final ExecutionState state;
  final String failureType;
  final List<HistoryExecutionCommand> commands;
  final ExecutionType executionType;
  final ExecutionSubType executionSubType;

  static ExecutionState _executionStateFromJson(Object? state) {
    if (state is String) return ExecutionState.fromString(state);
    return ExecutionState.unknown;
  }

  static String _executionStateToJson(ExecutionState state) => state.value;

  static ExecutionType _executionTypeFromJson(Object? type) {
    if (type is String) return ExecutionType.fromString(type);
    return ExecutionType.immediateExecution;
  }

  static String _executionTypeToJson(ExecutionType type) => type.value;

  static ExecutionSubType _executionSubTypeFromJson(Object? subType) {
    if (subType is String) return ExecutionSubType.fromString(subType);
    return ExecutionSubType.unknown;
  }

  static String _executionSubTypeToJson(ExecutionSubType subType) => subType.value;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_time': eventTime,
      'owner': owner,
      'source': source,
      'end_time': endTime,
      'effective_start_time': effectiveStartTime,
      'duration': duration,
      'label': label,
      'type': type,
      'state': _executionStateToJson(state),
      'failure_type': failureType,
      'commands': commands.map((e) => e.toJson()).toList(),
      'execution_type': _executionTypeToJson(executionType),
      'execution_sub_type': _executionSubTypeToJson(executionSubType),
    };
  }

  @override
  String toString() => 'HistoryExecution(id: $id, eventTime: $eventTime, state: $state)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryExecution &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}