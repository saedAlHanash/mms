
import 'package:m_cubit/m_cubit.dart';

import '../../data/request/change_track_request.dart';
import '../../data/request/update_participant_request.dart';

part 'user_control_state.dart';

class UserControlCubit extends MCubit<UserControlInitial> {
  UserControlCubit() : super(UserControlInitial.initial());

  @override
  get mState => state;

  // Future<void> suspend(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.suspend,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> resume(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.resume,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> suspendAll() async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.suspendAll,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson(),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> resumeAll() async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.resumeAll,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson(),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> allowScreenShare(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.allowScreenShare,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> stopScreenShare(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.stopScreenShare,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> allowCamera(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.allowCamera,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> stopCamera(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.stopCamera,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> allowAudio(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.allowAudio,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> stopAudio(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.stopAudio,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
  //
  // Future<void> kick(String userId) async {
  //   emit(state.copyWith(statuses: CubitStatuses.loading));
  //   final result = await APIService().callApi(
  //     url: PostUrl.Kick,
  //     type: ApiType.post,
  //     body: state.updateRequest.toJson()..addAll({'identity': userId}),
  //   );
  //   emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  // }
}
