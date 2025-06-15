import 'device.dart';
import 'gateway.dart';

class Location {
  const Location({
    required this.creationTime,
    required this.timezone,
    required this.twilightMode,
    required this.twilightAngle,
    required this.summerSolsticeDuskMinutes,
    required this.winterSolsticeDuskMinutes,
    required this.twilightOffsetEnabled,
    required this.dawnOffset,
    required this.duskOffset,
    this.lastUpdateTime,
    this.city,
    this.country,
    this.postalCode,
    this.addressLine1,
    this.addressLine2,
    this.longitude,
    this.latitude,
    this.twilightCity,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      creationTime: json['creation_time'] as String,
      lastUpdateTime: json['last_update_time'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      postalCode: json['postal_code'] as String?,
      addressLine1: json['address_line1'] as String?,
      addressLine2: json['address_line2'] as String?,
      timezone: json['timezone'] as String,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      twilightMode: json['twilight_mode'] as int,
      twilightAngle: json['twilight_angle'] as String,
      twilightCity: json['twilight_city'] as String?,
      summerSolsticeDuskMinutes: json['summer_solstice_dusk_minutes'] as String,
      winterSolsticeDuskMinutes: json['winter_solstice_dusk_minutes'] as String,
      twilightOffsetEnabled: json['twilight_offset_enabled'] as bool,
      dawnOffset: json['dawn_offset'] as int,
      duskOffset: json['dusk_offset'] as int,
    );
  }

  final String creationTime;
  final String? lastUpdateTime;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? addressLine1;
  final String? addressLine2;
  final String timezone;
  final String? longitude;
  final String? latitude;
  final int twilightMode;
  final String twilightAngle;
  final String? twilightCity;
  final String summerSolsticeDuskMinutes;
  final String winterSolsticeDuskMinutes;
  final bool twilightOffsetEnabled;
  final int dawnOffset;
  final int duskOffset;

  Map<String, dynamic> toJson() {
    return {
      'creation_time': creationTime,
      'last_update_time': lastUpdateTime,
      'city': city,
      'country': country,
      'postal_code': postalCode,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'timezone': timezone,
      'longitude': longitude,
      'latitude': latitude,
      'twilight_mode': twilightMode,
      'twilight_angle': twilightAngle,
      'twilight_city': twilightCity,
      'summer_solstice_dusk_minutes': summerSolsticeDuskMinutes,
      'winter_solstice_dusk_minutes': winterSolsticeDuskMinutes,
      'twilight_offset_enabled': twilightOffsetEnabled,
      'dawn_offset': dawnOffset,
      'dusk_offset': duskOffset,
    };
  }
}

class Feature {
  const Feature({
    required this.name,
    required this.source,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      name: json['name'] as String,
      source: json['source'] as String,
    );
  }

  final String name;
  final String source;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'source': source,
    };
  }
}

class ZoneItem {
  const ZoneItem({
    required this.itemType,
    required this.deviceOid,
    required this.deviceUrl,
  });

  factory ZoneItem.fromJson(Map<String, dynamic> json) {
    return ZoneItem(
      itemType: json['item_type'] as String,
      deviceOid: json['device_oid'] as String,
      deviceUrl: json['device_url'] as String,
    );
  }

  final String itemType;
  final String deviceOid;
  final String deviceUrl;

  Map<String, dynamic> toJson() {
    return {
      'item_type': itemType,
      'device_oid': deviceOid,
      'device_url': deviceUrl,
    };
  }
}

class Zone {
  const Zone({
    required this.lastUpdateTime,
    required this.label,
    required this.type,
    required this.oid,
    this.items,
    this.externalOid,
    this.metadata,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      lastUpdateTime: json['last_update_time'] as String,
      label: json['label'] as String,
      type: json['type'] as int,
      oid: json['oid'] as String,
      items: (json['items'] as List<dynamic>?)?.map((e) => ZoneItem.fromJson(e as Map<String, dynamic>)).toList(),
      externalOid: json['external_oid'] as String?,
      metadata: json['metadata'] as String?,
    );
  }

  final String lastUpdateTime;
  final String label;
  final int type;
  final List<ZoneItem>? items;
  final String? externalOid;
  final String? metadata;
  final String oid;

  Map<String, dynamic> toJson() {
    return {
      'last_update_time': lastUpdateTime,
      'label': label,
      'type': type,
      'oid': oid,
      'items': items?.map((e) => e.toJson()).toList(),
      'external_oid': externalOid,
      'metadata': metadata,
    };
  }
}

class Place {
  const Place({
    required this.creationTime,
    required this.label,
    required this.type,
    required this.id,
    required this.oid,
    this.lastUpdateTime,
    this.subPlaces = const [],
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      creationTime: json['creation_time'] as int,
      lastUpdateTime: json['last_update_time'] as int?,
      label: json['label'] as String,
      type: json['type'] as int,
      id: json['id'] as String,
      oid: json['oid'] as String,
      subPlaces: (json['sub_places'] as List<dynamic>? ?? [])
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int creationTime;
  final int? lastUpdateTime;
  final String label;
  final int type;
  final String id;
  final String oid;
  final List<Place> subPlaces;

  Map<String, dynamic> toJson() {
    return {
      'creation_time': creationTime,
      'last_update_time': lastUpdateTime,
      'label': label,
      'type': type,
      'id': id,
      'oid': oid,
      'sub_places': subPlaces.map((e) => e.toJson()).toList(),
    };
  }
}

class Setup {
  const Setup({
    required this.gateways,
    required this.devices,
    this.creationTime,
    this.lastUpdateTime,
    this.id,
    this.location,
    this.zones,
    this.resellerDelegationType,
    this.oid,
    this.rootPlace,
    this.features,
  });

  factory Setup.fromJson(Map<String, dynamic> json) {
    return Setup(
      creationTime: json['creation_time'] as String?,
      lastUpdateTime: json['last_update_time'] as String?,
      id: json['id'] as String?,
      location: json['location'] != null 
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      gateways: (json['gateways'] as List<dynamic>)
          .map((e) => Gateway.fromJson(e as Map<String, dynamic>))
          .toList(),
      devices: (json['devices'] as List<dynamic>)
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
      zones: (json['zones'] as List<dynamic>?)?.map((e) => Zone.fromJson(e as Map<String, dynamic>)).toList(),
      resellerDelegationType: json['reseller_delegation_type'] as String?,
      oid: json['oid'] as String?,
      rootPlace: json['root_place'] != null 
          ? Place.fromJson(json['root_place'] as Map<String, dynamic>)
          : null,
      features: (json['features'] as List<dynamic>?)?.map((e) => Feature.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  final String? creationTime;
  final String? lastUpdateTime;
  final String? id;
  final Location? location;
  final List<Gateway> gateways;
  final List<Device> devices;
  final List<Zone>? zones;
  final String? resellerDelegationType;
  final String? oid;
  final Place? rootPlace;
  final List<Feature>? features;

  Map<String, dynamic> toJson() {
    return {
      'creation_time': creationTime,
      'last_update_time': lastUpdateTime,
      'id': id,
      'location': location?.toJson(),
      'gateways': gateways.map((e) => e.toJson()).toList(),
      'devices': devices.map((e) => e.toJson()).toList(),
      'zones': zones?.map((e) => e.toJson()).toList(),
      'reseller_delegation_type': resellerDelegationType,
      'oid': oid,
      'root_place': rootPlace?.toJson(),
      'features': features?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() => 'Setup(id: $id, gateways: ${gateways.length}, devices: ${devices.length})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Setup &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}