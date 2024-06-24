import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/file_response.dart';

part 'upload_file_state.dart';

class FileCubit extends Cubit<FileInitial> {
  FileCubit() : super(FileInitial.initial());

  Future<void> uploadFile({required UploadFile request}) async {
    emit(state.copyWith(request: request, statuses: CubitStatuses.loading));

    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<FileResponse?, String?>> _getDataApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.uploadFile,
      files: [state.request],
    );

    if (response.statusCode.success) {
      return Pair(FileResponse.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }
}
