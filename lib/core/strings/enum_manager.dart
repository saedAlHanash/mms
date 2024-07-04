import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'app_color_manager.dart';

enum CubitStatuses { init, loading, done, error }

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
}

enum DiscussionStatus { open, closed }

enum FilterOperation {
  equals('Equals'),
  notEqual('NotEqual'),
  contains('Contains'),
  startsWith('StartsWith'),
  endsWith('EndsWith'),
  lessThan('LessThan'),
  lessThanEqual('LessThanEqual'),
  greaterThan('GreaterThan'),
  greaterThanEqual('GreaterThanEqual');

  const FilterOperation(this.realName);

  final String realName;

  static FilterOperation byName(String s) {
    switch (s) {
      case 'Equals':
        return FilterOperation.equals;
      case 'NotEqual':
        return FilterOperation.notEqual;
      case 'Contains':
        return FilterOperation.contains;
      case 'StartsWith':
        return FilterOperation.startsWith;
      case 'EndsWith':
        return FilterOperation.endsWith;
      case 'LessThan':
        return FilterOperation.lessThan;
      case 'LessThanEqual':
        return FilterOperation.lessThanEqual;
      case 'GreaterThan':
        return FilterOperation.greaterThan;
      case 'GreaterThanEqual':
        return FilterOperation.greaterThanEqual;
      default:
        return FilterOperation.equals;
    }
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
