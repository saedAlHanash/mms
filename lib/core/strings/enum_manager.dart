import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

import 'package:mms/generated/l10n.dart';
import 'package:mms/core/strings/app_color_manager.dart';

// enum CubitStatuses { init, loading, done, error }

enum AttachmentType { image, youtube, video, d3 }

enum PricingMatrixType { day, date }

enum FilterItem { activity, group, country, city }

enum StartPage { login, home, signupOtp, passwordOtp }

enum GenderEnum {
  male,
  female;

  String get name {
    switch (this) {
      case GenderEnum.male:
        return S().mail;
      case GenderEnum.female:
        return S().female;
    }
  }
}

enum NeedUpdateEnum { no, withLoading, noLoading }

enum UpdateProfileType { normal, confirmAddPhone }

enum TaskType { plannedTask, meetingTask }

/// Colors of a status badge: [dot] (indicator), [bg] (badge background),
/// [fg] (badge text) and an optional dashed [border] (neutral statuses).
class StatusColors {
  const StatusColors({
    required this.dot,
    required this.bg,
    required this.fg,
    this.border,
  });

  final Color dot;
  final Color bg;
  final Color fg;
  final Color? border;
}

enum PollStatus { pending, open, closed }

extension PollStatusColors on PollStatus {
  StatusColors get colors => switch (this) {
        PollStatus.pending => MeetingStatus.planned.colors,
        PollStatus.open => MeetingStatus.running.colors,
        PollStatus.closed => MeetingStatus.archived.colors,
      };
}

enum PartyType { member, guest }

enum MinuteStatus {
  pending,
  approved,
  rejected,
  published;
}

enum MembershipType {
  member(2),
  chair(0),
  secretary(1),
  guest(3);

  const MembershipType(this.weight);

  final int weight;

  /// Badge colors (background / text / optional dashed border).
  StatusColors get badge => switch (this) {
        MembershipType.chair => const StatusColors(
            dot: AppColorManager.primary500,
            bg: AppColorManager.primary500,
            fg: AppColorManager.neutral0,
          ),
        MembershipType.secretary => const StatusColors(
            dot: AppColorManager.warning,
            bg: AppColorManager.warningSoft,
            fg: AppColorManager.warningText,
          ),
        MembershipType.member => const StatusColors(
            dot: AppColorManager.primary500,
            bg: AppColorManager.primary100,
            fg: AppColorManager.primary700,
          ),
        MembershipType.guest => const StatusColors(
            dot: AppColorManager.neutral300,
            bg: Colors.transparent,
            fg: AppColorManager.neutral700,
            border: AppColorManager.neutral300,
          ),
      };

  Color get getColor {
    switch (this) {
      case MembershipType.member:
        return Colors.green;
      case MembershipType.chair:
        return Colors.redAccent;
      case MembershipType.secretary:
        return AppColorManager.ampere;
      default:
        return Colors.black;
    }
  }

  String get name {
    switch (this) {
      case MembershipType.member:
        return S().member;
      case MembershipType.chair:
        return S().chair;
      case MembershipType.secretary:
        return S().secretary;
      case MembershipType.guest:
        return S().guest;
    }
  }

  bool get isMember => this != chair && this != secretary;

  bool get isChair => this == chair;

  bool get isSecretary => this == secretary;

  /// Chair or secretary.
  bool get isLead => isChair || isSecretary;
}

/// Same order as the backend (`0` Pending, `1` Open, `2` Closed).
enum DiscussionStatus { pending, open, closed }

extension DiscussionStatusColors on DiscussionStatus {
  StatusColors get colors => switch (this) {
        DiscussionStatus.pending => MeetingStatus.planned.colors,
        DiscussionStatus.open => MeetingStatus.running.colors,
        DiscussionStatus.closed => MeetingStatus.archived.colors,
      };
}

/// Meeting hub events (`SocketEvents` on the backend, sent as their index).
enum SocketEvents {
  agendaItemStatusUpdated,
  pollStatusUpdated,
  pollPublished,
  decisionPublished,
  discussionStatusUpdated,

