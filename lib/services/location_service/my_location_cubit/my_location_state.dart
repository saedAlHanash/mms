// part of 'my_location_cubit.dart';
//
// class LocationServiceInitial extends AbstractState<LatLng> {
//   final String locationName;
//
//   const LocationServiceInitial({
//     required super.result,
//     super.error,
//     super.statuses,
//     required this.locationName,
//   });
//
//   factory LocationServiceInitial.initial() {
//     return const LocationServiceInitial(
//       result: LatLng(0, 0),
//       locationName: '',
//       // moveMap: false,
//       statuses: CubitStatuses.init,
//     );
//   }
//
//   @override
//   List<Object> get props => [statuses, result, error];
//
//   LocationServiceInitial copyWith({
//     LatLng? result,
//     CubitStatuses? statuses,
//     String? locationName,
//     // bool? moveMap,
//   }) {
//     return LocationServiceInitial(
//       result: result ?? this.result,
//       statuses: statuses ?? this.statuses,
//       locationName: locationName ?? this.locationName,
//       // moveMap: moveMap ?? this.moveMap,
//     );
//   }
// }
