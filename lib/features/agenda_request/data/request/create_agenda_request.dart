import 'dart:typed_data';

/// `CreateAgendaItemRequestDto`, plus the attachment to upload first.
class CreateAgendaRequest {
  const CreateAgendaRequest({
    required this.meetingId,
    required this.title,
    this.note = '',
    this.attachment,
  });

  final String meetingId;
  final String title;
  final String note;
  final PickedAttachment? attachment;

  Map<String, dynamic> toJson({String? mediaId}) => {
    'meetingId': meetingId,
    'title': title.trim(),
    if (note.trim().isNotEmpty) 'note': note.trim(),
    if (mediaId != null && mediaId.isNotEmpty) 'mediaId': mediaId,
  };
}

/// A file chosen on the device, sent through `FileManager/Upload`.
class PickedAttachment {
  const PickedAttachment({required this.name, required this.bytes});

  final String name;
  final Uint8List bytes;

  /// "1.2 MB".
  String get sizeLabel {
    final kb = bytes.length / 1024;
    return kb < 1024 ? '${kb.toStringAsFixed(0)} KB' : '${(kb / 1024).toStringAsFixed(1)} MB';
  }
}