  /// Live screen state changed (`{meetingId, part}`, part: item / timer / speakers).
  liveStateUpdated;

  /// Unknown numbers return null so newer backend events are ignored.
  static SocketEvents? fromIndex(int? index) {
    if (index == null || index < 0 || index >= values.length) return null;
    return values[index];
  }
}

enum ApiType {
  get,
  post,
  put,
  patch,
  delete,
}

enum MeetingStatus {
  planned(
    colors: StatusColors(
      dot: Color(0xFFBABABA),
      bg: Colors.transparent,
      fg: AppColorManager.neutral700,
      border: AppColorManager.neutral300,
    ),
  ),
  scheduled(
    colors: StatusColors(dot: Color(0xFFAA2F0A), bg: Color(0xFFFBEAE4), fg: Color(0xFF9A2A08)),
  ),
  postponed(
    colors: StatusColors(dot: Color(0xFFFFB600), bg: AppColorManager.warningSoft, fg: AppColorManager.warningText),
  ),
  canceled(
    colors: StatusColors(dot: Color(0xFFD73333), bg: AppColorManager.dangerSoft, fg: AppColorManager.dangerText),
  ),
  running(
    colors: StatusColors(dot: Color(0xFF33B843), bg: AppColorManager.successSoft, fg: Color(0xFF1A6E27)),
  ),
  completed(
    colors: StatusColors(dot: Color(0xFF3469F9), bg: AppColorManager.infoSoft, fg: AppColorManager.info),
  ),
  archived(
    colors: StatusColors(dot: AppColorManager.neutral500, bg: Color(0xFFECEBEF), fg: AppColorManager.neutral700),
  );

  const MeetingStatus({
    required this.colors,
  });

  /// Indicator color (kept for existing callers).
  Color get color => colors.dot;

  String get realName {
    switch (this) {
      case MeetingStatus.planned:
        return S().planned;
      case MeetingStatus.scheduled:
        return S().scheduled;
      case MeetingStatus.postponed:
        return S().postponed;
      case MeetingStatus.canceled:
        return S().canceled;
      case MeetingStatus.running:
        return S().running;
      case MeetingStatus.completed:
        return S().completed;
      case MeetingStatus.archived:
        return S().archived;
    }
  }

  final StatusColors colors;
}

enum MediaType {
  media,
  screen;

  bool get isMedia => this == MediaType.media;

  bool get isScreen => this == MediaType.screen;

  IconData get icon {
    return switch (this) { MediaType.media => Icons.videocam, MediaType.screen => Icons.monitor };
  }

  TrackSource get videoSourceType {
    return switch (this) {
      MediaType.media => TrackSource.camera,
      MediaType.screen => TrackSource.screenShareVideo,
    };
  }

  TrackSource get audioSourceType {
    return switch (this) {
      MediaType.media => TrackSource.microphone,
      MediaType.screen => TrackSource.screenShareAudio,
    };
  }
}

enum LkUserType {
  manager,
  sharer,
  user;

  bool get isManager => this == LkUserType.manager;

  bool get isSharer => this == LkUserType.sharer;

  bool get isUser => this == LkUserType.user;
}

enum ManagerActions {
  requestPermission,
  requestToDisconnect,
  message,
  changeScreen;

  IconData get icon {
    return switch (this) {
      ManagerActions.requestPermission => Icons.pan_tool_outlined,
      ManagerActions.requestToDisconnect => Icons.exit_to_app,
      ManagerActions.message => Icons.message,
      ManagerActions.changeScreen => Icons.screen_share_outlined,
    };
  }
}

enum NotesMessages {
  cannotHear,
  cannotSee,
  needHelp;

  IconData get icon {
    return switch (this) {
      NotesMessages.cannotHear => Icons.hearing_disabled,
      NotesMessages.cannotSee => Icons.visibility_off_outlined,
      NotesMessages.needHelp => Icons.help_outline,
    };
  }

