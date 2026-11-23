import 'package:mms/core/strings/enum_manager.dart';

/// `AddDelegationDto`: always for my own role (admins only may pass `fromPartyId`).
class AddDelegationRequest {
  AddDelegationRequest({
    required this.committeeId,
    required this.toPartyId,
    required this.role,
    required this.scopes,
    required this.startsAt,
    required this.endsAt,
    this.reason = '',
  });

  final String committeeId;
  final String toPartyId;

  /// Chair or secretary.
  final MembershipType role;
  final List<DelegationScope> scopes;
  final DateTime startsAt;
  final DateTime endsAt;
  final String reason;

  Map<String, dynamic> toJson() => {
    'committeeId': committeeId,
    'toPartyId': toPartyId,
    'role': role.index,
    'scopes': DelegationScope.toMask(scopes),
    'startsAt': startsAt.toUtc().toIso8601String(),
    'endsAt': endsAt.toUtc().toIso8601String(),
    if (reason.trim().isNotEmpty) 'reason': reason.trim(),
  };
}
