import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/compliance/data/response/compliance_response.dart';

part 'compliance_state.dart';

/// A committee's attendance compliance for a year (`Compliance/GetStatus`).
class ComplianceCubit extends Cubit<ComplianceInitial> {
  ComplianceCubit() : super(ComplianceInitial.initial());

  Future<void> getData({String? committeeId, int? year}) async {
    final id = committeeId ?? state.committeeId;
    final y = year ?? state.year;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, committeeId: id, year: y));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.complianceStatus,
      query: {'committeeId': id, 'year': '$y'},
    );
    if (isClosed || state.year != y) return;

    if (response.statusCode.success) {
      final body = response.jsonBody;
      final map = body['data'] is Map<String, dynamic> ? body['data'] as Map<String, dynamic> : body;
      emit(state.copyWith(statuses: CubitStatuses.done, result: ComplianceStatus.fromJson(map)));
    } else {
      emit(state.copyWith(
        statuses: CubitStatuses.error,
        result: ComplianceStatus.empty,
        error: response.getPairError.second,
      ));
    }
  }
}