  /// Localized label shown in the quick-message menu.
  String get label => switch (this) {
        NotesMessages.cannotHear => S().noteCannotHear,
        NotesMessages.cannotSee => S().noteCannotSee,
        NotesMessages.needHelp => S().noteNeedHelp,
      };

  String get message {
    switch (this) {
      case NotesMessages.cannotHear:
        return 'لا أسمع';
      case NotesMessages.cannotSee:
        return 'لا أرى الشاشة';
      case NotesMessages.needHelp:
        return 'أحتاج مساعدة';
    }
  }
}

/// How a meeting is held (`MeetingMode` on the backend, sent as its index).
enum MeetingMode {
  inPerson,
  online,
  hybrid;

  /// Null for a missing or unknown value (older meetings have no mode).
  static MeetingMode? fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return null;
    return values[i];
  }

  String get label => switch (this) {
        MeetingMode.inPerson => S().meetingModeInPerson,
        MeetingMode.online => S().meetingModeOnline,
        MeetingMode.hybrid => S().meetingModeHybrid,
      };

  IconData get icon => switch (this) {
        MeetingMode.inPerson => Icons.groups_outlined,
        MeetingMode.online => Icons.videocam_outlined,
        MeetingMode.hybrid => Icons.devices_outlined,
      };
}

/// Kind of floor request (`SpeakerRequestKind`): a point of order goes first.
enum SpeakerRequestKind { normal, pointOfOrder }

/// State of a role delegation (`DelegationDto.state`, sent as a string).
enum DelegationState {
  upcoming,
  active,
  ended,
  revoked;

  static DelegationState fromName(Object? name) {
    final value = name?.toString().toLowerCase() ?? '';
    return values.firstWhere((e) => e.name == value, orElse: () => ended);
  }

  /// Sort order: active, upcoming, then the past.
  int get order => switch (this) {
        DelegationState.active => 0,
        DelegationState.upcoming => 1,
        DelegationState.ended => 2,
        DelegationState.revoked => 3,
      };

  String get label => switch (this) {
        DelegationState.upcoming => S().delegationUpcoming,
        DelegationState.active => S().delegationActive,
        DelegationState.ended => S().delegationEnded,
        DelegationState.revoked => S().delegationRevokedState,
      };

  StatusColors get colors => switch (this) {
        DelegationState.active => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
        DelegationState.upcoming => const StatusColors(
            dot: AppColorManager.primary500,
            bg: AppColorManager.primary50,
            fg: AppColorManager.primary700,
          ),
        DelegationState.ended => const StatusColors(
            dot: AppColorManager.neutral500,
            bg: AppColorManager.neutral50,
            fg: AppColorManager.neutral700,
          ),
        DelegationState.revoked => const StatusColors(
            dot: AppColorManager.danger,
            bg: AppColorManager.dangerSoft,
            fg: AppColorManager.dangerText,
          ),
      };
}

/// Areas a delegation covers (`DelegationScope` flags, added together; 127 is all).
enum DelegationScope {
  meetings(1),
  minutes(2),
  decisions(4),
  members(8),
  tasks(16),
  rules(32),
  reports(64);

  const DelegationScope(this.flag);

  final int flag;

  static const allMask = 127;

  static List<DelegationScope> fromMask(int mask) => values.where((e) => mask & e.flag != 0).toList();

  static int toMask(Iterable<DelegationScope> scopes) => scopes.fold(0, (sum, e) => sum | e.flag);

  String get label => switch (this) {
        DelegationScope.meetings => S().scopeMeetings,
        DelegationScope.minutes => S().scopeMinutes,
        DelegationScope.decisions => S().scopeDecisions,
        DelegationScope.members => S().scopeMembers,
        DelegationScope.tasks => S().scopeTasks,
        DelegationScope.rules => S().scopeRules,
        DelegationScope.reports => S().scopeReports,
      };
}

/// `MeetingTaskStatus`.
enum MeetingTaskStatus {
  onHold,
  inProgress,
  cancelled,
  completed;

