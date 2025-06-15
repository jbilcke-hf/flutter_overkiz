/// Represents an OverKiz Command.
class Command {
  const Command({
    required this.name,
    this.parameters,
  });

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      name: json['name'] as String,
      parameters: json['parameters'] as List<dynamic>?,
    );
  }

  final String name;
  final List<dynamic>? parameters;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parameters': parameters,
    };
  }

  @override
  String toString() => 'Command(name: $name, parameters: $parameters)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Command &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          _listEquals(parameters, other.parameters);

  @override
  int get hashCode => Object.hash(name, parameters);

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}