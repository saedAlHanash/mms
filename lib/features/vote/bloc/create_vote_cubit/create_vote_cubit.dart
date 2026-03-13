import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_vote_request.dart';
import '../../data/response/vote_response.dart';

part 'create_vote_state.dart';

class CreateVoteCubit extends Cubit<CreateVoteInitial> {
  CreateVoteCubit() : super(CreateVoteInitial.initial());

  Future<void> createVote({required CreateVoteRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _createVoteApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Vote?, String?>> _createVoteApi() async {
    late final Response response;
    if (!state.mRequest.id.isBlank) {
      response = await APIService().callApi(
        type: ApiType.put,
        url: PutUrl.updateVote,
        query: {'id': state.mRequest.id},
        body: state.mRequest.toJson(),
      );
    } else {
      response = await APIService().callApi(
        type: ApiType.post,
        url: PostUrl.createVote,
        body: state.mRequest.toJson(),
      );
    }

    if (response.statusCode.success) {
      return Pair(Vote.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }
}