  static MeetingTaskStatus fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return onHold;
    return values[i];
  }

  String get label => switch (this) {
        MeetingTaskStatus.onHold => S().taskOnHold,
        MeetingTaskStatus.inProgress => S().taskInProgress,
        MeetingTaskStatus.cancelled => S().taskCancelled,
        MeetingTaskStatus.completed => S().taskCompleted,
      };

  StatusColors get colors => switch (this) {
        MeetingTaskStatus.onHold => const StatusColors(
            dot: AppColorManager.warning,
            bg: AppColorManager.warningSoft,
            fg: AppColorManager.warningText,
          ),
        MeetingTaskStatus.inProgress => const StatusColors(
            dot: AppColorManager.primary500,
            bg: AppColorManager.primary50,
            fg: AppColorManager.primary700,
          ),
        MeetingTaskStatus.cancelled => const StatusColors(
            dot: AppColorManager.neutral500,
            bg: AppColorManager.neutral50,
            fg: AppColorManager.neutral700,
          ),
        MeetingTaskStatus.completed => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
      };
}

/// `RecommendationState` of a sub-committee recommendation.
enum RecommendationState {
  pending,
  approved,
  rejected,
  withdrawn;

  static RecommendationState fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return pending;
    return values[i];
  }

  String get label => switch (this) {
        RecommendationState.pending => S().recommendationPending,
        RecommendationState.approved => S().recommendationApproved,
        RecommendationState.rejected => S().recommendationRejected,
        RecommendationState.withdrawn => S().recommendationWithdrawn,
      };

  StatusColors get colors => switch (this) {
        RecommendationState.pending => const StatusColors(
            dot: AppColorManager.warning,
            bg: AppColorManager.warningSoft,
            fg: AppColorManager.warningText,
          ),
        RecommendationState.approved => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
        RecommendationState.rejected => const StatusColors(
            dot: AppColorManager.danger,
            bg: AppColorManager.dangerSoft,
            fg: AppColorManager.dangerText,
          ),
        RecommendationState.withdrawn => const StatusColors(
            dot: AppColorManager.neutral500,
            bg: AppColorManager.neutral50,
            fg: AppColorManager.neutral700,
          ),
      };
}

/// `HallServiceKind`.
enum HallServiceKind {
  equipment,
  hospitality,
  other;

  static HallServiceKind fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return other;
    return values[i];
  }

  String get label => switch (this) {
        HallServiceKind.equipment => S().serviceEquipment,
        HallServiceKind.hospitality => S().serviceHospitality,
        HallServiceKind.other => S().serviceOther,
      };

  IconData get icon => switch (this) {
        HallServiceKind.equipment => Icons.videocam_outlined,
        HallServiceKind.hospitality => Icons.local_cafe_outlined,
        HallServiceKind.other => Icons.miscellaneous_services_outlined,
      };
}

/// `HallServiceState`.
enum HallServiceState {
  requested,
  confirmed,
  rejected,
  delivered,
  cancelled;

  static HallServiceState fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return requested;
    return values[i];
  }

  String get label => switch (this) {
        HallServiceState.requested => S().serviceRequestedState,
        HallServiceState.confirmed => S().serviceConfirmed,
        HallServiceState.rejected => S().serviceRejected,
        HallServiceState.delivered => S().serviceDelivered,
        HallServiceState.cancelled => S().serviceCancelled,
      };

  StatusColors get colors => switch (this) {
        HallServiceState.requested => const StatusColors(
            dot: AppColorManager.warning,
            bg: AppColorManager.warningSoft,
            fg: AppColorManager.warningText,
          ),
        HallServiceState.confirmed => const StatusColors(
            dot: AppColorManager.primary500,
            bg: AppColorManager.primary50,
            fg: AppColorManager.primary700,
          ),
        HallServiceState.rejected => const StatusColors(
            dot: AppColorManager.danger,
            bg: AppColorManager.dangerSoft,
            fg: AppColorManager.dangerText,
          ),
        HallServiceState.delivered => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
        HallServiceState.cancelled => const StatusColors(
            dot: AppColorManager.neutral500,
            bg: AppColorManager.neutral50,
            fg: AppColorManager.neutral700,
          ),
      };
}

