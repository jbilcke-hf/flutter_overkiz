enum Protocol {
  rts('rts'),
  io('io'),
  zigbee('zigbee'),
  zwave('zwave'),
  enocean('enocean'),
  knx('knx'),
  modbus('modbus'),
  bacnet('bacnet'),
  mqtt('mqtt'),
  upnp('upnp'),
  rtds('rtds'),
  ogp('ogp'),
  internal('internal'),
  hue('hue'),
  netatmo('netatmo'),
  velux('velux'),
  somfyThermostat('somfy_thermostat'),
  homeKit('homekit'),
  eliot('eliot'),
  zigbee3('zigbee3'),
  myfox('myfox'),
  hiKumo('hi_kumo'),
  atlantic('atlantic'),
  somfyLink('somfy_link'),
  zigbeeGP('zigbee_gp'),
  daikin('daikin'),
  panasonic('panasonic'),
  tuya('tuya'),
  tiko('tiko'),
  unknown('unknown');

  const Protocol(this.value);

  final String value;

  static Protocol fromString(String value) {
    for (Protocol protocol in Protocol.values) {
      if (protocol.value == value) return protocol;
    }
    return Protocol.unknown;
  }
}