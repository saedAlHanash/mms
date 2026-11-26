part of 'option_voters_cubit.dart';

class OptionVotersInitial extends AbstractState<Map<String, List<OptionVoter>>> {
  const OptionVotersInitial({required super.result, super.error, super.statuses});

  factory OptionVotersInitial.initial() {
    return const OptionVotersInitial(result: {}, error: '', statuses: CubitStatuses.init);
  }

  @override
  List<Object> get props => [statuses, result, error];

  OptionVotersInitial copyWith({
    CubitStatuses? statuses,
    Map<String, List<OptionVoter>>? result,
    String? error,
  }) {
    return OptionVotersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