/// `LiveTimerAction` (chair / secretary timer controls).
enum LiveTimerAction { start, pause, reset, addTime, setLength }

/// State of a floor request (`SpeakerRequestState`).
enum SpeakerRequestState { waiting, speaking, done, withdrawn, skipped }

/// Result of a for/against poll under the committee's voting rule (`PollOutcome`).
/// Status of a decision by circulation (`CirculationStatus`).
enum CirculationStatus {
  draft,
  open,
  closed,
  withdrawn;

  static CirculationStatus fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return draft;
    return values[i];
  }

  String get label => switch (this) {
        CirculationStatus.draft => S().circulationDraft,
        CirculationStatus.open => S().circulationOpen,
        CirculationStatus.closed => S().circulationClosed,
        CirculationStatus.withdrawn => S().circulationWithdrawn,
      };

  StatusColors get colors => switch (this) {
        CirculationStatus.open => const StatusColors(
            dot: AppColorManager.primary500,
            bg: AppColorManager.primary50,
            fg: AppColorManager.primary700,
          ),
        CirculationStatus.closed => const StatusColors(
            dot: AppColorManager.neutral700,
            bg: AppColorManager.neutral100,
            fg: AppColorManager.neutral900,
          ),
        CirculationStatus.draft || CirculationStatus.withdrawn => const StatusColors(
            dot: AppColorManager.neutral500,
            bg: AppColorManager.neutral50,
            fg: AppColorManager.neutral700,
          ),
      };
}

/// A voter's answer to a circulation (`CirculationChoice`).
enum CirculationChoice {
  approve,
  reject,
  abstain;

  static CirculationChoice? fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return null;
    return values[i];
  }

  String get label => switch (this) {
        CirculationChoice.approve => S().circulationApprove,
        CirculationChoice.reject => S().circulationReject,
        CirculationChoice.abstain => S().circulationAbstain,
      };

  IconData get icon => switch (this) {
        CirculationChoice.approve => Icons.thumb_up_alt_outlined,
        CirculationChoice.reject => Icons.thumb_down_alt_outlined,
        CirculationChoice.abstain => Icons.remove_circle_outline_rounded,
      };

  StatusColors get colors => switch (this) {
        CirculationChoice.approve => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
        CirculationChoice.reject => const StatusColors(
            dot: AppColorManager.danger,
            bg: AppColorManager.dangerSoft,
            fg: AppColorManager.dangerText,
          ),
        CirculationChoice.abstain => const StatusColors(
            dot: AppColorManager.neutral500,
            bg: AppColorManager.neutral50,
            fg: AppColorManager.neutral700,
          ),
      };
}

/// Result of a closed circulation (`CirculationOutcome`).
enum CirculationOutcome {
  approved,
  rejected;

  static CirculationOutcome? fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return null;
    return values[i];
  }

  String get label => switch (this) {
        CirculationOutcome.approved => S().circulationApproved,
        CirculationOutcome.rejected => S().circulationRejected,
      };

  StatusColors get colors => switch (this) {
        CirculationOutcome.approved => PollOutcome.passed.colors,
        CirculationOutcome.rejected => PollOutcome.rejected.colors,
      };
}

/// Status of an agenda item proposal (`AgendaItemRequestStatus`).
/// `AbsenceRequestStatus`.
enum AbsenceStatus {
  pending,
  accepted,
  rejected;

  static AbsenceStatus fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return pending;
    return values[i];
  }

  String get label => switch (this) {
        AbsenceStatus.pending => S().absencePending,
        AbsenceStatus.accepted => S().absenceAcceptedState,
        AbsenceStatus.rejected => S().absenceRejectedState,
      };

  StatusColors get colors => switch (this) {
        AbsenceStatus.pending => const StatusColors(
            dot: AppColorManager.warning,
            bg: AppColorManager.warningSoft,
            fg: AppColorManager.warningText,
          ),
        AbsenceStatus.accepted => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
        AbsenceStatus.rejected => const StatusColors(
            dot: AppColorManager.danger,
            bg: AppColorManager.dangerSoft,
            fg: AppColorManager.dangerText,
          ),
      };
}

