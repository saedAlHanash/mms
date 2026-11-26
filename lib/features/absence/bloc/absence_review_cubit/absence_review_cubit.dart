import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';

part 'absence_review_state.dart';

/// The chair accepting or rejecting absence requests (`PATCH AbsenceRequest/UpdateStatus`).
/// The requests themselves come with the meeting (`Meeting/GetDetails → absenceRequests`).
class AbsenceReviewCubit extends Cubit<AbsenceReviewInitial> {
  AbsenceReviewCubit() : super(AbsenceReviewInitial.initial());

  Future<bool> accept(String id) => _update(id, AbsenceStatus.accepted);

  Future<bool> reject(String id) => _update(id, AbsenceStatus.rejected);

  Future<bool> _update(String id, AbsenceStatus status) async {
    if (state.busyId.isNotEmpty) return false;
    emit(state.copyWith(busyId: id));

    final response = await APIService().callApi(
      type: ApiType.patch,
      url: PatchUrl.updateAbsenceStatus,
      body: {'id': id, 'status': status.index},
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      // Shown at once; the meeting refetch confirms it.
      emit(state.copyWith(busyId: '', answered: {...state.answered, id: status}));
      return true;
    }

    emit(state.copyWith(busyId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
}
