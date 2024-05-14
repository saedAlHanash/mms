part of 'document_cubit.dart';

class DocumentInitial extends AbstractCubit<Document> {
  // final DocumentRequest request;
  // final bool tempParam;

  const DocumentInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  });

  factory DocumentInitial.initial() {
    return DocumentInitial(
      result: Document.fromJson({}),
      error: '',
      // tempParam: false,
      // request: DocumentRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DocumentInitial copyWith({
    CubitStatuses? statuses,
    Document? result,
    String? error,
    // DocumentRequest? request,
    // bool? tempParam,
  }) {
    return DocumentInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
