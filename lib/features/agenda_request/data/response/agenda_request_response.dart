import 'package:mms/core/strings/enum_manager.dart';

/// A proposed agenda item (`AgendaItemRequestDto`).
class AgendaItemRequest {
  const AgendaItemRequest({
    required this.id,
    required this.meetingId,
    required this.partyId,
    required this.proposerName,
    required this.title,
    required this.note,
    required this.status,
    required this.reason,
    required this.agendaItemId,
    required this.created,
    required this.reviewedAt,
    required this.mediaId,
    required this.mediaOriginalFileName,
    required this.mediaSavedPath,
  });

  final String id;
  final String meetingId;
  final String partyId;
  final String proposerName;
  final String title;
  final String note;
  final AgendaRequestStatus status;

  /// Why it was rejected.
  final String reason;
  final String agendaItemId;
  final DateTime? created;
  final DateTime? reviewedAt;
  final String mediaId;
  final String mediaOriginalFileName;
  final String mediaSavedPath;

  bool get hasAttachment => mediaId.isNotEmpty;

  factory AgendaItemRequest.fromJson(Map<String, dynamic> json) {
    // Single results may come wrapped in `data`.
    final map = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    return AgendaItemRequest(
      id: map['id'] ?? '',
      meetingId: map['meetingId'] ?? '',
      partyId: map['partyId'] ?? '',
      proposerName: map['proposerName'] ?? '',
      title: map['title'] ?? '',
      note: map['note'] ?? '',
      status: AgendaRequestStatus.fromIndex(map['status']),
      reason: map['reason'] ?? '',
      agendaItemId: map['agendaItemId'] ?? '',
      created: DateTime.tryParse(map['created'] ?? '')?.toLocal(),
      reviewedAt: DateTime.tryParse(map['reviewedAt'] ?? '')?.toLocal(),
      mediaId: map['mediaId'] ?? '',
      mediaOriginalFileName: map['mediaOriginalFileName'] ?? '',
      mediaSavedPath: map['mediaSavedPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'meetingId': meetingId,
    'partyId': partyId,
    'proposerName': proposerName,
    'title': title,
    'note': note,
    'status': status.index,
    'reason': reason,
    'agendaItemId': agendaItemId,
    'created': created?.toIso8601String(),
    'reviewedAt': reviewedAt?.toIso8601String(),
    'mediaId': mediaId,
    'mediaOriginalFileName': mediaOriginalFileName,
    'mediaSavedPath': mediaSavedPath,
  };
}
