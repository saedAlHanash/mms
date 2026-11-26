import 'package:mms/core/strings/enum_manager.dart';

/// `HallServiceRequestDto`: equipment, hospitality or another service asked of facilities.
class HallServiceRequest {
  const HallServiceRequest({
    required this.id,
    required this.meetingId,
    required this.hallName,
    required this.kind,
    required this.equipmentName,
    required this.quantity,
    required this.details,
    required this.state,
    required this.requestedByName,
    required this.requestedAt,
    required this.respondedAt,
    required this.respondedByName,
    required this.responseNote,
  });

  final String id;
  final String meetingId;
  final String hallName;
  final HallServiceKind kind;
  final String equipmentName;

  /// Items for equipment, people for hospitality.
  final int quantity;
  final String details;
  final HallServiceState state;
  final String requestedByName;
  final DateTime? requestedAt;
  final DateTime? respondedAt;
  final String respondedByName;
  final String responseNote;

  bool get isEmpty => id.isEmpty;

  /// Can still be cancelled.
  bool get isOpen => state == HallServiceState.requested || state == HallServiceState.confirmed;

  factory HallServiceRequest.fromJson(Map<String, dynamic> json) {
    final map = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    DateTime? date(Object? v) => DateTime.tryParse(v?.toString() ?? '')?.toLocal();
    return HallServiceRequest(
      id: map['id'] ?? '',
      meetingId: map['meetingId'] ?? '',
      hallName: map['hallName'] ?? '',
      kind: HallServiceKind.fromIndex(map['kind']),
      equipmentName: map['equipmentName'] ?? '',
      quantity: int.tryParse(map['quantity']?.toString() ?? '') ?? 0,
      details: map['details'] ?? '',
      state: HallServiceState.fromIndex(map['state']),
      requestedByName: map['requestedByName'] ?? '',
      requestedAt: date(map['requestedAt']),
      respondedAt: date(map['respondedAt']),
      respondedByName: map['respondedByName'] ?? '',
      responseNote: map['responseNote'] ?? '',
    );
  }
}

/// `HallEquipmentDto` (from `Hall/Get → hallEquipment`): what the booked hall has.
class HallEquipment {
  const HallEquipment({required this.equipmentId, required this.name, required this.quantity});

  final String equipmentId;
  final String name;

  /// How many the hall has.
  final int quantity;

  factory HallEquipment.fromJson(Map<String, dynamic> map) {
    final equipment = map['equipment'] is Map ? map['equipment'] as Map : const {};
    return HallEquipment(
      equipmentId: (map['equipmentId'] ?? equipment['id'] ?? '').toString(),
      name: (equipment['name'] ?? map['name'] ?? '').toString(),
      quantity: int.tryParse(map['quantity']?.toString() ?? '') ?? 0,
    );
  }
}
