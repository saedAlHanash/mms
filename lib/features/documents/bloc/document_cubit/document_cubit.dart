import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/documents_response.dart';

part 'document_state.dart';

class DocumentCubit extends MCubit<DocumentInitial> {
  DocumentCubit() : super(DocumentInitial.initial());

  @override
  String get nameCache => 'temp';

  Future<void> getData() async {
    final pair = await _getData();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await saveData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Document?, String?>> _getData() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.temp);

    if (response.statusCode.success) {
      return Pair(Document.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
