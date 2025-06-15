enum GatewayType {
  unknown(0),
  central(1),
  local(2),
  rts(3),
  kizboxMini(4),
  kizboxV2(5),
  tahoma(15),
  kizos(17),
  cozytouch(32),
  connexoon(34),
  connexoonRts(37),
  kizbox(51),
  tahomaSwitch(57),
  valveRadiatorHead(54);

  const GatewayType(this.value);

  final int value;

  static GatewayType fromInt(int value) {
    for (GatewayType type in GatewayType.values) {
      if (type.value == value) return type;
    }
    return GatewayType.unknown;
  }
}

enum GatewaySubType {
  unknown(0),
  tahomaBasic(1),
  tahomaPremium(2),
  tahomaSerenity(3),
  tahomaV2Basic(4),
  tahomaV2Premium(5),
  tahomaV2Serenity(6),
  somfyBox(7),
  connexoonBasic(8),
  connexoonPremium(9),
  tahomaSwitch(10),
  cozytouchBasic(11),
  connexoonRts(12),
  connexoonIo(13),
  kizosBasic(14),
  kizboxMini(15),
  connexoonWindow(16);

  const GatewaySubType(this.value);

  final int value;

  static GatewaySubType fromInt(int value) {
    for (GatewaySubType type in GatewaySubType.values) {
      if (type.value == value) return type;
    }
    return GatewaySubType.unknown;
  }
}

enum UpdateBoxStatus {
  upToDate('UP_TO_DATE'),
  updating('UPDATING'),
  readyToUpdate('READY_TO_UPDATE'),
  updateFailed('UPDATE_FAILED'),
  updateAvailable('UPDATE_AVAILABLE'),
  updateScheduled('UPDATE_SCHEDULED'),
  unknown('UNKNOWN');

  const UpdateBoxStatus(this.value);

  final String value;

  static UpdateBoxStatus fromString(String value) {
    for (UpdateBoxStatus status in UpdateBoxStatus.values) {
      if (status.value == value) return status;
    }
    return UpdateBoxStatus.unknown;
  }
}