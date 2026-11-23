/// Where an arrival was recorded (`LocationType`).
enum CheckInLocation { physical, online }

/// `CheckInResultDto`.
class CheckInResult {
  CheckInResult({
    required this.meetingId,
    required this.alreadyCheckedIn,
    required this.attendedAt,
    required this.location,
  });

  final String meetingId;

  /// The first arrival counts: a later scan returns the original time and place.
  final bool alreadyCheckedIn;
  final DateTime? attendedAt;
  final CheckInLocation? location;

  bool get isEmpty => meetingId.isEmpty;

  factory CheckInResult.empty() => CheckInResult.fromJson(const {});

  factory CheckInResult.fromJson(Map<String, dynamic> json) {
    final location = int.tryParse(json['locationType']?.toString() ?? '');
    return CheckInResult(
      meetingId: json['meetingId'] ?? '',
      alreadyCheckedIn: json['alreadyCheckedIn'] ?? false,
      attendedAt: DateTime.tryParse(json['attendedAt'] ?? ''),
      location: location == null || location < 0 || location >= CheckInLocation.values.length
          ? null
          : CheckInLocation.values[location],
    );
  }
}

/// Reads the hall QR: `{webOrigin}/check-in/{meetingId}/{code}`, or just the six digits.
/// Returns null when it isn't a check-in code.
({String meetingId, String code})? parseCheckInQr(String raw) {
  final text = raw.trim();
  final sixDigits = RegExp(r'^\d{6}$');
  if (sixDigits.hasMatch(text)) return (meetingId: '', code: text);

  final segments = Uri.tryParse(text)?.pathSegments.where((e) => e.isNotEmpty).toList() ?? [];
  if (segments.length < 2) return null;
  final code = segments.last;
  final meetingId = segments[segments.length - 2];
  if (!sixDigits.hasMatch(code) || meetingId.isEmpty) return null;
  return (meetingId: meetingId, code: code);
}
