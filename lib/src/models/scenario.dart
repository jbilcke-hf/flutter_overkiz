class Scenario {
  const Scenario({
    required this.label,
    required this.oid,
  });

  factory Scenario.fromJson(Map<String, dynamic> json) {
    return Scenario(
      label: json['label'] as String,
      oid: json['oid'] as String,
    );
  }

  final String label;
  final String oid;

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'oid': oid,
    };
  }

  @override
  String toString() => 'Scenario(label: $label, oid: $oid)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Scenario &&
          runtimeType == other.runtimeType &&
          oid == other.oid;

  @override
  int get hashCode => oid.hashCode;
}