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

enum PollStatus { pending, open, closed }

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

enum ApiType {
  get,
  post,
  put,
  patch,
  delete,
}

enum MeetingStatus {
  planned(color: Color(0xFFBABABA)),
  scheduled(color: Color(0xFFAA2F0A)),
  postponed(color: Color(0xFFFFB600)),
  canceled(color: Color(0xFFD73333)),
  running(color: Color(0xFF33B843)),
  completed(color: Color(0xFF3469F9)),
  archived(color: Color(0xFFFC8441));

  const MeetingStatus({
    required this.color,
  });

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

  final Color color;
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
