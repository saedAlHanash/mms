import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/annual_report/data/response/annual_report_response.dart';

part 'annual_report_state.dart';

/// A committee's annual report (`Executive/GetAnnualReport`).
class AnnualReportCubit extends Cubit<AnnualReportInitial> {
  AnnualReportCubit() : super(AnnualReportInitial.initial());

  Future<void> getData({String? committeeId, int? year}) async {
    final id = committeeId ?? state.committeeId;
    final y = year ?? state.year;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, committeeId: id, year: y));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.annualReport,
      query: {'committeeId': id, 'year': '$y'},
    );
    if (isClosed || state.year != y) return;

    if (response.statusCode.success) {
      final body = response.jsonBody;
      final map = body['data'] is Map<String, dynamic> ? body['data'] as Map<String, dynamic> : body;
      emit(state.copyWith(statuses: CubitStatuses.done, result: AnnualReport.fromJson(map)));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, result: AnnualReport.empty, error: response.getPairError.second));
    }
  }
}
