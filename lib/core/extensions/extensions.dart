import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:e_move/core/strings/app_color_manager.dart';
import 'package:e_move/core/util/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../error/error_manager.dart';
import '../strings/enum_manager.dart';
import '../util/abstraction.dart';
import '../util/pair_class.dart';
import '../util/snack_bar_message.dart';
import '../widgets/spinner_widget.dart';

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      String piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  AttachmentType getLinkType({AttachmentType? type}) {
    if (type == AttachmentType.video) {
      if (contains('youtube')) {
        return AttachmentType.youtube;
      } else {
        return AttachmentType.video;
      }
    }
    return AttachmentType.image;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  int get numberOnly {
    final regex = RegExp(r'\d+');

    final numbers = regex.allMatches(this).map((match) => match.group(0)).join();

    try {
      return int.parse(numbers);
    } on Exception {
      return 0;
    }
  }

  String fixPhone() {
    if (startsWith('0')) return this;

    return '0$this';
  }

  String get formatPrice => '$this';

  bool get isZero => (num.tryParse(this) ?? 0) == 0;

  String? checkPhoneNumber(BuildContext context, String phone) {
    if (phone.startsWith('00964') && phone.length > 11) return phone;
    if (phone.length < 10) {
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
      return null;
    } else if (phone.startsWith("0") && phone.length < 11) {
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
      return null;
    }

    if (phone.length > 10 && phone.startsWith("0")) phone = phone.substring(1);

    phone = '00964$phone';

    return phone;
  }

  String get removeSpace => replaceAll(' ', '');

  String get removeDuplicates {
    List<String> words = split(' ');
    Set<String> uniqueWords = Set<String>.from(words);
    List<String> uniqueList = uniqueWords.toList();
    String output = uniqueList.join(' ');
    return output;
  }

  OrderStatus get getOrderStatus {
    if (toLowerCase() == 'pending') return OrderStatus.pending;
    if (toLowerCase() == 'processing') return OrderStatus.processing;
    if (toLowerCase() == 'ready') return OrderStatus.ready;
    if (toLowerCase() == 'shipping') return OrderStatus.shipping;
    if (toLowerCase() == 'completed') return OrderStatus.completed;
    if (toLowerCase() == 'canceled') return OrderStatus.canceled;
    if (toLowerCase() == 'payment_failed') return OrderStatus.paymentFailed;
    if (toLowerCase() == 'returned') return OrderStatus.returned;

    return OrderStatus.pending;
  }

  num get tryParseOrZero => num.tryParse(this) ?? 0;

  int get tryParseOrZeroInt => int.tryParse(this) ?? 0;

  num? get tryParseOrNull => num.tryParse(this);

  int? get tryParseOrNullInt => int.tryParse(this);
}

extension StringHelper on String? {
  bool get isBlank {
    if (this == null) return true;
    return this!.replaceAll(' ', '').isEmpty;
  }
}

final oCcy = NumberFormat("#,###", "en_US");

extension MaxInt on num {
  int get max => 2147483647;

  String get formatPrice => oCcy.format(this);
}

extension NeedUpdateEnumH on NeedUpdateEnum {
  bool get loading => this == NeedUpdateEnum.withLoading;

  bool get haveData => this == NeedUpdateEnum.no || this == NeedUpdateEnum.noLoading;

  CubitStatuses get getState {
    switch (this) {
      case NeedUpdateEnum.no:
        return CubitStatuses.done;
      case NeedUpdateEnum.withLoading:
        return CubitStatuses.loading;
      case NeedUpdateEnum.noLoading:
        return CubitStatuses.done;
    }
  }
}

extension HelperJson on Map<String, dynamic> {
  num getAsNum(String key) {
    if (this[key] == null) return -1;
    return num.tryParse((this[key]).toString()) ?? -1;
  }
}

extension ListEnumHelper on List<Enum> {
  List<SpinnerItem> getSpinnerItems({int? selectedId, Widget? icon}) {
    return List<SpinnerItem>.from(
      map(
        (e) => SpinnerItem(
          id: e.index,
          isSelected: e.index == selectedId,
          name: e.getName,
          icon: icon,
          item: e,
        ),
      ),
    );
  }
}

extension EnumHelper on Enum {
  String get getName {
    switch (this) {
      case UpdateType.name:
        return S().changeName;
      case UpdateType.email:
        return S().changeEmail;
      case UpdateType.phone:
        return S().changePhone;
      case UpdateType.address:
        return S().changeAddress;
      case UpdateType.pass:
        return S().changePassword;
      case PaymentMethod.cash:
        return S().cashPayment;
      case PaymentMethod.ePay:
        return S().ePayment;
      case OrderStatus.pending:
        return S().pending;
      case OrderStatus.processing:
        return S().processing;
      case OrderStatus.ready:
        return S().ready;
      case OrderStatus.shipping:
        return S().shipping;
      case OrderStatus.completed:
        return S().completed;
      case OrderStatus.canceled:
        return S().canceled;
      case OrderStatus.paymentFailed:
        return S().paymentFailed;
      case OrderStatus.returned:
        return S().returned;
      case CurrencyEnum.dollar:
        return 'USD';
      case CurrencyEnum.dinar:
        return 'IQD';
      case GenderEnum.male:
        return S().mail;
      case GenderEnum.female:
        return S().female;
    }
    return name;
  }

