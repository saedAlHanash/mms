/// `UpdateMinuteApprovalDto`: the caller's own answer.
class UpdateMinuteApprovalRequest {
  const UpdateMinuteApprovalRequest({
    required this.partyId,
    required this.minuteId,
    required this.isApproved,
    this.reason = '',
  });

  final String partyId;
  final String minuteId;
  final bool isApproved;

  /// Required to reject (at most 500 characters).
  final String reason;

  Map<String, dynamic> toJson() => {
        'partyId': partyId,
        'minuteId': minuteId,
        'isApproved': isApproved,
        if (reason.isNotEmpty) 'reason': reason,
      };
}
