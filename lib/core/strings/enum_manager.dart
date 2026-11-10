import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

import '../../generated/l10n.dart';
import 'app_color_manager.dart';

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
}

enum DiscussionStatus { open, closed }

extension DiscussionStatusColors on DiscussionStatus {
  StatusColors get colors => switch (this) {
        DiscussionStatus.open => MeetingStatus.running.colors,
        DiscussionStatus.closed => MeetingStatus.archived.colors,
      };
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