  Color get getOrderStateColorText {
    switch (this) {
      case OrderStatus.pending:
      case OrderStatus.processing:
      case OrderStatus.ready:
      case OrderStatus.shipping:
        return AppColorManager.mainColor;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.canceled:
      case OrderStatus.paymentFailed:
      case OrderStatus.returned:
        return Colors.red;
    }
    return AppColorManager.mainColor;
  }

  String get getNameDateOrderStatus {
    switch (this) {
      case OrderStatus.pending:
        return '${S().donePending} ${S().at}'; //
      case OrderStatus.processing:
        return '${S().doneProcessing} ${S().at}'; //
      case OrderStatus.ready:
        return '${S().doneReady} ${S().at}'; //
      case OrderStatus.shipping:
        return '${S().doneShipping} ${S().at}'; //
      case OrderStatus.completed:
        return '${S().doneCompleted} ${S().at}'; //
      case OrderStatus.canceled:
        return '${S().doneCanceled} ${S().at}'; //
      case OrderStatus.paymentFailed:
        return '${S().donePaymentFailed} ${S().at}'; //
      case OrderStatus.returned:
        return '${S().doneReturned} ${S().at}'; //
    }
    return '';
  }
}

extension ResponseHelper on http.Response {
  Map<String, dynamic> get jsonBody {
    try {
      return jsonDecode(body)['data'] ?? {};
    } catch (e) {
      return jsonDecode('{}');
    }
  }

  Map<String, dynamic> get jsonBodyPure {
    try {
      return jsonDecode(body);
    } catch (e) {
      return jsonDecode('{}');
    }
  }

  // Pair<T?, String?> getPairError<T>() {
  //   return Pair(null, ErrorManager.getApiError(this));
  // }
  get getPairError {
    return Pair(null, ErrorManager.getApiError(this));
  }
}

extension CubitStatusesHelper on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;
}

extension FormatDuration on Duration {
  String get format =>
      '${inMinutes.remainder(60).toString().padLeft(2, '0')}:${(inSeconds.remainder(60)).toString().padLeft(2, '0')}';
}

extension ApiStatusCode on int {
  bool get success => (this >= 200 && this <= 210);

  //
  // int get countDiv2 {
  //   final dr = this / 2; //double result
  //   final ir = this ~/ 2; //int result
  //   return (ir < dr) ? ir + 1 : ir;
  // }
  int get countDiv2 => (this ~/ 2 < this / 2) ? this ~/ 2 + 1 : this ~/ 2;
}

extension TextEditingControllerHelper on TextEditingController {
  void clear() {
    if (text.isNotEmpty) text = '';
  }
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat('yyyy/MM/dd', 'en').format(this);

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);

  String get formatTime => DateFormat('h:mm a').format(this);

  String get formatDateTime => '$formatTime $formatDate';

  DateTime addFromNow({int? year, int? month, int? day, int? hour}) {
    return DateTime(
      this.year + (year ?? 0),
      this.month + (month ?? 0),
      this.day + (day ?? 0),
      this.hour + (hour ?? 0),
    );
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  FormatDateTime getFormat({DateTime? serverDate}) {
    final difference = this.difference(serverDate ?? DateTime.now());

    final months = difference.inDays.abs() ~/ 30;
    final days = difference.inDays.abs() % 360;
    final hours = difference.inHours.abs() % 24;
    final minutes = difference.inMinutes.abs() % 60;
    final seconds = difference.inSeconds.abs() % 60;
    return FormatDateTime(
      months: months,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  String formatDuration({DateTime? serverDate}) {
    final result = getFormat(serverDate: serverDate);

    final formattedDuration = StringBuffer();

    formattedDuration.write('منذ: ');
    var c = 0;
    if (result.months > 0) {
      c++;
      formattedDuration.write('و ${result.months} شهر ');
    }
    if (result.days > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.days} يوم  ');
    }
    if (result.hours > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.hours} ساعة  ');
    }
    if (result.minutes > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.minutes} دقيقة  ');
    }
    if (result.seconds > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.seconds} ثانية ');
    }

    return formattedDuration.toString().trim().replaceFirst('و', '');
  }
}

extension FirstItem<E> on Iterable<E> {
  E? get firstItem => isEmpty ? null : first;
}

extension GetDateTimesBetween on DateTime {
  List<DateTime> getDateTimesBetween({
    required DateTime end,
    required Duration period,
  }) {
    var dateTimes = <DateTime>[];
    var current = add(period);
    while (current.isBefore(end)) {
      if (dateTimes.length > 24) {
        break;
      }
      dateTimes.add(current);
      current = current.add(period);
    }
    return dateTimes;
  }
}

class FormatDateTime {
  final int months;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  const FormatDateTime({
    required this.months,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  String toString() {
    return '$months\n'
        '$days\n'
        '$hours\n'
        '$minutes\n'
        '$seconds\n';
  }
}
