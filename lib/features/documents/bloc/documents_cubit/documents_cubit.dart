import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/documents_response.dart';

part 'documents_state.dart';

class DocumentsCubit extends MCubit<DocumentsInitial> {
  DocumentsCubit() : super(DocumentsInitial.initial());

  @override
  String get nameCache => 'temp';

  @override
  String get filter => '';

  Future<void> getData({bool? newData}) async {
    await getDataAbstract(
      fromJson: Document.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Document>?, String?>> _getData() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.temp);

    if (response.statusCode.success) {
      return Pair([], null);
    } else {
      return response.getPairError;
    }
  }
}
