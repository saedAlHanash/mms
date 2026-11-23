import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/enum_manager.dart';

/// `DelegationDto`: a chair or secretary handing their role to another member
/// for a period and a set of areas ([scopes] is a `DelegationScope` flag mask).
class Delegation {
  const Delegation({
    required this.id,
    required this.committeeId,
    required this.fromPartyId,
    required this.fromName,
    required this.toPartyId,
    required this.toName,
    required this.role,
    required this.scopes,
    required this.startsAt,
    required this.endsAt,
    required this.reason,
    required this.revokedAt,
    required this.state,
  });

  final String id;
  final String committeeId;
  final String fromPartyId;
  final String fromName;
  final String toPartyId;
  final String toName;
  final MembershipType role;
  final int scopes;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final String reason;
  final DateTime? revokedAt;
  final DelegationState state;

  bool get isEmpty => id.isEmpty;

  bool get isFromMe => fromPartyId.isNotEmpty && fromPartyId == AppProvider.getParty.id;

  bool get isToMe => toPartyId.isNotEmpty && toPartyId == AppProvider.getParty.id;

  /// The delegator or the delegate, while it hasn't ended.
  bool get canRevoke =>
      (isFromMe || isToMe) && (state == DelegationState.upcoming || state == DelegationState.active);

  List<DelegationScope> get scopeList => DelegationScope.fromMask(scopes);

  bool get coversAll => scopes & DelegationScope.allMask == DelegationScope.allMask;

  factory Delegation.fromJson(Map<String, dynamic> json) {
    final map = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    final role = int.tryParse(map['role']?.toString() ?? '');
    DateTime? date(Object? v) => DateTime.tryParse(v?.toString() ?? '')?.toLocal();

    return Delegation(
      id: map['id'] ?? '',
      committeeId: map['committeeId'] ?? '',
      fromPartyId: map['fromPartyId'] ?? '',
      fromName: map['fromName'] ?? '',
      toPartyId: map['toPartyId'] ?? '',
      toName: map['toName'] ?? '',
      role: role == null || role < 0 || role >= MembershipType.values.length
          ? MembershipType.secretary
          : MembershipType.values[role],
      scopes: int.tryParse(map['scopes']?.toString() ?? '') ?? 0,
      startsAt: date(map['startsAt']),
      endsAt: date(map['endsAt']),
      reason: map['reason'] ?? '',
      revokedAt: date(map['revokedAt']),
      state: DelegationState.fromName(map['state']),
    );
  }
}
