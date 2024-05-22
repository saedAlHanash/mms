import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mms/core/util/abstraction.dart';
import 'package:mms/services/location_service/location_service.dart';

import '../../../core/strings/enum_manager.dart';

part 'my_location_state.dart';

class LocationServiceCubit extends Cubit<LocationServiceInitial> {
  LocationServiceCubit() : super(LocationServiceInitial.initial());

  Future<void> getMyLocation() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await LocationService.getLocationInfo();
    emit(
      state.copyWith(
        locationName: result.second,
        statuses: CubitStatuses.done,
        result: result.first,
      ),
    );
  }

  Future<void> getUnLocation({LatLng? latLng}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await LocationService.getLocationInfo(latLng: latLng);
    emit(
      state.copyWith(
        locationName: result.second,
        statuses: CubitStatuses.done,
        result: result.first,
      ),
    );
  }
}
