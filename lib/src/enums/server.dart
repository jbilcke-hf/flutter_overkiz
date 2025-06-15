enum APIType {
  cloud('CLOUD'),
  local('LOCAL');

  const APIType(this.value);

  final String value;

  static APIType fromString(String value) {
    for (APIType type in APIType.values) {
      if (type.value == value) return type;
    }
    return APIType.cloud;
  }
}

enum Server {
  atlanticCozytouch('ATLANTIC_COZYTOUCH'),
  brandt('BRANDT'),
  flexom('FLEXOM'),
  hexaomHexaconnect('HEXAOM_HEXACONNECT'),
  hiKumoAsia('HI_KUMO_ASIA'),
  hiKumoEurope('HI_KUMO_EUROPE'),
  hiKumoOceania('HI_KUMO_OCEANIA'),
  nexity('NEXITY'),
  rexel('REXEL'),
  sauterCozytouch('SAUTER_COZYTOUCH'),
  simuLivein2('SIMU_LIVEIN2'),
  somfyEurope('SOMFY_EUROPE'),
  somfyAmerica('SOMFY_AMERICA'),
  somfyOceania('SOMFY_OCEANIA'),
  thermorCozytouch('THERMOR_COZYTOUCH'),
  ubiwizz('UBIWIZZ');

  const Server(this.value);

  final String value;

  static Server fromString(String value) {
    for (Server server in Server.values) {
      if (server.value == value) return server;
    }
    return Server.somfyEurope;
  }
}