import 'dart:async';

import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'delete_poll_state.dart';

class DeletePollCubit extends Cubit<DeletePollInitial> {
  DeletePollCubit() : super(DeletePollInitial.initial());

  Future<void> deletePoll({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: id));

    final pair = await _deletePollApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deletePollApi() async {
       final  response = await APIService().callApi(type: ApiType.delete,
      url: DeleteUrl.deletePoll,
      query: {'id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
