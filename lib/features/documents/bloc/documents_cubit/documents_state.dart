part of 'documents_cubit.dart';

class DocumentsInitial extends AbstractState<List<Document>> {
  // final DocumentsRequest request;
  // final  bool tempParam;
  const DocumentsInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  }); //

  factory DocumentsInitial.initial() {
    return const DocumentsInitial(
      result: [],
      error: '',
      // tempParam: false,
      // request: DocumentsRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DocumentsInitial copyWith({
    CubitStatuses? statuses,
    List<Document>? result,
    String? error,
    // DocumentsRequest? request,
    // bool? tempParam,
  }) {
    return DocumentsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
