import 'package:e_move/core/api_manager/api_url.dart';
import 'package:e_move/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../services/caching_service/caching_service.dart';
import '../../data/response/educational_grade_response.dart';

part 'educational_grade_state.dart';

class EducationalGradeCubit extends MCubit<EducationalGradeInitial> {
  EducationalGradeCubit() : super(EducationalGradeInitial.initial());

  @override
  String get nameCache => GetUrl.educationalGrade;

  Future<void> getEducationalGrade() async {

    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: !cacheType.haveData
            ? null
            : (await CachingService.getList(GetUrl.educationalGrade))
                .map((e) => EducationalGrade.fromJson(e))
                .toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return;

    final pair = await _bookedAppointmentsApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      storeData(pair.first!);
    }
  }

  Future<Pair<List<EducationalGrade>?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().getApi(url: GetUrl.educationalGrade);

    if (response.statusCode.success) {
      return Pair(EducationalGradeResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