enum AgendaRequestStatus {
  pending,
  accepted,
  rejected,
  closed;

  static AgendaRequestStatus fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return pending;
    return values[i];
  }

  String get label => switch (this) {
        AgendaRequestStatus.pending => S().agendaRequestPending,
        AgendaRequestStatus.accepted => S().agendaRequestAccepted,
        AgendaRequestStatus.rejected => S().agendaRequestRejected,
        AgendaRequestStatus.closed => S().agendaRequestClosed,
      };

  StatusColors get colors => switch (this) {
        AgendaRequestStatus.pending => const StatusColors(
            dot: AppColorManager.warning,
            bg: AppColorManager.warningSoft,
            fg: AppColorManager.warningText,
          ),
        AgendaRequestStatus.accepted => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
        AgendaRequestStatus.rejected => const StatusColors(
            dot: AppColorManager.danger,
            bg: AppColorManager.dangerSoft,
            fg: AppColorManager.dangerText,
          ),
        AgendaRequestStatus.closed => const StatusColors(
            dot: AppColorManager.neutral500,
            bg: AppColorManager.neutral50,
            fg: AppColorManager.neutral700,
          ),
      };
}

enum PollOutcome {
  passed,
  rejected,
  tied;

  static PollOutcome? fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return null;
    return values[i];
  }

  String get label => switch (this) {
        PollOutcome.passed => S().pollOutcomePassed,
        PollOutcome.rejected => S().pollOutcomeRejected,
        PollOutcome.tied => S().pollOutcomeTied,
      };

  StatusColors get colors => switch (this) {
        PollOutcome.passed => const StatusColors(
            dot: AppColorManager.success,
            bg: AppColorManager.successSoft,
            fg: AppColorManager.successText,
          ),
        PollOutcome.rejected => const StatusColors(
            dot: AppColorManager.danger,
            bg: AppColorManager.dangerSoft,
            fg: AppColorManager.dangerText,
          ),
        PollOutcome.tied => const StatusColors(
            dot: AppColorManager.warning,
            bg: AppColorManager.warningSoft,
            fg: AppColorManager.warningText,
          ),
      };
}

/// What a poll option stands for (`VoteOptionKind`, sent as its index).
enum VoteOptionKind {
  other,
  inFavor,
  against,
  abstain;

  static VoteOptionKind fromIndex(Object? index) {
    final i = int.tryParse(index?.toString() ?? '');
    if (i == null || i < 0 || i >= values.length) return other;
    return values[i];
  }

  /// Objecting or abstaining can need a reason (`Rules:VoteReasons`).
  bool get asksReason => this == against || this == abstain;
}

enum PermissionType {
  speak,
  listen,
  both;

  Map<String, dynamic> revokePermissions(Participant participant) {
    final Map<String, dynamic> map = switch (this) {
      PermissionType.speak => {
          "canSubscribe": participant.permissions.canSubscribe,
          "canPublish": false,
          //----------
          "canPublishData": true,
        },
      PermissionType.listen => {
          "canSubscribe": false,
          "canPublish": participant.permissions.canPublish,
          //----------
          "canPublishData": true,
        },
      PermissionType.both => {
          "canSubscribe": false,
          "canPublish": false,
          //----------
          "canPublishData": true,
        },
    };
    return map..addAll({'identity': participant.identity});
  }

  Map<String, dynamic> grantPermissions(Participant participant) {
    final Map<String, dynamic> map = switch (this) {
      PermissionType.speak => {
          "canSubscribe": participant.permissions.canSubscribe,
          "canPublish": true,
          //----------
          "canPublishData": true,
        },
      PermissionType.listen => {
          "canSubscribe": true,
          "canPublish": participant.permissions.canPublish,
          //----------
          "canPublishData": true,
        },
      PermissionType.both => {
          "canSubscribe": true,
          "canPublish": true,
          //----------
          "canPublishData": true,
        },
    };
    return map..addAll({'identity': participant.identity});
  }
}
