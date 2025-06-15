enum UIClass {
  rollerShutter('RollerShutter'),
  temperatureSensor('TemperatureSensor'),
  heatingSystem('HeatingSystem'),
  lightSensor('LightSensor'),
  waterSensor('WaterSensor'),
  smokeSensor('SmokeSensor'),
  motionSensor('MotionSensor'),
  contactSensor('ContactSensor'),
  window('Window'),
  garageDoor('GarageDoor'),
  light('Light'),
  dimmableLight('DimmableLight'),
  deviceSwitch('Switch'),
  thermostat('Thermostat'),
  fan('Fan'),
  siren('Siren'),
  lock('Lock'),
  valve('Valve'),
  weatherStation('WeatherStation'),
  camera('Camera'),
  remoteControl('RemoteControl'),
  electricalMeter('ElectricalMeter'),
  waterMeter('WaterMeter'),
  gasMeter('GasMeter'),
  heatMeter('HeatMeter'),
  shutter('Shutter'),
  pergola('Pergola'),
  awning('Awning'),
  screen('Screen'),
  curtain('Curtain'),
  exteriorScreen('ExteriorScreen'),
  exteriorVenetianBlind('ExteriorVenetianBlind'),
  unknown('Unknown');

  const UIClass(this.value);

  final String value;

  static UIClass fromString(String value) {
    for (UIClass uiClass in UIClass.values) {
      if (uiClass.value == value) return uiClass;
    }
    return UIClass.unknown;
  }
}

enum UIWidget {
  atlanticElectricalHeater('AtlanticElectricalHeater'),
  positionableRollerShutter('PositionableRollerShutter'),
  somfyThermostat('SomfyThermostat'),
  standardThermostat('StandardThermostat'),
  onOffLight('OnOffLight'),
  dimmableLight('DimmableLight'),
  temperatureSensor('TemperatureSensor'),
  humiditySensor('HumiditySensor'),
  lightSensor('LightSensor'),
  motionSensor('MotionSensor'),
  contactSensor('ContactSensor'),
  smokeSensor('SmokeSensor'),
  waterSensor('WaterSensor'),
  garageDoorOpener('GarageDoorOpener'),
  rollerShutter('RollerShutter'),
  window('Window'),
  deviceSwitch('Switch'),
  electricalMeter('ElectricalMeter'),
  weatherStation('WeatherStation'),
  camera('Camera'),
  siren('Siren'),
  lock('Lock'),
  valve('Valve'),
  fan('Fan'),
  shutter('Shutter'),
  awning('Awning'),
  screen('Screen'),
  curtain('Curtain'),
  pergola('Pergola'),
  exteriorScreen('ExteriorScreen'),
  exteriorVenetianBlind('ExteriorVenetianBlind'),
  remoteControl('RemoteControl'),
  waterMeter('WaterMeter'),
  gasMeter('GasMeter'),
  heatMeter('HeatMeter'),
  unknown('Unknown');

  const UIWidget(this.value);

  final String value;

  static UIWidget fromString(String value) {
    for (UIWidget widget in UIWidget.values) {
      if (widget.value == value) return widget;
    }
    return UIWidget.unknown;
  }
}