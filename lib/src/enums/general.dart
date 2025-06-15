enum ProductType {
  actuator(1),
  sensor(2),
  beacon(3),
  remoteController(4),
  gateway(5),
  onOffLight(6),
  dimmableLight(7),
  protocolGateway(8);

  const ProductType(this.value);

  final int value;

  static ProductType fromInt(int value) {
    for (ProductType type in ProductType.values) {
      if (type.value == value) return type;
    }
    return ProductType.actuator;
  }
}

enum DataType {
  none(0),
  integer(1),
  float(2),
  string(3),
  date(4),
  blob(5),
  boolean(6),
  jsonArray(7),
  jsonObject(8);

  const DataType(this.value);

  final int value;

  static DataType fromInt(int value) {
    for (DataType type in DataType.values) {
      if (type.value == value) return type;
    }
    return DataType.none;
  }
}

enum FailureType {
  noFailure(0),
  unknownFailure(-1),
  cmdNotFound(-2),
  cmdParameterInvalid(-3),
  cmdForbiddenPriority(-4),
  cmdImpossible(-5),
  tooManyCommands(-6),
  noSession(-7),
  unauthorizedCommand(-8),
  internalError(-9),
  busyDevice(-10),
  diskFull(-11),
  // Add more specific failures as needed - there are 247 total
  unknown(-999);

  const FailureType(this.value);

  final int value;

  static FailureType fromInt(int value) {
    for (FailureType type in FailureType.values) {
      if (type.value == value) return type;
    }
    return FailureType.unknown;
  }
}

enum EventName {
  devicesReloadedEvent('DevicesReloadedEvent'),
  deviceCreatedEvent('DeviceCreatedEvent'),
  deviceRemovedEvent('DeviceRemovedEvent'),
  deviceUpdatedEvent('DeviceUpdatedEvent'),
  deviceUnavailableEvent('DeviceUnavailableEvent'),
  deviceAvailableEvent('DeviceAvailableEvent'),
  deviceStateChangedEvent('DeviceStateChangedEvent'),
  deviceAttributeChangedEvent('DeviceAttributeChangedEvent'),
  executionStateChangedEvent('ExecutionStateChangedEvent'),
  executionRegisteredEvent('ExecutionRegisteredEvent'),
  gatewayAliveEvent('GatewayAliveEvent'),
  gatewayDownEvent('GatewayDownEvent'),
  commandExecutionStateChangedEvent('CommandExecutionStateChangedEvent'),
  refreshAllDevicesStatesCompletedEvent('RefreshAllDevicesStatesCompletedEvent'),
  unknown('UNKNOWN');

  const EventName(this.value);

  final String value;

  static EventName fromString(String value) {
    for (EventName event in EventName.values) {
      if (event.value == value) return event;
    }
    return EventName.unknown;
  }
}