import 'dart:async';

import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_temp_request.dart';
import '../../data/response/temp_response.dart';

part 'create_temp_state.dart';

class CreateTempCubit extends Cubit<CreateTempInitial> {
  CreateTempCubit() : super(CreateTempInitial.initial());

  Future<void> createTemp() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _createTempApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Temp?, String?>> _createTempApi() async {
    late final Response response;
    if (!state.mRequest.id.isBlank) {
           response = await APIService().callApi(type: ApiType.put,
        url: PutUrl.updateTemp,
        query: {'id': state.mRequest.id},
        body: state.mRequest.toJson(),
      );
    } else {
           response = await APIService().callApi(type: ApiType.post,
        url: PostUrl.createTemp,
        body: state.mRequest.toJson(),
      );
    }

    if (response.statusCode.success) {
      return Pair(Temp.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }
}
