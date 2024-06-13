import 'dart:ui';

import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

enum CubitStatuses { init, loading, done, error }

enum AttachmentType { image, youtube, video, d3 }

enum PricingMatrixType { day, date }

enum FilterItem { activity, group, country, city }

enum UpdateType { name, phone, email, address, pass }

enum PaymentMethod { cash, ePay }

enum StartPage { login, home, signupOtp, passwordOtp }

enum CurrencyEnum { dollar, dinar }

enum GenderEnum { male, female }

enum NeedUpdateEnum { no, withLoading, noLoading }

enum UpdateProfileType { normal, confirmAddPhone }

enum OrderStatus {
  pending,
  processing,
  ready,
  shipping,
  completed,
  canceled,
  paymentFailed,
  returned,
}

enum TaskType { plannedTask, meetingTask }

enum PollStatus { open, closed }

enum PartyType { member, guest }

enum MinuteStatus {
  pending,
  approved,
  rejected,
  published;
}

enum MembershipType { member, chair, secretary, guest }

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
