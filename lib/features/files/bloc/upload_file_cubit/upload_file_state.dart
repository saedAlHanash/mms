part of 'upload_file_cubit.dart';

class FileInitial extends AbstractState<FileResponse> {
  @override
  final UploadFile? request;

  // final bool fileParam;

  const FileInitial({
    required super.result,
    super.error,
    this.request,
    // required this.fileParam,
    super.statuses,
  });

  factory FileInitial.initial() {
    return FileInitial(
      result: FileResponse.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  FileInitial copyWith({
    CubitStatuses? statuses,
    FileResponse? result,
    String? error,
    UploadFile? request,
    // bool? fileParam,
  }) {
    return FileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // fileParam: fileParam ?? this.fileParam,
    );
  }
}
