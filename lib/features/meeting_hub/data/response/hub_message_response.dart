import 'dart:convert';

import 'package:mms/core/strings/enum_manager.dart';

/// Envelope of a meeting hub message: `{ "event": 0, "data": { ... } }`.
///
/// `data` keys are normalised to camelCase, because `DecisionPublished`
/// arrives in PascalCase while the other events use camelCase.
class HubMessage {
  const HubMessage({
    required this.event,
    required this.data,
  });

  /// Null when the backend sends an event this app version doesn't know.
  final SocketEvents? event;
  final Map<String, dynamic> data;

  /// `meetingId` inside `data`, or empty when the payload has none (poll results).
  String get meetingId => data['meetingId'] ?? '';

  factory HubMessage.fromJson(Map<String, dynamic> json) {
    final data = camelKeys(json['data'] ?? {});
    return HubMessage(
      // Not `tryParseOrZeroInt`: a bad value must not turn into event 0.
      event: SocketEvents.fromIndex(int.tryParse(json['event']?.toString() ?? '')),
      data: data is Map<String, dynamic> ? data : {},
    );
  }

  /// Parses the raw `ReceiveMessage` argument (a JSON string).
  /// Returns null when it isn't a valid envelope.
  static HubMessage? tryParse(Object? raw) {
    if (raw is! String) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      return HubMessage.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        'event': event?.index,
        'data': data,
      };
}

/// Lower-cases the first letter of every map key, recursively.
dynamic camelKeys(dynamic value) {
  if (value is Map) {
    return <String, dynamic>{
      for (final entry in value.entries)
        _lowerFirst(entry.key.toString()): camelKeys(entry.value),
    };
  }
  if (value is List) return value.map(camelKeys).toList();
  return value;
}

String _lowerFirst(String key) => key.isEmpty ? key : key[0].toLowerCase() + key.substring(1);
