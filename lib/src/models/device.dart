import '../enums/general.dart';
import '../enums/ui.dart';
import '../enums/protocol.dart';
import 'state.dart';

class StateDefinition {
  const StateDefinition({
    required this.qualifiedName,
    this.type,
    this.values,
  });

  factory StateDefinition.fromJson(Map<String, dynamic> json) {
    return StateDefinition(
      qualifiedName: json['qualified_name'] as String,
      type: json['type'] as String?,
      values: (json['values'] as List<dynamic>?)?.cast<String>(),
    );
  }

  final String qualifiedName;
  final String? type;
  final List<String>? values;

  Map<String, dynamic> toJson() {
    return {
      'qualified_name': qualifiedName,
      'type': type,
      'values': values,
    };
  }
}

class CommandDefinition {
  const CommandDefinition({
    required this.commandName,
    required this.nparams,
  });

  factory CommandDefinition.fromJson(Map<String, dynamic> json) {
    return CommandDefinition(
      commandName: json['command_name'] as String,
      nparams: json['nparams'] as int,
    );
  }

  final String commandName;
  final int nparams;

  Map<String, dynamic> toJson() {
    return {
      'command_name': commandName,
      'nparams': nparams,
    };
  }
}

class Definition {
  const Definition({
    required this.commands,
    this.states,
    this.widgetName,
    this.uiClass,
    this.qualifiedName,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      commands: (json['commands'] as List<dynamic>)
          .map((e) => CommandDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StateDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      widgetName: json['widget_name'] as String?,
      uiClass: json['ui_class'] as String?,
      qualifiedName: json['qualified_name'] as String?,
    );
  }

  final List<CommandDefinition> commands;
  final List<StateDefinition>? states;
  final String? widgetName;
  final String? uiClass;
  final String? qualifiedName;

  Map<String, dynamic> toJson() {
    return {
      'commands': commands.map((e) => e.toJson()).toList(),
      'states': states?.map((e) => e.toJson()).toList(),
      'widget_name': widgetName,
      'ui_class': uiClass,
      'qualified_name': qualifiedName,
    };
  }
}

class Device {
  const Device({
    required this.id,
    required this.attributes,
    required this.available,
    required this.enabled,
    required this.label,
    required this.deviceUrl,
    required this.controllableName,
    required this.definition,
    required this.widget,
    required this.uiClass,
    required this.states,
    required this.type,
    this.gatewayId,
    this.deviceAddress,
    this.subsystemId,
    this.isSubDevice = false,
    this.dataProperties,
    this.placeOid,
    this.protocol,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      attributes: (json['attributes'] as List<dynamic>)
          .map((e) => State.fromJson(e as Map<String, dynamic>))
          .toList(),
      available: json['available'] as bool,
      enabled: json['enabled'] as bool,
      label: json['label'] as String,
      deviceUrl: json['device_url'] as String,
      controllableName: json['controllable_name'] as String,
      definition: Definition.fromJson(json['definition'] as Map<String, dynamic>),
      dataProperties: (json['data_properties'] as List<dynamic>?)
          ?.cast<Map<String, dynamic>>(),
      widget: _uiWidgetFromJson(json['widget']),
      uiClass: _uiClassFromJson(json['ui_class']),
      states: (json['states'] as List<dynamic>)
          .map((e) => State.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: _productTypeFromJson(json['type']),
      placeOid: json['place_oid'] as String?,
      gatewayId: json['gateway_id'] as String?,
      deviceAddress: json['device_address'] as String?,
      subsystemId: json['subsystem_id'] as int?,
      isSubDevice: json['is_sub_device'] as bool? ?? false,
      protocol: _protocolFromJson(json['protocol']),
    );
  }

  final String id;
  final List<State> attributes;
  final bool available;
  final bool enabled;
  final String label;
  final String deviceUrl;
  final String controllableName;
  final Definition definition;
  final List<Map<String, dynamic>>? dataProperties;
  final UIWidget widget;
  final UIClass uiClass;
  final List<State> states;
  final ProductType type;
  final String? placeOid;
  final String? gatewayId;
  final String? deviceAddress;
  final int? subsystemId;
  final bool isSubDevice;
  final Protocol? protocol;

  static UIWidget _uiWidgetFromJson(dynamic widget) {
    if (widget is String) return UIWidget.fromString(widget);
    return UIWidget.unknown;
  }

  static String _uiWidgetToJson(UIWidget widget) => widget.value;

  static UIClass _uiClassFromJson(dynamic uiClass) {
    if (uiClass is String) return UIClass.fromString(uiClass);
    return UIClass.unknown;
  }

  static String _uiClassToJson(UIClass uiClass) => uiClass.value;

  static ProductType _productTypeFromJson(dynamic type) {
    if (type is int) return ProductType.fromInt(type);
    return ProductType.actuator;
  }

  static int _productTypeToJson(ProductType type) => type.value;

  static Protocol? _protocolFromJson(dynamic protocol) {
    if (protocol is String) return Protocol.fromString(protocol);
    return null;
  }

  static String? _protocolToJson(Protocol? protocol) => protocol?.value;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.map((e) => e.toJson()).toList(),
      'available': available,
      'enabled': enabled,
      'label': label,
      'device_url': deviceUrl,
      'controllable_name': controllableName,
      'definition': definition.toJson(),
      'data_properties': dataProperties,
      'widget': _uiWidgetToJson(widget),
      'ui_class': _uiClassToJson(uiClass),
      'states': states.map((e) => e.toJson()).toList(),
      'type': _productTypeToJson(type),
      'place_oid': placeOid,
      'gateway_id': gatewayId,
      'device_address': deviceAddress,
      'subsystem_id': subsystemId,
      'is_sub_device': isSubDevice,
      'protocol': _protocolToJson(protocol),
    };
  }

  @override
  String toString() => 'Device(id: $id, label: $label, controllableName: $controllableName)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          deviceUrl == other.deviceUrl;

  @override
  int get hashCode => Object.hash(id, deviceUrl);
}