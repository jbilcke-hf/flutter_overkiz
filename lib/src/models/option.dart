class OptionParameter {
  const OptionParameter({
    required this.name,
    required this.value,
  });

  factory OptionParameter.fromJson(Map<String, dynamic> json) {
    return OptionParameter(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }

  final String name;
  final String value;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }

  @override
  String toString() => 'OptionParameter(name: $name, value: $value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionParameter &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => Object.hash(name, value);
}

class Option {
  const Option({
    required this.creationTime,
    required this.lastUpdateTime,
    required this.optionId,
    required this.startDate,
    this.parameters = const [],
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      creationTime: json['creation_time'] as int,
      lastUpdateTime: json['last_update_time'] as int,
      optionId: json['option_id'] as String,
      startDate: json['start_date'] as int,
      parameters: (json['parameters'] as List<dynamic>? ?? [])
          .map((e) => OptionParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int creationTime;
  final int lastUpdateTime;
  final String optionId;
  final int startDate;
  final List<OptionParameter> parameters;

  Map<String, dynamic> toJson() {
    return {
      'creation_time': creationTime,
      'last_update_time': lastUpdateTime,
      'option_id': optionId,
      'start_date': startDate,
      'parameters': parameters.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() => 'Option(optionId: $optionId, startDate: $startDate)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Option &&
          runtimeType == other.runtimeType &&
          optionId == other.optionId;

  @override
  int get hashCode => optionId.hashCode;
}