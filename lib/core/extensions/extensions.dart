import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_multi_type/image_multi_type.dart';
import 'package:intl/intl.dart';
import 'package:livekit_client/livekit_client.dart' as lk;
import 'package:livekit_client/livekit_client.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/features/committees/data/response/committees_response.dart';

import '../../features/meetings/data/response/meetings_response.dart';
import '../../features/members/data/response/member_response.dart';
import '../../features/poll/data/response/poll_response.dart';
import '../../generated/l10n.dart';
import '../app/app_provider.dart';
import '../app/app_widget.dart';
import '../error/error_manager.dart';
import '../strings/enum_manager.dart';
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

  String get formatPrice => this;

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

  num get tryParseOrZero => num.tryParse(this) ?? 0;

  int get tryParseOrZeroInt => int.tryParse(this) ?? 0;

  num? get tryParseOrNull => num.tryParse(this);

  int? get tryParseOrNullInt => int.tryParse(this);

  String? get validateEmpty {
    if (isEmpty) {
      return S().is_required;
    } else {
      return null;
    }
  }

  String get decimalNumbersOnly {
    final matches = RegExp(r'\d+([.,]\d+)?').allMatches(this);
    return matches.map((m) => m.group(0)).join(' ');
  }

  String get toSnakeCase {
    final regex = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(regex, (match) => '_${match.group(0)}').toLowerCase();
  }

  String get toSplitsSpaceCase {
    final regex = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(regex, (match) => '_${match.group(0)}').toLowerCase().replaceAll('_', ' ');
  }

  String get toPascalCase {
    final words = split('_');
    return words.map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }

  String get toCamelCase {
    final words = split('_');
    if (words.isEmpty) return '';
    final capitalized = words.map((word) => word[0].toUpperCase() + word.substring(1)).join();
    return capitalized[0].toLowerCase() + capitalized.substring(1);
  }

  Color get colorFromId {
    final hash = hashCode;
    final hue = (hash % 360).toDouble(); // 0 → 360
    const saturation = 0.6; // تشبع متوسط
    const lightness = 0.5; // سطوع متوسط

    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  Widget get copySymbol {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: this));
            ScaffoldMessenger.of(ctx!).showSnackBar(
              SnackBar(content: Text(S().done)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white12,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0).r,
            margin: EdgeInsets.symmetric(vertical: 3.0).r,
            child: DrawableText(
              text: this,
              maxLength: 4,
              drawablePadding: 5.0.w,
              drawableEnd: ImageMultiType(
                url: Icons.copy,
                height: 15.0.r,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color get gradeColor {
    final upperCaseGrade = toUpperCase();
    if (upperCaseGrade.contains('A')) {
      return Colors.green;
    } else if (upperCaseGrade.contains('B')) {
      return Colors.blue;
    } else if (upperCaseGrade.contains('C')) {
      return Colors.yellow;
    } else if (upperCaseGrade.contains('D')) {
      return Colors.orange;
    } else if (upperCaseGrade.contains('F')) {
      return Colors.red;
    } else {
      // Return a default color or throw an error for unknown grades
      return Colors.grey; // Or throw ArgumentError('Invalid grade: $this');
    }
  }

  String get firstCharacter {
    if (isEmpty) {
      return '';
    }
    return this[0];
  }
}

extension StringHelper on String? {
  String fixUrl({String? initialImage}) {
    if (initialImage.isBlank) return initialImage ?? '';

    final type = ImageMultiType.initialType(fixAvatarImage(this));

    if (type == ImageType.tempImg) return initialImage ?? '';

    return fixAvatarImage(this);
  }
}

String fixAvatarImage(String? image) {
  if (image.isBlank) return '';
  if (image!.startsWith('http')) return image;
  final String link = "https://mms.coretech-mena.com/documents/$image";
  return link;
}

final oCcy = NumberFormat("#,###", "en_US");

extension MaxInt on num {
  int get max => 2147483647;

  String get formatPrice => oCcy.format(this);
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
          name: e.name,
          icon: icon,
          item: e,
        ),
      ),
    );
  }
}

