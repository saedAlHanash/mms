import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/files/data/response/file_response.dart';

part 'upload_file_state.dart';

class FileCubit extends Cubit<FileInitial> {
  FileCubit() : super(FileInitial.initial());

  Future<void> uploadFile({required UploadFile request}) async {
    emit(state.copyWith(request: request, statuses: CubitStatuses.loading));

    final pair = await _getData();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<FileResponse?, String?>> _getData() async {
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
