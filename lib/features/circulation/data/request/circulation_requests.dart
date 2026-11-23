import 'package:mms/core/strings/enum_manager.dart';

/// `CirculationListQuery`: `pageNumber` starts at 0.
class CirculationListQuery {
  const CirculationListQuery({
    required this.committeeId,
    this.status,
    this.pageNumber = 0,
    this.pageSize = 20,
  });

  final String committeeId;
  final CirculationStatus? status;
  final int pageNumber;
  final int pageSize;

  Map<String, dynamic> toJson() => {
    'committeeId': committeeId,
    if (status != null) 'status': status!.index,
    'pageNumber': pageNumber,
    'pageSize': pageSize,
  };
}

/// `CastCirculationVoteDto`: a second vote replaces the first.
class CastCirculationVote {
  const CastCirculationVote({required this.circulationId, required this.choice, this.reason = ''});

  final String circulationId;
  final CirculationChoice choice;

  /// Optional, 500 characters at most.
  final String reason;

  Map<String, dynamic> toJson() => {
    'circulationId': circulationId,
    'choice': choice.index,
    if (reason.trim().isNotEmpty) 'reason': reason.trim(),
  };
}
