
import 'package:mms/core/extensions/extensions.dart';

class OsmNameModel {
  OsmNameModel({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.address,
    required this.boundingbox,
  });

  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String displayName;
  final Address address;
  final List<String> boundingbox;

  factory OsmNameModel.fromJson(Map<String, dynamic> json) {
    return OsmNameModel(
      placeId: json["place_id"] ?? 0,
      licence: json["licence"] ?? "",
      osmType: json["osm_type"] ?? "",
      osmId: json["osm_id"] ?? 0,
      lat: json["lat"] ?? "",
      lon: json["lon"] ?? "",
      displayName: json["display_name"] ?? "",
      address: Address.fromJson(json["address"] ?? {}),
      boundingbox: json["boundingbox"] == null
          ? []
          : List<String>.from(json["boundingbox"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "address": address.toJson(),
        "boundingbox": boundingbox.map((x) => x).toList(),
      };
}

class Address {
  Address({
    required this.shop,
    required this.road,
    required this.county,
    required this.stateDistrict,
    required this.state,
    required this.suburb,
    required this.country,
    required this.countryCode,
  });

  final String shop;
  final String road;
  final String county;
  final String stateDistrict;
  final String state;
  final String suburb;
  final String country;
  final String countryCode;

  String getName() {
    return '$road $county $suburb $stateDistrict $shop'.removeDuplicates;
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      shop: json["shop"] ?? "",
      road: json["road"] ?? "",
      county: json["county"] ?? "",
      stateDistrict: json["state_district"] ?? "",
      state: json["state"] ?? "",
      suburb: json["suburb"] ?? "",
      country: json["country"] ?? "",
      countryCode: json["country_code"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "shop": shop,
        "road": road,
        "county": county,
        "state_district": stateDistrict,
        "state": state,
        "suburb": suburb,
        "country": country,
        "country_code": countryCode,
      };
}
