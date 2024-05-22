part of 'add_comment_cubit.dart';

class AddCommentInitial extends AbstractCubit<bool> {
  final AddCommentRequest request;

  // final bool addCommentParam;

  const AddCommentInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.addCommentParam,
    super.statuses,
  });

  factory AddCommentInitial.initial() {
    return AddCommentInitial(
      result: false,
      error: '',
      // addCommentParam: false,
      request: AddCommentRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, request];

  AddCommentInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    AddCommentRequest? request,
    // bool? addCommentParam,
  }) {
    return AddCommentInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // addCommentParam: addCommentParam ?? this.addCommentParam,
    );
  }
}
