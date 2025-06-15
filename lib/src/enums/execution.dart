enum ExecutionType {
  immediateExecution('IMMEDIATE_EXECUTION'),
  delayedExecution('DELAYED_EXECUTION'),
  technicalExecution('TECHNICAL_EXECUTION'),
  planning('PLANNING'),
  scenarioExecution('SCENARIO_EXECUTION'),
  recurrentExecution('RECURRENT_EXECUTION'),
  scheduledExecution('SCHEDULED_EXECUTION');

  const ExecutionType(this.value);

  final String value;

  static ExecutionType fromString(String value) {
    for (ExecutionType type in ExecutionType.values) {
      if (type.value == value) return type;
    }
    return ExecutionType.immediateExecution;
  }
}

enum ExecutionState {
  initialized('INITIALIZED'),
  notTransmitted('NOT_TRANSMITTED'),
  transmitted('TRANSMITTED'),
  inProgress('IN_PROGRESS'),
  completed('COMPLETED'),
  failed('FAILED'),
  cancelled('CANCELLED'),
  queued('QUEUED'),
  unknown('UNKNOWN');

  const ExecutionState(this.value);

  final String value;

  static ExecutionState fromString(String value) {
    for (ExecutionState state in ExecutionState.values) {
      if (state.value == value) return state;
    }
    return ExecutionState.unknown;
  }
}

enum ExecutionSubType {
  actionGroup('ACTION_GROUP'),
  manualControl('MANUAL_CONTROL'),
  basicScenario('BASIC_SCENARIO'),
  advancedScenario('ADVANCED_SCENARIO'),
  timeTrigger('TIME_TRIGGER'),
  sensorTrigger('SENSOR_TRIGGER'),
  weatherTrigger('WEATHER_TRIGGER'),
  calendarTrigger('CALENDAR_TRIGGER'),
  astroTrigger('ASTRO_TRIGGER'),
  securityTrigger('SECURITY_TRIGGER'),
  recurrentSchedule('RECURRENT_SCHEDULE'),
  presenceTrigger('PRESENCE_TRIGGER'),
  zoneExtension('ZONE_EXTENSION'),
  ioDevice('IO_DEVICE'),
  installation('INSTALLATION'),
  unknown('UNKNOWN');

  const ExecutionSubType(this.value);

  final String value;

  static ExecutionSubType fromString(String value) {
    for (ExecutionSubType type in ExecutionSubType.values) {
      if (type.value == value) return type;
    }
    return ExecutionSubType.unknown;
  }
}