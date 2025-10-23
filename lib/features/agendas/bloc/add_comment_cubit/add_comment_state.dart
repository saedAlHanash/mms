part of 'add_comment_cubit.dart';

class AddCommentInitial extends AbstractState<bool> {
  @override
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

  Comment get getAddedComment => Comment.fromJson(
        {
          "id": 'id',
          "text": request.text,
          "date": DateTime.now().toIso8601String(),
          "partyId": AppProvider.getParty.id,
          "party": AppProvider.getParty.toJson(),
          "agendaItemId": request.agendaItemId,
        },
      );

  DiscussionComment get getAddedDiscussionComment => DiscussionComment.fromJson(
        {
          "id": 'id',
          "text": request.text,
          "date": DateTime.now().toIso8601String(),
          "partyId": AppProvider.getParty.id,
          "party": AppProvider.getParty.toJson(),
          "discussionId": request.discussionId,
        },
      );
}
