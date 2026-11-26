part of 'minutes_cubit.dart';

class MinutesInitial extends AbstractState<MinuteApprovalPath?> {
  const MinutesInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.minuteId,
    required this.isLead,
    required this.myAnswer,
    required this.approvals,
    required this.sending,
  });

  final String minuteId;

  /// The chair or the secretary (everyone's answers are loaded).
  final bool isLead;
  final MinuteApproval? myAnswer;
  final List<MinuteApproval> approvals;
  final bool sending;

  factory MinutesInitial.initial() {
    return const MinutesInitial(
      result: null,
      error: '',
      statuses: CubitStatuses.init,
      minuteId: '',
      isLead: false,
      myAnswer: null,
      approvals: [],
      sending: false,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        error,
        minuteId,
        isLead,
        approvals,
        sending,
        identityHashCode(result),
        '${myAnswer?.isApproved}${myAnswer?.reason}',
      ];

  MinutesInitial copyWith({
    CubitStatuses? statuses,
    MinuteApprovalPath? result,
    String? error,
    String? minuteId,
    bool? isLead,
    MinuteApproval? myAnswer,
    bool clearMyAnswer = false,
    List<MinuteApproval>? approvals,
    bool? sending,
  }) {
    return MinutesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      minuteId: minuteId ?? this.minuteId,
      isLead: isLead ?? this.isLead,
      myAnswer: clearMyAnswer ? null : (myAnswer ?? this.myAnswer),
      approvals: approvals ?? this.approvals,
      sending: sending ?? this.sending,
    );
  }
}
