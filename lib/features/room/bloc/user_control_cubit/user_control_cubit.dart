import 'package:livekit_client/livekit_client.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../data/request/change_track_request.dart';
import '../../data/request/update_participant_request.dart';

part 'user_control_state.dart';

class UserControlCubit extends MCubit<UserControlInitial> {
  UserControlCubit() : super(UserControlInitial.initial());

  @override
  get mState => state;

  final _hostName = 'coretik-be.coretech-mena.com';
  final _additional = '/api/v1/';

  Future<void> suspend(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.suspend,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> resume(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.resume,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> suspendAll() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.suspendAll,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson(),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> resumeAll() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.resumeAll,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson(),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> allowScreenShare(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.allowScreenShare,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> stopScreenShare(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.stopScreenShare,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> allowCamera(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.allowCamera,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> stopCamera(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.stopCamera,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> allowAudio(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.allowAudio,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> stopAudio(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final result = await APIService().callApi(
      url: PostUrl.stopAudio,
      hostName: _hostName,
      additional: _additional,
      type: ApiType.post,
      body: state.updateRequest.toJson()..addAll({'identity': userId}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> revoke(Participant participant, PermissionType type) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: participant));
    final result = await APIService().callApi(
      url: 'Index/UpdateParticipant',
      type: ApiType.post,
      hostName: _hostName,
      additional: _additional,
      body: state.updateRequest.toJson()
        ..addAll(
          type.revokePermissions(participant),
        ),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> grant(Participant participant, PermissionType type) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: participant));
    final result = await APIService().callApi(
      url: 'Index/UpdateParticipant',
      type: ApiType.post,
      hostName: _hostName,
      additional: _additional,
      body: state.updateRequest.toJson()
        ..addAll(
          type.grantPermissions(participant),
        ),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }

  Future<void> kick(String participant) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: participant));
    final result = await APIService().callApi(
      url: PostUrl.kick,
      type: ApiType.post,
      hostName: _hostName,
      additional: _additional,
      body: state.updateRequest.toJson()..addAll({'identity': participant}),
    );
    emit(state.copyWith(statuses: result.statusCode.success ? CubitStatuses.done : CubitStatuses.error));
  }
}
