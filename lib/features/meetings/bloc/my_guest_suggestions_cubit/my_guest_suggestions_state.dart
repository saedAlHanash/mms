part of 'my_guest_suggestions_cubit.dart';

class MyGuestSuggestionsInitial extends AbstractState<List<GuestSuggestionItem>> {
  const MyGuestSuggestionsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
    required this.deletingId,
  });

  final String meetingId;

  /// The suggestion being withdrawn, for its loading state.
  final String deletingId;

  factory MyGuestSuggestionsInitial.initial() {
    return const MyGuestSuggestionsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
      deletingId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId, deletingId];

  MyGuestSuggestionsInitial copyWith({
    CubitStatuses? statuses,
    List<GuestSuggestionItem>? result,
    String? error,
    String? meetingId,
    String? deletingId,
  }) {
    return MyGuestSuggestionsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
      deletingId: deletingId ?? this.deletingId,
    );
  }
}
