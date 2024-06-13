import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/add_comment_request.dart';
import '../../data/response/agendas_response.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentInitial> {
  AddCommentCubit() : super(AddCommentInitial.initial());

  Future<void> addComment() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _getDataApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: PostUrl.addComment,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setText(String? val) => state.request.text = val;

  set setAgendaId(String? val) => state.request.agendaItemId = val;

}
