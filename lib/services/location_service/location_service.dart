import 'package:e_move/core/extensions/extensions.dart';
import 'package:e_move/services/show_messages_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/api_manager/api_service.dart';
import '../../core/app/app_widget.dart';
import '../../core/util/pair_class.dart';
import 'my_location_cubit/osm_name_model.dart';

class LocationService {
  ///if latLng parms is null will get location from GPS user divice
  static Future<Pair<LatLng, String>> getLocationInfo({LatLng? latLng}) async {
    // location from gps or parms

    final location = latLng ?? await getCurrentLocation;

    final locationName = await getLocationName(latLng: location);

    return Pair(location ?? const LatLng(0, 0), locationName);
  }

  static Future<LatLng?> get getCurrentLocation async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      ShowMessagesService.showErrorSnackBarServise('Location services are disabled.');
      return null;
    }

    if (!checkPermission(await Geolocator.requestPermission())) return null;

    final location = await Geolocator.getCurrentPosition();

    return LatLng(location.latitude, location.longitude);
  }

  static bool checkPermission(LocationPermission permission) {
    if (permission == LocationPermission.deniedForever) {
      ShowMessagesService.showErrorSnackBarServise(
        'Location permissions are permanently denied, '
        'we cannot request permissions.',
      );

      Future.delayed(
        const Duration(seconds: 1),
        () => Geolocator.openAppSettings(),
      );

      return false;
    }
    if (permission == LocationPermission.denied) {
      ShowMessagesService.showErrorSnackBarServise('Location permissions are denied');
      return false;
    }
    return true;
  }

  static Future<String> getLocationName({required LatLng? latLng}) async {
    if (latLng == null) return '';
    final response = await APIService().getApi(
      url: 'reverse',
      hostName: 'nominatim.openstreetmap.org',
      query: {
        'lat': '${latLng.latitude}',
        'lon': '${latLng.longitude}',
        'format': 'json',
      },
      header: {"Accept": "application/json", "User-Agent": "android"},
    );

    if (response.statusCode == 200) {
      final result = OsmNameModel.fromJson(response.jsonBodyPure);
      return result.displayName;
    }
    return '';
  }
}