extension EnumHelper on Enum {
  Color get getColorForRecord {
    switch (this) {
      case MembershipType.member:
        return Colors.white;
      case MembershipType.chair:
        return Colors.green.withValues(alpha: 0.3);
      case MembershipType.secretary:
        return AppColorManager.ampere.withValues(alpha: 0.3);
      default:
        return Colors.white;
    }
  }
}

extension ResponseHelper on http.Response {
  Map<String, dynamic> get jsonBodyPure {
    try {
      return jsonDecode(body) ?? {};
    } catch (e) {
      return jsonDecode('{}');
    }
  }

  Map<String, dynamic> get jsonBody {
    try {
      if (body.startsWith('[')) {
        final convertString = '{"data": $body}';
        final json = jsonDecode(convertString);
        return json;
      }
      return jsonDecode(body);
    } catch (e) {
      loggerObject.e(e);
      return jsonDecode('{}');
    }
  }

  // Pair<T?, String?> getPairError<T>() {
  //   return Pair(null, ErrorManager.getApiError(this));
  // }
  Pair<Null, String> get getPairError {
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

  String get formatDateToRequest => DateFormat('yyyy-MM-dd', 'en').format(this);

  String get formatTime => DateFormat('h:mm a').format(this);

  String get formatDateTime => '$formatDate $formatTime';

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

extension CommitteeHelper on Committee {
  Member get getMeAsMember {
    members.firstWhereOrNull(
      (e) => e.partyId == AppProvider.getCurrentCommittee.member.partyId,
    );
    return Member.fromJson({});
  }
}

extension MemberHelper on Member {
  bool get isMe {
    return id == AppProvider.getCurrentCommittee.member.id;
  }
}

extension PoolH on Poll {
  List<SpinnerItem> getSpinnerItems({String? selectedId}) {
    return List<SpinnerItem>.from(
      options.mapIndexed(
        (i, e) => SpinnerItem(
          id: i,
          isSelected: e.id == selectedId,
          name: e.option,
          item: e,
        ),
      ),
    );
  }

  Option? get meOptionVote {
    for (var e in options) {
      for (var v in e.voters) {
        if (v.partyId == AppProvider.getParty.id) {
          return e;
        }
      }
    }
    return null;
  }

  int get votersCount {
    final count = options.map((e) => e.voters.length).reduce((a, b) => a + b);
    return count;
  }
}

extension PollResultH on PollResult {
  int get votersCount {
    final count = voteResults.map((e) => e.voteCount).reduce((a, b) => a + b);
    return count;
  }
}

extension OptionH on Option {
  String? get voteId => voters.firstWhereOrNull((e) => e.partyId == AppProvider.getParty.id)?.id;
}

extension MeetingH on Meeting {
  int get countPollsNotVotes {
    int i = 0;
    for (var e in polls) {
      if (e.status == PollStatus.closed) continue;
      if (e.meOptionVote != null) continue;
      i += 1;
    }
    return i;
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

extension ParticipantH on Participant {
  RemoteParticipant get remoteParticipant => this as RemoteParticipant;

  LocalParticipant get localParticipant => this as LocalParticipant;

  MediaType get type => videoTrackPublications.any((e) => e.isScreenShare) ? MediaType.screen : MediaType.media;

  RemoteTrackPublication<RemoteVideoTrack>? get remoteVideoPublication {
    return remoteParticipant.videoTrackPublications.where((e) => e.source == type.videoSourceType).firstOrNull;
  }

  List<RemoteTrackPublication<RemoteVideoTrack>> get remoteVideoPublications {
    return remoteParticipant.videoTrackPublications /*.where((e) => e.source == type.videoSourceType).toList()*/;
  }

  RemoteTrackPublication<RemoteAudioTrack>? get remoteAudioPublication =>
      remoteParticipant.audioTrackPublications.where((e) => e.source == type.audioSourceType).firstOrNull;

  LocalTrackPublication<LocalVideoTrack>? get localVideoPublication {
    return localParticipant.videoTrackPublications.where((e) => e.source == type.videoSourceType).firstOrNull;
  }

  LocalTrackPublication<LocalAudioTrack>? get localAudioPublication =>
      localParticipant.audioTrackPublications.where((e) => e.source == type.audioSourceType).firstOrNull;

  String get image => attributes['imageUrl'].toString();

  //
  // LocalTrackPublication<LocalVideoTrack>? get videoPublication {
  //   return remoteParticipant.videoTrackPublications.where((e) => e.source == type.videoSourceType).firstOrNull;
  // }
  //
  // LocalTrackPublication<LocalAudioTrack>? get audioPublication =>
  //     remoteParticipant.audioTrackPublications.where((e) => e.source == type.audioSourceType).firstOrNull;

  VideoTrack? get activeVideoTrack =>
      (this is LocalParticipant) ? localVideoPublication?.track : remoteVideoPublication?.track;

  AudioTrack? get activeAudioTrack =>
      (this is LocalParticipant) ? localAudioPublication?.track : remoteAudioPublication?.track;

  bool get videoActive => activeVideoTrack != null && !activeVideoTrack!.muted;

  bool get audioActive => activeAudioTrack != null && !activeAudioTrack!.muted;

  LkUserType get userType => LkUserType.values[(attributes['lkUserType'] ?? 0).toString().tryParseOrZeroInt];

  String get displayName {
    if (name.isNotEmpty) return name;
    if (identity.isNotEmpty) return identity;
    return sid;
  }

  String get statusName {
    if (permissions.isSuspend) return 'معلق';
    if (permissions.isSilence) return 'مستمع';
    if (permissions.isAll) return 'متحدث';

    return 'غير معروف';
  }

  bool get isSuspend => permissions.isSuspend;
}

extension RemoteParticipantH on RemoteParticipant {
  RemoteAudioTrack? get activeAudioTrack => audioTrackPublications.firstWhereOrNull((e) => e.enabled)?.track;

  RemoteVideoTrack? get shareScreenTrack => videoTrackPublications.firstWhereOrNull((e) => e.isScreenShare)?.track;

  RemoteVideoTrack? get cameraTrack => videoTrackPublications.firstWhereOrNull((e) => !e.isScreenShare)?.track;
}

extension LocalParticipantH on LocalParticipant {
  LocalAudioTrack? get activeAudioTrack => audioTrackPublications.firstWhereOrNull((e) => !e.muted)?.track;

  LocalVideoTrack? get shareScreenTrack => videoTrackPublications.firstWhereOrNull((e) => e.isScreenShare)?.track;

  LocalVideoTrack? get cameraTrack => videoTrackPublications.firstWhereOrNull((e) => !e.isScreenShare)?.track;
}

extension ParticipantPermissionsH on ParticipantPermissions {
  bool get isSuspend => !canSubscribe && !canPublish;

  bool get isSilence => !canPublish && canSubscribe;

  bool get isAll => canSubscribe && canPublish;

  String get printFun {
    return 'canSubscribe: $canSubscribe\n'
        'canPublish: $canPublish\n'
        'canPublishData: $canPublishData\n'
        'canUpdateMetadata: $canUpdateMetadata\n'
        'hidden: $hidden';
  }
}

extension ConnectionQualityH on ConnectionQuality {
  Widget get icon => ImageMultiType(
        url: this == ConnectionQuality.poor ? Icons.wifi_off_outlined : Icons.wifi,
        color: {
          ConnectionQuality.excellent: Colors.green,
          ConnectionQuality.good: Colors.orange,
          ConnectionQuality.poor: Colors.red,
        }[this],
        height: 16.0.dg,
      );
}

extension ConnectionStateH on lk.ConnectionState {
  bool get isDisconnected => this == lk.ConnectionState.disconnected;

  bool get isConnecting => this == lk.ConnectionState.connecting;

  bool get isReconnecting => this == lk.ConnectionState.reconnecting;

  bool get isConnected => this == lk.ConnectionState.connected;
}
