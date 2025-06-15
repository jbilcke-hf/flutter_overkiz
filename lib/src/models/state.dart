import '../enums/general.dart';

/// Represents a device state.
class State {
  const State({
    required this.name,
    required this.type,
    this.value,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      name: json['name'] as String,
      type: State._dataTypeFromJson(json['type']),
      value: json['value'],
    );
  }

  final String name;
  final DataType type;
  final dynamic value;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': State._dataTypeToJson(type),
      'value': value,
    };
  }

  static DataType _dataTypeFromJson(dynamic type) {
    if (type is int) {
      return DataType.fromInt(type);
    }
    return DataType.none;
  }

  static int _dataTypeToJson(DataType type) => type.value;

  /// Get value as integer if type is INTEGER
  int? get valueAsInt {
    if (type == DataType.none) return null;
    if (type == DataType.integer) return value as int?;
    throw TypeError();
  }

  /// Get value as double if type is FLOAT
  double? get valueAsFloat {
    if (type == DataType.none) return null;
    if (type == DataType.float) return value as double?;
    throw TypeError();
  }

  /// Get value as bool if type is BOOLEAN
  bool? get valueAsBool {
    if (type == DataType.none) return null;
    if (type == DataType.boolean) return value as bool?;
    throw TypeError();
  }

  /// Get value as string if type is STRING
  String? get valueAsString {
    if (type == DataType.none) return null;
    if (type == DataType.string) return value as String?;
    throw TypeError();
  }

  /// Get value as Map if type is JSON_OBJECT
  Map<String, dynamic>? get valueAsMap {
    if (type == DataType.none) return null;
    if (type == DataType.jsonObject) return value as Map<String, dynamic>?;
    throw TypeError();
  }

  /// Get value as List if type is JSON_ARRAY
  List<dynamic>? get valueAsList {
    if (type == DataType.none) return null;
    if (type == DataType.jsonArray) return value as List<dynamic>?;
    throw TypeError();
  }

  @override
  String toString() => 'State(name: $name, type: $type, value: $value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is State &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type &&
          value == other.value;

  @override
  int get hashCode => Object.hash(name, type, value);
}

/// Event-specific state that handles type conversion.
class EventState extends State {
  const EventState({
    required super.name,
    required super.type,
    super.value,
  });

  factory EventState.fromJson(Map<String, dynamic> json) {
    return EventState(
      name: json['name'] as String,
      type: State._dataTypeFromJson(json['type']),
      value: json['value'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': State._dataTypeToJson(type),
      'value': value,
    };
  }
}