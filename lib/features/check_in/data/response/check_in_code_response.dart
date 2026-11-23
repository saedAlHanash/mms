import 'package:mms/core/api_manager/api_url.dart';

/// `CheckInCodeDto` from `CheckIn/GetCode`: the six-digit hall code (changes every 20 s).
class CheckInCode {
  CheckInCode({
    required this.meetingId,
    required this.code,
    required this.periodSeconds,
    required this.expiresAt,
    required this.secondsLeft,
  });

  final String meetingId;
  final String code;
  final int periodSeconds;
  final DateTime? expiresAt;
  final int secondsLeft;

  bool get isEmpty => code.isEmpty;

  /// What the hall QR encodes, as the web does: `{origin}/check-in/{meetingId}/{code}`.
  /// The app reads the last two segments, so the origin only matters to other scanners.
  String get qrData => 'https://$baseUrl/check-in/$meetingId/$code';

  factory CheckInCode.empty() => CheckInCode.fromJson(const {});

  factory CheckInCode.fromJson(Map<String, dynamic> json) {
    final map = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    return CheckInCode(
      meetingId: map['meetingId'] ?? '',
      code: map['code']?.toString() ?? '',
      periodSeconds: int.tryParse(map['periodSeconds']?.toString() ?? '') ?? 20,
      expiresAt: DateTime.tryParse(map['expiresAt']?.toString() ?? ''),
      secondsLeft: int.tryParse(map['secondsLeft']?.toString() ?? '') ?? 0,
    );
  }
}
