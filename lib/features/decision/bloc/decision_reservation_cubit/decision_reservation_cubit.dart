import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';

part 'decision_reservation_state.dart';

/// A member reserving on a meeting decision (`Decision/ReserveDecision`) or
/// withdrawing it (`Decision/WithdrawReservation`). The page refetches the meeting after.
class DecisionReservationCubit extends Cubit<DecisionReservationInitial> {
  DecisionReservationCubit() : super(DecisionReservationInitial.initial());

  Future<bool> reserve(String decisionId, {required String reason}) => _send(
        decisionId,
        () => APIService().callApi(
          type: ApiType.post,
          url: PostUrl.reserveDecision,
          body: {'id': decisionId, 'partyId': AppProvider.getParty.id, 'reason': reason.trim()},
        ),
      );

  Future<bool> withdraw(String decisionId) => _send(
        decisionId,
        () => APIService().callApi(
          type: ApiType.delete,
          url: DeleteUrl.withdrawReservation,
          query: {'decisionId': decisionId, 'partyId': AppProvider.getParty.id},
        ),
      );

  Future<bool> _send(String decisionId, Future<http.Response> Function() call) async {
    if (state.busyId.isNotEmpty) return false;
    emit(state.copyWith(busyId: decisionId));

    final response = await call();
    if (isClosed) return false;

    if (response.statusCode.success) {
      emit(state.copyWith(busyId: ''));
      return true;
    }
    emit(state.copyWith(busyId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
}
