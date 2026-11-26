// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(count) => "${count} غياب";

  static String m1(count) => "${count} متتالية";

  static String m2(role) => "أنت تعمل بصفة ${role}";

  static String m3(role, date) => "أنت تعمل بصفة ${role} حتى ${date}";

  static String m4(attended, invited) => "حضر ${attended} من ${invited}";

  static String m5(seconds) => "رمز جديد خلال ${seconds} ث";

  static String m6(count) => "الأصوات (${count})";

  static String m7(count) => "${count} بانتظار صوتك";

  static String m8(days, hours) => "يُغلق خلال ${days} يوم و${hours} ساعة";

  static String m9(hours, minutes) =>
      "يُغلق خلال ${hours} ساعة و${minutes} دقيقة";

  static String m10(minutes) => "يُغلق خلال ${minutes} دقيقة";

  static String m11(count) =>
      "${Intl.plural(count, zero: 'لا لجان', one: 'لجنة واحدة', two: 'لجنتان', few: '${count} لجان', many: '${count} لجنة', other: '${count} لجنة')}";

  static String m12(count) => "${count} قرارات";

  static String m13(name) => "بتفويض من ${name}";

  static String m14(from, to) => "من ${from} إلى ${to}";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'لا نقاشات', one: 'نقاش واحد', two: 'نقاشان', few: '${count} نقاشات', many: '${count} نقاشاً', other: '${count} نقاش')}";

  static String m16(count) =>
      "${Intl.plural(count, zero: 'لا وثائق', one: 'وثيقة واحدة', two: 'وثيقتان', few: '${count} وثائق', many: '${count} وثيقة', other: '${count} وثيقة')}";

  static String m17(date) => "تستحق في ${date}";

  static String m18(name, count) => "${name} × ${count}";

  static String m19(count) => "${count} بعذر";

  static String m20(name) => "من ${name}";

  static String m21(count) =>
      "${Intl.plural(count, zero: 'لا أهداف', one: 'هدف واحد', two: 'هدفان', few: '${count} أهداف', many: '${count} هدفاً', other: '${count} هدف')}";

  static String m22(count) => "إخفاء البنود الفرعية (${count})";

  static String m23(count) => "ضيافة لـ ${count} أشخاص";

  static String m24(title, status) => "«${title}»: ${status}";

  static String m25(count) => "${count} في القاعة";

  static String m26(count) =>
      "${Intl.plural(count, zero: 'لا بنود', one: 'بند واحد', two: 'بندان', few: '${count} بنود', many: '${count} بنداً', other: '${count} بند')}";

  static String m27(count) => "${count} د";

  static String m28(count) => "قائمة الانتظار (${count})";

  static String m29(time) => "وقت كل متحدث: ${time}";

  static String m30(place) => "ترتيبك ${place} في قائمة الانتظار";

  static String m31(count) =>
      "${Intl.plural(count, zero: 'لا اجتماعات', one: 'اجتماع واحد', two: 'اجتماعان', few: '${count} اجتماعات', many: '${count} اجتماعاً', other: '${count} اجتماع')}";

  static String m32(count) => "يلزم ${count} اجتماعات أخرى لبلوغ الحد الأدنى";

  static String m33(count) =>
      "${Intl.plural(count, zero: 'لا أعضاء', one: 'عضو واحد', two: 'عضوان', few: '${count} أعضاء', many: '${count} عضواً', other: '${count} عضو')}";

  static String m34(date) => "الرد قبل ${date}";

  static String m35(approved, total) => "اعتمده ${approved} من ${total}";

  static String m36(count) => "${count} رفض";

  static String m37(count) => "اقتراحاتي (${count})";

  static String m38(count) => "لم يصوّتوا بعد (${count})";

  static String m39(count) => "${count} بانتظار الرد";

  static String m40(present, required) =>
      "النصاب مكتمل: ${present} من ${required}";

  static String m41(present, required) =>
      "النصاب غير مكتمل: ${present} من ${required}";

  static String m42(present, required) =>
      "${present} حاضر من ${required} مطلوب";

  static String m43(count) => "منهم ${count} بالإنابة";

  static String m44(time) => "سُجّل عند بدء الاجتماع الساعة ${time}";

  static String m45(value) => "يتطلّب ${value} أعضاء";

  static String m46(value, base) => "يتطلّب ${value}% من ${base} أعضاء";

  static String m47(hall, remote) => "${hall} في القاعة · ${remote} عن بُعد";

  static String m48(name) => "رفعها ${name}";

  static String m49(count) => "${count} تحفظات";

  static String m50(name) => "ردّ عليها ${name}";

  static String m51(name) => "سيتوقف ${name} عن التصرّف عنك فوراً.";

  static String m52(count) => "عرض البنود الفرعية (${count})";

  static String m53(count) => "اللجان الفرعية (${count})";

  static String m54(count) =>
      "${Intl.plural(count, zero: 'لا مهام', one: 'مهمة واحدة', two: 'مهمتان', few: '${count} مهام', many: '${count} مهمة', other: '${count} مهمة')}";

  static String m55(name) => "مهام ${name}";

  static String m56(name) => "إلى ${name}";

  static String m57(voted, total) => "صوّت ${voted} من ${total}";

  static String m58(count) => "${count} بانتظار تصويتك";

  static String m59(count) => "${count} منجزة هذا العام";

  static String m60(count) => "${count} تستحق هذا الأسبوع";

  static String m61(count) => "${count} مفتوحة";

  static String m62(count) => "${count} متأخرة";

  static String m63(choice) => "صوّتَّ «${choice}». يمكنك تغييره حتى الإغلاق.";

  static String m64(choice) => "صوتك: ${choice}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("من نحن"),
    "aboutUs": MessageLookupByLibrary.simpleMessage("معلومات عنا"),
    "absenceAccepted": MessageLookupByLibrary.simpleMessage("تم قبول الاعتذار"),
    "absenceAcceptedState": MessageLookupByLibrary.simpleMessage("معتذر"),
    "absenceExcusedHint": MessageLookupByLibrary.simpleMessage(
      "أنت معتذر عن هذا الاجتماع.",
    ),
    "absencePending": MessageLookupByLibrary.simpleMessage("بانتظار الرد"),
    "absenceRejected": MessageLookupByLibrary.simpleMessage("تم رفض الاعتذار"),
    "absenceRejectedHint": MessageLookupByLibrary.simpleMessage(
      "لم يقبل الرئيس طلبك.",
    ),
    "absenceRejectedState": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "absenceRequestSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال طلبك إلى الرئيس",
    ),
    "absenceRequests": MessageLookupByLibrary.simpleMessage("طلبات الاعتذار"),
    "absenceRequestsHint": MessageLookupByLibrary.simpleMessage(
      "الأعضاء الذين طلبوا الاعتذار عن هذا الاجتماع.",
    ),
    "absenceWaitingChair": MessageLookupByLibrary.simpleMessage(
      "بانتظار رد الرئيس.",
    ),
    "absencesCount": m0,
    "absencesInRow": m1,
    "acceptAbsence": MessageLookupByLibrary.simpleMessage("قبول"),
    "acceptAbsenceTitle": MessageLookupByLibrary.simpleMessage(
      "قبول طلب الاعتذار؟",
    ),
    "acceptNeedsAgendaItem": MessageLookupByLibrary.simpleMessage(
      "أضف البند إلى جدول الأعمال من الويب أولاً، ثم اقبل الاقتراح من هنا.",
    ),
    "acceptProposal": MessageLookupByLibrary.simpleMessage("قبول"),
    "acceptProposalHint": MessageLookupByLibrary.simpleMessage(
      "اختر البند الذي أضفته لهذا الاقتراح.",
    ),
    "acceptProposalTitle": MessageLookupByLibrary.simpleMessage(
      "ما البند المقابل في جدول الأعمال؟",
    ),
    "accountCreated": MessageLookupByLibrary.simpleMessage("تم إنشاء الحساب!"),
    "actingAs": m2,
    "actingAsUntil": m3,
    "addComment": MessageLookupByLibrary.simpleMessage("إضافة تعليق"),
    "addCorectData": MessageLookupByLibrary.simpleMessage(
      "يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء",
    ),
    "addDelegation": MessageLookupByLibrary.simpleMessage("إضافة تفويض"),
    "addDelegationHint": MessageLookupByLibrary.simpleMessage(
      "تبقى صفتك لك خلال الفترة، ويتصرّف العضو عنك في المجالات التي تختارها فقط.",
    ),
    "addGuest": MessageLookupByLibrary.simpleMessage("إضافة ضيف"),
    "addGuestHint": MessageLookupByLibrary.simpleMessage(
      "كل الحقول مطلوبة. يظهر الضيف ضمن «ضيوف مقترحون» بعد الإرسال.",
    ),
    "addReview": MessageLookupByLibrary.simpleMessage("إضافة تقييم"),
    "add_to_cart": MessageLookupByLibrary.simpleMessage("أضف للسلة"),
    "additional_service": MessageLookupByLibrary.simpleMessage("خدمة إضافية"),
    "agendaItem": MessageLookupByLibrary.simpleMessage("بند جدول الأعمال"),
    "agendaProposals": MessageLookupByLibrary.simpleMessage("اقتراح بنود"),
    "agendaProposalsClosed": MessageLookupByLibrary.simpleMessage(
      "المقترحات مغلقة لهذا الاجتماع.",
    ),
    "agendaProposalsHint": MessageLookupByLibrary.simpleMessage(
      "اقترح بنداً قبل نشر جدول الأعمال.",
    ),
    "agendaRequestAccepted": MessageLookupByLibrary.simpleMessage("مقبول"),
    "agendaRequestClosed": MessageLookupByLibrary.simpleMessage("مغلق"),
    "agendaRequestPending": MessageLookupByLibrary.simpleMessage(
      "بانتظار الرد",
    ),
    "agendaRequestRejected": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "agendaStatusActive": MessageLookupByLibrary.simpleMessage("جارٍ الآن"),
    "agendaStatusConcluded": MessageLookupByLibrary.simpleMessage("منتهٍ"),
    "agendaStatusDelayed": MessageLookupByLibrary.simpleMessage("مؤجّل"),
    "agendaStatusPending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "agendas": MessageLookupByLibrary.simpleMessage("جداول الأعمال"),
    "all": MessageLookupByLibrary.simpleMessage("الكل"),
    "allMembers": MessageLookupByLibrary.simpleMessage("كل الأعضاء"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "هل لديك حساب بالفعل؟",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("تطبيق"),
    "apply_filters": MessageLookupByLibrary.simpleMessage("تطبيق الفلاتر"),
    "approvalNeedsHalf": MessageLookupByLibrary.simpleMessage(
      "يُعتمد القرار عندما تتجاوز الموافقات نصف أوزان جميع المصوّتين. الامتناع وعدم التصويت يُحتسبان ضده.",
    ),
    "approvalWeight": MessageLookupByLibrary.simpleMessage("نسبة الموافقة"),
    "approve": MessageLookupByLibrary.simpleMessage("اعتماد"),
    "approveRecommendationTitle": MessageLookupByLibrary.simpleMessage(
      "اعتماد هذه التوصية؟",
    ),
    "approved": MessageLookupByLibrary.simpleMessage("تمت الموافقة"),
    "approvedState": MessageLookupByLibrary.simpleMessage("معتمد"),
    "ar": MessageLookupByLibrary.simpleMessage("عربي"),
    "archived": MessageLookupByLibrary.simpleMessage("مؤرشف"),
    "at": MessageLookupByLibrary.simpleMessage("عند"),
    "attachFileOptional": MessageLookupByLibrary.simpleMessage(
      "إرفاق ملف (اختياري)",
    ),
    "attachment": MessageLookupByLibrary.simpleMessage("المرفق"),
    "attachmentLimit": MessageLookupByLibrary.simpleMessage("حتى 10 ميغابايت"),
    "attachmentTooLarge": MessageLookupByLibrary.simpleMessage(
      "حجم الملف أكبر من 10 ميغابايت.",
    ),
    "attendanceCompliance": MessageLookupByLibrary.simpleMessage(
      "الالتزام بالحضور",
    ),
    "attendanceNotRecorded": MessageLookupByLibrary.simpleMessage(
      "لم يُسجَّل الحضور",
    ),
    "attendanceRecorded": MessageLookupByLibrary.simpleMessage("سُجّل الحضور"),
    "attendanceSubtitleLead": MessageLookupByLibrary.simpleMessage(
      "اجتماعات هذا العام والأعضاء المعرّضون للتجاوز",
    ),
    "attendanceSubtitleMember": MessageLookupByLibrary.simpleMessage(
      "حضورك هذا العام",
    ),
    "attendanceUnavailable": MessageLookupByLibrary.simpleMessage(
      "الالتزام بالحضور غير متاح",
    ),
    "attendedOf": m4,
    "attendees": MessageLookupByLibrary.simpleMessage("الحضور"),
    "attendeesAndGuests": MessageLookupByLibrary.simpleMessage(
      "الحضور والضيوف",
    ),
    "awaitingYourVote": MessageLookupByLibrary.simpleMessage("بانتظار صوتك"),
    "back": MessageLookupByLibrary.simpleMessage("عودة"),
    "backToLogin": MessageLookupByLibrary.simpleMessage("العودة لتسجيل الدخول"),
    "basicInfo": MessageLookupByLibrary.simpleMessage("البيانات الأساسية"),
    "birthday": MessageLookupByLibrary.simpleMessage("تاريخ الميلاد"),
    "build": MessageLookupByLibrary.simpleMessage("رقم الإصدار"),
    "buildNumber": MessageLookupByLibrary.simpleMessage("رقم الإصدار"),
    "cameraOff": MessageLookupByLibrary.simpleMessage("إيقاف الكاميرا"),
    "cameraOn": MessageLookupByLibrary.simpleMessage("تشغيل الكاميرا"),
    "cameraPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "اسمح بالوصول إلى الكاميرا من الإعدادات للمسح، أو أدخل الرمز في الأسفل.",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "الكاميرا غير متاحة. أدخل الرمز في الأسفل.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelRequest": MessageLookupByLibrary.simpleMessage("إلغاء الطلب"),
    "cancelServiceTitle": MessageLookupByLibrary.simpleMessage(
      "إلغاء هذا الطلب؟",
    ),
    "canceled": MessageLookupByLibrary.simpleMessage("ملغي"),
    "cantAttend": MessageLookupByLibrary.simpleMessage("لن تتمكن من الحضور؟"),
    "cantAttendHint": MessageLookupByLibrary.simpleMessage(
      "اطلب من الرئيس إعفاءك من هذا الاجتماع.",
    ),
    "card_name": MessageLookupByLibrary.simpleMessage("اسم البطاقة"),
    "card_number": MessageLookupByLibrary.simpleMessage("رقم البطاقة"),
    "cart": MessageLookupByLibrary.simpleMessage("السلة"),
    "cashPayment": MessageLookupByLibrary.simpleMessage("دفع نقدي"),
    "categories": MessageLookupByLibrary.simpleMessage("تصنيفات"),
    "chair": MessageLookupByLibrary.simpleMessage("رئيس"),
    "changeAddress": MessageLookupByLibrary.simpleMessage("تغيير العنوان"),
    "changeEmail": MessageLookupByLibrary.simpleMessage(
      "تغيير البريد الإلكتروني",
    ),
    "changeFile": MessageLookupByLibrary.simpleMessage("تعديل الملف"),
    "changeLanguage": MessageLookupByLibrary.simpleMessage("تغيير اللغة"),
    "changeName": MessageLookupByLibrary.simpleMessage("تغيير الاسم"),
    "changePass": MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
    "changePhone": MessageLookupByLibrary.simpleMessage("تغيير رقم الهاتف"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("تغيير الصورة الشخصية"),
    "changeVote": MessageLookupByLibrary.simpleMessage("تغيير الصوت"),
    "checkIn": MessageLookupByLibrary.simpleMessage("تسجيل الحضور"),
    "checkInAlready": MessageLookupByLibrary.simpleMessage(
      "حضورك مسجّل مسبقاً",
    ),
    "checkInAt": MessageLookupByLibrary.simpleMessage("الساعة"),
    "checkInCardHint": MessageLookupByLibrary.simpleMessage(
      "سجّل وصولك برمز QR الموجود عند باب القاعة.",
    ),
    "checkInCardTitle": MessageLookupByLibrary.simpleMessage(
      "تسجيل الحضور في القاعة",
    ),
    "checkInCodeHint": MessageLookupByLibrary.simpleMessage(
      "يمسح الحضور هذا الرمز من التطبيق لتسجيل حضورهم.",
    ),
    "checkInCodeNext": m5,
    "checkInCodeShow": MessageLookupByLibrary.simpleMessage(
      "عرض رمز QR للقاعة",
    ),
    "checkInCodeShowHint": MessageLookupByLibrary.simpleMessage(
      "اعرضه على تابلت عند الباب لتسجيل الحضور.",
    ),
    "checkInCodeTitle": MessageLookupByLibrary.simpleMessage("رمز QR للقاعة"),
    "checkInCodeUnavailable": MessageLookupByLibrary.simpleMessage(
      "الرمز غير متاح",
    ),
    "checkInDone": MessageLookupByLibrary.simpleMessage("سُجّل حضورك"),
    "checkInInHall": MessageLookupByLibrary.simpleMessage("في القاعة"),
    "checkInOnline": MessageLookupByLibrary.simpleMessage("عن بُعد"),
    "checkInOtherMeeting": MessageLookupByLibrary.simpleMessage(
      "هذا الرمز لاجتماع آخر.",
    ),
    "checkInScanButton": MessageLookupByLibrary.simpleMessage("امسح الرمز"),
    "checkInScanHint": MessageLookupByLibrary.simpleMessage(
      "وجّه الكاميرا نحو رمز QR عند باب القاعة.",
    ),
    "checkInTypeCode": MessageLookupByLibrary.simpleMessage(
      "اكتب الرمز المكوّن من ستة أرقام الظاهر أسفل رمز QR",
    ),
    "checkedInAt": MessageLookupByLibrary.simpleMessage("سُجّل حضورك الساعة"),
    "choosing": MessageLookupByLibrary.simpleMessage("اختر"),
    "circulation": MessageLookupByLibrary.simpleMessage("قرار بالتمرير"),
    "circulationAbstain": MessageLookupByLibrary.simpleMessage("ممتنع"),
    "circulationApprove": MessageLookupByLibrary.simpleMessage("موافق"),
    "circulationApproved": MessageLookupByLibrary.simpleMessage("معتمد"),
    "circulationClosed": MessageLookupByLibrary.simpleMessage("مغلق"),
    "circulationDraft": MessageLookupByLibrary.simpleMessage("مسودة"),
    "circulationNotFound": MessageLookupByLibrary.simpleMessage(
      "تعذّر تحميل هذا القرار",
    ),
    "circulationOpen": MessageLookupByLibrary.simpleMessage("مفتوح"),
    "circulationReasonHint": MessageLookupByLibrary.simpleMessage(
      "أضف سبباً مختصراً لصوتك",
    ),
    "circulationReject": MessageLookupByLibrary.simpleMessage("غير موافق"),
    "circulationRejected": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "circulationResult": MessageLookupByLibrary.simpleMessage("النتيجة"),
    "circulationVoteSaved": MessageLookupByLibrary.simpleMessage("حُفظ صوتك"),
    "circulationVotes": m6,
    "circulationVotingClosed": MessageLookupByLibrary.simpleMessage(
      "انتهى الموعد وأُغلق التصويت.",
    ),
    "circulationWithdrawn": MessageLookupByLibrary.simpleMessage("مسحوب"),
    "circulations": MessageLookupByLibrary.simpleMessage("القرارات بالتمرير"),
    "circulationsAwaiting": m7,
    "circulationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "التصويت على القرارات دون اجتماع",
    ),
    "city": MessageLookupByLibrary.simpleMessage("المدينة"),
    "clearAll": MessageLookupByLibrary.simpleMessage("إلغاء الكل"),
    "clickToUpdate": MessageLookupByLibrary.simpleMessage("انقر للتعديل"),
    "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
    "closedAt": MessageLookupByLibrary.simpleMessage("أُغلق"),
    "closesInDaysHours": m8,
    "closesInHoursMinutes": m9,
    "closesInMinutes": m10,
    "codeSentToEmail": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رمز التأكيد إلى البريد الإلكتروني: ",
    ),
    "code_invalid": MessageLookupByLibrary.simpleMessage("هذا الكود غير صالح"),
    "collapse": MessageLookupByLibrary.simpleMessage("طيّ اللوحة"),
    "color": MessageLookupByLibrary.simpleMessage("اللون"),
    "colors": MessageLookupByLibrary.simpleMessage("الألوان"),
    "commentHint": MessageLookupByLibrary.simpleMessage(
      "تعليق واحد لكل بند، ولا يمكن تعديله بعد الإرسال.",
    ),
    "committeeCalendar": MessageLookupByLibrary.simpleMessage("تقويم اللجنة"),
    "committeeDescription": MessageLookupByLibrary.simpleMessage("وصف اللجنة"),
    "committeeMeetings": MessageLookupByLibrary.simpleMessage(
      "اجتماعات اللجنة",
    ),
    "committeeStatement": MessageLookupByLibrary.simpleMessage("بيان اللجنة"),
    "committeesCount": m11,
    "company": MessageLookupByLibrary.simpleMessage("جهة العمل"),
    "completed": MessageLookupByLibrary.simpleMessage("منتهي"),
    "complianceOk": MessageLookupByLibrary.simpleMessage("ضمن الحد"),
    "complianceReached": MessageLookupByLibrary.simpleMessage("تجاوز الحد"),
    "complianceWarning": MessageLookupByLibrary.simpleMessage("قريب من الحد"),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmAddress": MessageLookupByLibrary.simpleMessage("تأكيد العنوان"),
    "confirmCode": MessageLookupByLibrary.simpleMessage("أدخل رمز التأكيد"),
    "confirmMethod": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار كيفية إرسال رمز التحقق",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور الجديدة",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "confirmPayment": MessageLookupByLibrary.simpleMessage("تم الشراء بنجاح"),
    "confirmYourPhone": MessageLookupByLibrary.simpleMessage(
      "اكد على رقم هاتفك او جوالك",
    ),
    "confirm_address": MessageLookupByLibrary.simpleMessage("تأكيد العنوان"),
    "confirmation": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "connect": MessageLookupByLibrary.simpleMessage("الاتصال"),
    "connected": MessageLookupByLibrary.simpleMessage("متصل"),
    "connectionSuspendedTitle": MessageLookupByLibrary.simpleMessage(
      "اتصالك معلّق مؤقتاً",
    ),
    "contact": MessageLookupByLibrary.simpleMessage("اتصل بنا"),
    "continueSignUp": MessageLookupByLibrary.simpleMessage("استكمال التسجيل"),
    "continueTo": MessageLookupByLibrary.simpleMessage("متابعة"),
    "country": MessageLookupByLibrary.simpleMessage("البلد"),
    "coupon_code": MessageLookupByLibrary.simpleMessage("كود الخصم"),
    "courses": MessageLookupByLibrary.simpleMessage("الكورسات"),
    "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "createNewAccount": MessageLookupByLibrary.simpleMessage("انشاء حساب جديد"),
    "currency": MessageLookupByLibrary.simpleMessage("العملة"),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور الحالية",
    ),
    "cvc": MessageLookupByLibrary.simpleMessage("الرقم السري"),
    "days": MessageLookupByLibrary.simpleMessage("أيام"),
    "deadline": MessageLookupByLibrary.simpleMessage("موعد الإغلاق"),
    "deadlinePassed": MessageLookupByLibrary.simpleMessage("انتهى الموعد"),
    "decidedByChair": MessageLookupByLibrary.simpleMessage("بصوت الرئيس"),
    "decisionText": MessageLookupByLibrary.simpleMessage("نص القرار"),
    "decisions": MessageLookupByLibrary.simpleMessage("القرارات"),
    "decisionsCount": m12,
    "declare": MessageLookupByLibrary.simpleMessage("إفصاح"),
    "declareInterest": MessageLookupByLibrary.simpleMessage(
      "الإفصاح عن تعارض مصالح",
    ),
    "declareInterestHint": MessageLookupByLibrary.simpleMessage(
      "لن تُحتسب في نصاب هذا البند ولا في أغلبيته، وقد لا يمكنك التصويت على تصويتاته.",
    ),
    "delegateAction": MessageLookupByLibrary.simpleMessage("تفويض"),
    "delegateTo": MessageLookupByLibrary.simpleMessage("التفويض إلى"),
    "delegatedBy": m13,
    "delegationActive": MessageLookupByLibrary.simpleMessage("ساري"),
    "delegationAdded": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة التفويض",
    ),
    "delegationAllScopes": MessageLookupByLibrary.simpleMessage("كل المجالات"),
    "delegationEnded": MessageLookupByLibrary.simpleMessage("منتهٍ"),
    "delegationEnds": MessageLookupByLibrary.simpleMessage("إلى"),
    "delegationFromTo": m14,
    "delegationPeriod": MessageLookupByLibrary.simpleMessage("الفترة"),
    "delegationPeriodHint": MessageLookupByLibrary.simpleMessage(
      "حتى سنة كحد أقصى، وينتهي بنهاية اليوم الأخير.",
    ),
    "delegationReasonHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: سفر لحضور مؤتمر",
    ),
    "delegationReasonOptional": MessageLookupByLibrary.simpleMessage(
      "السبب (اختياري)",
    ),
    "delegationRevoked": MessageLookupByLibrary.simpleMessage("تم سحب التفويض"),
    "delegationRevokedState": MessageLookupByLibrary.simpleMessage("مسحوب"),
    "delegationRole": MessageLookupByLibrary.simpleMessage("الصفة"),
    "delegationScopes": MessageLookupByLibrary.simpleMessage("المجالات"),
    "delegationStarts": MessageLookupByLibrary.simpleMessage("من"),
    "delegationUpcoming": MessageLookupByLibrary.simpleMessage("قادم"),
    "delegations": MessageLookupByLibrary.simpleMessage("التفويضات"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
    "deliveryDate": MessageLookupByLibrary.simpleMessage("تاريخ التسليم "),
    "description": MessageLookupByLibrary.simpleMessage("الوصف"),
    "devBy": MessageLookupByLibrary.simpleMessage("تم التطوير بواسطة"),
    "didNotReceiveOTP": MessageLookupByLibrary.simpleMessage("لم تتلقَ الرمز؟"),
    "dinar": MessageLookupByLibrary.simpleMessage("دينار"),
    "discussion": MessageLookupByLibrary.simpleMessage("نقاش"),
    "discussions": MessageLookupByLibrary.simpleMessage("نقاشات"),
    "discussionsCount": m15,
    "doNotHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "لا تمتلك حساب؟",
    ),
    "documents": MessageLookupByLibrary.simpleMessage("المستندات"),
    "documentsCount": m16,
    "dollar": MessageLookupByLibrary.simpleMessage("دولار"),
    "done": MessageLookupByLibrary.simpleMessage("تم"),
    "doneCanceled": MessageLookupByLibrary.simpleMessage("تم إلغاؤه"),
    "doneCompleted": MessageLookupByLibrary.simpleMessage("تم إكماله"),
    "donePaymentFailed": MessageLookupByLibrary.simpleMessage(
      "فشل عملية الدفع",
    ),
    "donePending": MessageLookupByLibrary.simpleMessage("تم إنشاءه"),
    "donePick": MessageLookupByLibrary.simpleMessage("تم الاختيار"),
    "doneProcessing": MessageLookupByLibrary.simpleMessage("تمت معالجته"),
    "doneReady": MessageLookupByLibrary.simpleMessage("تم تحضيره"),
    "doneReturned": MessageLookupByLibrary.simpleMessage("تم الإرجاع"),
    "doneSendCode": MessageLookupByLibrary.simpleMessage(
      "تم ارسال الكود! إذا لزم الأمر، يمكننا إعادة إرسال الرمز حتى مرتين إضافيتين.",
    ),
    "doneSendSms": MessageLookupByLibrary.simpleMessage(
      "لقد أرسلنا رسالة نصية تحتوي على رمز التحقق الخاص بك إلى رقم الهاتف ",
    ),
    "doneShipping": MessageLookupByLibrary.simpleMessage("تم شحنه"),
    "done_resend_code": MessageLookupByLibrary.simpleMessage(
      "تم إعادة الإرسال",
    ),
    "download": MessageLookupByLibrary.simpleMessage("تنزيل"),
    "downloadFile": MessageLookupByLibrary.simpleMessage("تحميل الملف"),
    "draft": MessageLookupByLibrary.simpleMessage("مسودة"),
    "draftHiddenFromMembers": MessageLookupByLibrary.simpleMessage(
      "لا يراه الأعضاء بعد.",
    ),
    "dueDate": MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
    "dueOn": m17,
    "ePayment": MessageLookupByLibrary.simpleMessage("دفع إلكتروني"),
    "editProfile": MessageLookupByLibrary.simpleMessage("تعديل الصفحة الشخصية"),
    "editVote": MessageLookupByLibrary.simpleMessage("تعديل التصويت"),
    "educationalGrade": MessageLookupByLibrary.simpleMessage(
      "المرحلة الدراسية",
    ),
    "educationalProgress": MessageLookupByLibrary.simpleMessage(
      "مساري التعليمي",
    ),
    "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailEmpty": MessageLookupByLibrary.simpleMessage(
      "حقل البريد الإلكتروني مطلوب",
    ),
    "emptyCart": MessageLookupByLibrary.simpleMessage("السلة فارغة"),
    "emptyFav": MessageLookupByLibrary.simpleMessage("المفضلة فارغة"),
    "emptyNotifications": MessageLookupByLibrary.simpleMessage(
      "لا يوجد إشعارات",
    ),
    "emptyOffers": MessageLookupByLibrary.simpleMessage("لا يوجد عروض"),
    "emptyOrders": MessageLookupByLibrary.simpleMessage("لا يوجد طلبات"),
    "emptyReview": MessageLookupByLibrary.simpleMessage("لا يوجد مراجعات "),
    "emptySearch": MessageLookupByLibrary.simpleMessage("لا يوجد نتائج بحث"),
    "en": MessageLookupByLibrary.simpleMessage("إنكليزي"),
    "endCall": MessageLookupByLibrary.simpleMessage("إنهاء الاتصال"),
    "endCallConfirm": MessageLookupByLibrary.simpleMessage("إنهاء الاتصال؟"),
    "endCallConfirmDescription": MessageLookupByLibrary.simpleMessage(
      "ستغادر الاجتماع الأونلاين وتبقى في صفحة الاجتماع.",
    ),
    "enterOTP": MessageLookupByLibrary.simpleMessage(
      "أدخل رمز التفعيل الخاص بك هنا.",
    ),
    "enter_new_password_and_confirm": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة السر مع التأكيد",
    ),
    "equipmentDetailsHint": MessageLookupByLibrary.simpleMessage(
      "ملاحظات (اختياري)",
    ),
    "equipmentQuantity": m18,
    "errAgendaRequestNotPending": MessageLookupByLibrary.simpleMessage(
      "تمت الإجابة على هذا الاقتراح بالفعل.",
    ),
    "errAgendaRequestTitleRequired": MessageLookupByLibrary.simpleMessage(
      "أدخل عنوانًا للاقتراح.",
    ),
    "errAgendaRequestsClosed": MessageLookupByLibrary.simpleMessage(
      "المقترحات مغلقة: نُشر جدول الأعمال أو بدأ الاجتماع.",
    ),
    "errAlreadyVoted": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل صوت لهذا الشخص في هذا التصويت بالفعل.",
    ),
    "errCheckInClosed": MessageLookupByLibrary.simpleMessage(
      "تسجيل الحضور متاح فقط والاجتماع مجدول أو جارٍ.",
    ),
    "errCheckInCodeInvalid": MessageLookupByLibrary.simpleMessage(
      "الرمز غير صحيح أو منتهي الصلاحية. امسحه مرة أخرى.",
    ),
    "errCheckInNotInvited": MessageLookupByLibrary.simpleMessage(
      "لست مدعوًا إلى هذا الاجتماع.",
    ),
    "errCheckInTooManyTries": MessageLookupByLibrary.simpleMessage(
      "محاولات خاطئة كثيرة. حاول مرة أخرى بعد دقائق.",
    ),
    "errCirculationChoiceInvalid": MessageLookupByLibrary.simpleMessage(
      "اختر موافق أو غير موافق أو ممتنع.",
    ),
    "errCirculationDeadlinePast": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون موعد الإغلاق في المستقبل.",
    ),
    "errCirculationNoVoters": MessageLookupByLibrary.simpleMessage(
      "لا يوجد في اللجنة أعضاء للتصويت.",
    ),
    "errCirculationNotDraft": MessageLookupByLibrary.simpleMessage(
      "لا يمكن تعديل القرار أو حذفه أو طرحه إلا وهو مسودة.",
    ),
    "errCirculationNotOpen": MessageLookupByLibrary.simpleMessage(
      "التصويت على هذا القرار مغلق.",
    ),
    "errCirculationReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "يجب ألا يتجاوز السبب 500 حرف.",
    ),
    "errCirculationStatementRequired": MessageLookupByLibrary.simpleMessage(
      "أدخل نص القرار.",
    ),
    "errCirculationTitleRequired": MessageLookupByLibrary.simpleMessage(
      "أدخل العنوان.",
    ),
    "errCirculationTitleTooLong": MessageLookupByLibrary.simpleMessage(
      "يجب ألا يتجاوز العنوان 300 حرف.",
    ),
    "errCommitteeAlreadyHasAChair": MessageLookupByLibrary.simpleMessage(
      "يوجد رئيس لهذه اللجنة بالفعل.",
    ),
    "errCommitteeAlreadyHasASecretary": MessageLookupByLibrary.simpleMessage(
      "يوجد أمين سر لهذه اللجنة بالفعل.",
    ),
    "errCommitteeIsInactive": MessageLookupByLibrary.simpleMessage(
      "اللجنة غير مفعلة، لذلك لا يمكن إضافة اجتماعات جديدة لها.",
    ),
    "errComplianceRuleInvalid": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون كل حد عددًا صحيحًا من 1 (والتنبيه من 0).",
    ),
    "errDecisionLinkInvalid": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون القرار السابق قرارًا منشورًا للجنة نفسها.",
    ),
    "errDelegationInvalid": MessageLookupByLibrary.simpleMessage(
      "لا يمكن إنشاء هذا التفويض: تحقق من الصفة والعضو والتواريخ (حتى سنة وتنتهي في المستقبل) والصلاحيات، وألا يتداخل مع تفويض آخر.",
    ),
    "errHallCapacityExceeded": MessageLookupByLibrary.simpleMessage(
      "القاعة لا تتسع لجميع أعضاء اللجنة.",
    ),
    "errHallIsBooked": MessageLookupByLibrary.simpleMessage(
      "القاعة محجوزة لاجتماع آخر في هذا الوقت.",
    ),
    "errHallServiceInvalid": MessageLookupByLibrary.simpleMessage(
      "تعذّر حفظ الطلب: ليس للاجتماع قاعة أو انتهى، أو التجهيز أو الكمية غير صحيحة، أو التفاصيل مفقودة أو طويلة، أو الطلب مغلق.",
    ),
    "errInterestAlreadyDeclared": MessageLookupByLibrary.simpleMessage(
      "سبق الإفصاح عن تعارض مصالح في هذا البند.",
    ),
    "errInterestDeclared": MessageLookupByLibrary.simpleMessage(
      "أفصح هذا المصوّت عن تعارض مصالح في البند، فلا يمكنه التصويت عليه.",
    ),
    "errInterestNoteTooLong": MessageLookupByLibrary.simpleMessage(
      "الملاحظة طويلة جدًا (500 حرف كحد أقصى).",
    ),
    "errLifecycleInvalid": MessageLookupByLibrary.simpleMessage(
      "تحقق من التواريخ: لا يمكن أن تنتهي المدة قبل بدايتها، واللجنة المؤقتة تحتاج إلى تاريخ انتهاء.",
    ),
    "errLiveInvalid": MessageLookupByLibrary.simpleMessage(
      "لا يمكن تنفيذ ذلك الآن: الاجتماع غير منعقد، أو البند يتبع اجتماعاً آخر، أو المدة خارج النطاق من ثانية واحدة إلى 8 ساعات.",
    ),
    "errMeetingNotOnline": MessageLookupByLibrary.simpleMessage(
      "لا توجد غرفة افتراضية لهذا الاجتماع.",
    ),
    "errMeetingOnHoliday": MessageLookupByLibrary.simpleMessage(
      "لا يمكن عقد الاجتماع خلال عطلة رسمية.",
    ),
    "errMeetingOnWeekend": MessageLookupByLibrary.simpleMessage(
      "لا يمكن عقد الاجتماع في يوم عطلة نهاية الأسبوع.",
    ),
    "errMeetingStatusChangeNotAllowed": MessageLookupByLibrary.simpleMessage(
      "لا يمكن نقل الاجتماع من حالته الحالية إلى هذه الحالة.",
    ),
    "errMinuteAlreadyFinal": MessageLookupByLibrary.simpleMessage(
      "المحضر معتمد بالفعل.",
    ),
    "errMinuteApprovalClosed": MessageLookupByLibrary.simpleMessage(
      "انتهى موعد الرد على المحضر.",
    ),
    "errMinuteApprovalsPending": MessageLookupByLibrary.simpleMessage(
      "لا يمكن اعتماد المحضر نهائيًا قبل اكتمال مسار الاعتماد.",
    ),
    "errMinuteChairApprovesLast": MessageLookupByLibrary.simpleMessage(
      "يعتمد الرئيس المحضر بعد بقية الأعضاء.",
    ),
    "errMinuteReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "يجب ألا يتجاوز السبب 500 حرف.",
    ),
    "errMinuteRejectionReasonRequired": MessageLookupByLibrary.simpleMessage(
      "اذكر سبب رفض المحضر.",
    ),
    "errNotFound": MessageLookupByLibrary.simpleMessage("العنصر غير موجود."),
    "errNoticeGroupUnknown": MessageLookupByLibrary.simpleMessage(
      "نوع إشعار غير معروف.",
    ),
    "errNoticeLanguageNotSupported": MessageLookupByLibrary.simpleMessage(
      "اختر العربية أو الإنجليزية لإشعاراتك.",
    ),
    "errOptionIsNotInPoll": MessageLookupByLibrary.simpleMessage(
      "هذا الخيار لا ينتمي إلى هذا التصويت.",
    ),
    "errPartySuspendInvalid": MessageLookupByLibrary.simpleMessage(
      "لا يمكن إلغاء تفعيل هذا الشخص أو إعادة تفعيله الآن (قد يكون حسابك أنت، أو في هذه الحالة مسبقًا).",
    ),
    "errPeriodicTemplateInvalid": MessageLookupByLibrary.simpleMessage(
      "تعذّر حفظ القالب: من 1 إلى 12 اجتماعًا مسبقًا، و30 بندًا على الأكثر، لكل بند عنوان حتى 500 حرف ومدة حتى 600 دقيقة.",
    ),
    "errPollIsNotOpen": MessageLookupByLibrary.simpleMessage(
      "التصويت متاح فقط أثناء فتح التصويت.",
    ),
    "errQuorumRuleInvalid": MessageLookupByLibrary.simpleMessage(
      "أدخل رقمًا لا يقل عن 1 (والنسبة لا تتجاوز 100).",
    ),
    "errReasonRequired": MessageLookupByLibrary.simpleMessage("أدخل السبب."),
    "errRecommendationInvalid": MessageLookupByLibrary.simpleMessage(
      "تعذّر حفظ التوصية: ليس للجنة لجنة أم أو أنها غير نشطة، أو النص مفقود أو طويل جدًا، أو سبق الرد عليها.",
    ),
    "errReportYearInvalid": MessageLookupByLibrary.simpleMessage(
      "يجب أن تكون السنة بين 1900 و3000.",
    ),
    "errReservationReasonRequired": MessageLookupByLibrary.simpleMessage(
      "اذكر سبب التحفظ.",
    ),
    "errReservationReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "يجب ألا يتجاوز السبب 500 حرف.",
    ),
    "errSpeakerInvalid": MessageLookupByLibrary.simpleMessage(
      "لا تنطبق هذه الخطوة على قائمة المتحدثين الآن (الاجتماع غير منعقد، أو سبق أن طلبت الكلمة، أو لا أحد في الانتظار، أو الحد يتجاوز ساعة).",
    ),
    "errSubcommitteeInvalid": MessageLookupByLibrary.simpleMessage(
      "لا يمكن وضع اللجنة هنا: ستكون تحت نفسها، أو سيتجاوز الهيكل 5 مستويات.",
    ),
    "errTaskDecisionInvalid": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون القرار من اللجنة نفسها التي تتبعها المهمة.",
    ),
    "errTaskReassignInvalid": MessageLookupByLibrary.simpleMessage(
      "اختر مهام مسندة إلى هذا العضو، وعضوًا آخر في اللجنة لنقلها إليه.",
    ),
    "errUnauthorizedUser": MessageLookupByLibrary.simpleMessage(
      "غير مصرّح لك بتنفيذ هذا الإجراء.",
    ),
    "errUserSuspended": MessageLookupByLibrary.simpleMessage(
      "هذا الحساب غير مفعّل. تواصل مع مسؤول النظام.",
    ),
    "errValidationError": MessageLookupByLibrary.simpleMessage(
      "بعض البيانات غير صحيحة.",
    ),
    "errVoteReasonRequired": MessageLookupByLibrary.simpleMessage(
      "اذكر سبب الرفض أو الامتناع.",
    ),
    "errVoteReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "السبب طويل جدًا (500 حرف كحد أقصى).",
    ),
    "errVotingRuleInvalid": MessageLookupByLibrary.simpleMessage(
      "اختر أغلبية صحيحة.",
    ),
    "errYouCanNotChangePollTypeAfterVoting":
        MessageLookupByLibrary.simpleMessage(
          "لا يمكن تغيير نوع التصويت بعد الإدلاء بالأصوات.",
        ),
    "errYouDoNotHavePermission": MessageLookupByLibrary.simpleMessage(
      "ليس لديك صلاحية لتنفيذ هذا الإجراء.",
    ),
    "estimatedFor": MessageLookupByLibrary.simpleMessage("الوقت المتوقع"),
    "excusedCount": m19,
    "expiration": MessageLookupByLibrary.simpleMessage("انتهاء الصلاحية"),
    "faq": MessageLookupByLibrary.simpleMessage("الأسئلة الشائعة"),
    "fav": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "female": MessageLookupByLibrary.simpleMessage("أنثى"),
    "filters": MessageLookupByLibrary.simpleMessage("الفلاتر"),
    "firstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "flash_deal": MessageLookupByLibrary.simpleMessage("العروض السريعة"),
    "follow": MessageLookupByLibrary.simpleMessage("متابعة"),
    "forgetPassword": MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
    "forgetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "أدخل رقم الجوال المسجّل بحسابك.",
    ),
    "forgetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "استعادة كلمة المرور",
    ),
    "formationDate": MessageLookupByLibrary.simpleMessage("تاريخ التشكيل"),
    "freeLesson": MessageLookupByLibrary.simpleMessage("دروس مقترحة"),
    "freeSummary": MessageLookupByLibrary.simpleMessage(
      "الملازم والكتب المجانية",
    ),
    "fromCommittee": m20,
    "fromLabel": MessageLookupByLibrary.simpleMessage("من"),
    "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "fullscreen": MessageLookupByLibrary.simpleMessage("ملء الشاشة"),
    "gender": MessageLookupByLibrary.simpleMessage("الجنس"),
    "goals": MessageLookupByLibrary.simpleMessage("الأهداف"),
    "goalsCount": m21,
    "governor": MessageLookupByLibrary.simpleMessage("المحافظة"),
    "guest": MessageLookupByLibrary.simpleMessage("ضيف"),
    "guests": MessageLookupByLibrary.simpleMessage("الضيوف"),
    "hallServices": MessageLookupByLibrary.simpleMessage("خدمات القاعة"),
    "hallServicesHint": MessageLookupByLibrary.simpleMessage(
      "اطلب من الخدمات المساندة ضيافة أو خدمة أخرى.",
    ),
    "haveBeenCreated": MessageLookupByLibrary.simpleMessage("تم إنشاء حسابك"),
    "help": MessageLookupByLibrary.simpleMessage("المساعدة"),
    "helperPhoneText": MessageLookupByLibrary.simpleMessage(
      "يبدأ ب 07 ويحتوي 11 رَقَم",
    ),
    "hidePassword": MessageLookupByLibrary.simpleMessage("إخفاء"),
    "hideSubItems": m22,
    "hijriDate": MessageLookupByLibrary.simpleMessage("هجري"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "homeAddress": MessageLookupByLibrary.simpleMessage("عنوان المنزل"),
    "hospitalityDetailsHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: قهوة وماء الساعة 10:00",
    ),
    "hospitalityFor": m23,
    "host": MessageLookupByLibrary.simpleMessage("مضيف"),
    "hours": MessageLookupByLibrary.simpleMessage("ساعات"),
    "hubAgendaUpdated": MessageLookupByLibrary.simpleMessage(
      "تحديث على جدول الأعمال",
    ),
    "hubAgendaUpdatedBody": m24,
    "hubDecisionPublished": MessageLookupByLibrary.simpleMessage("نُشر قرار"),
    "hubDiscussionClosed": MessageLookupByLibrary.simpleMessage("أُغلق نقاش"),
    "hubDiscussionOpened": MessageLookupByLibrary.simpleMessage("فُتح نقاش"),
    "hubDiscussionUpdated": MessageLookupByLibrary.simpleMessage(
      "تحديث على نقاش",
    ),
    "hubPollClosed": MessageLookupByLibrary.simpleMessage("أُغلق تصويت"),
    "hubPollOpened": MessageLookupByLibrary.simpleMessage("فُتح تصويت"),
    "hubPollPublished": MessageLookupByLibrary.simpleMessage(
      "نُشرت نتيجة تصويت",
    ),
    "hubPollUpdated": MessageLookupByLibrary.simpleMessage("تحديث على تصويت"),
    "iAmNotCurrentlyAMemberOfAnyCommittees":
        MessageLookupByLibrary.simpleMessage("لا توجد لجان منضم لها حالياً"),
    "identityImage": MessageLookupByLibrary.simpleMessage("صورة الهوية"),
    "inHall": m25,
    "interestDeclared": MessageLookupByLibrary.simpleMessage(
      "أفصحت عن تعارض مصالح في هذا البند",
    ),
    "interestNoteHint": MessageLookupByLibrary.simpleMessage(
      "صف التعارض باختصار",
    ),
    "interestNoteOptional": MessageLookupByLibrary.simpleMessage(
      "ملاحظة (اختيارية)",
    ),
    "isSuccess": MessageLookupByLibrary.simpleMessage("نجح!"),
    "is_required": MessageLookupByLibrary.simpleMessage("مطلوب"),
    "itemsCount": m26,
    "join": MessageLookupByLibrary.simpleMessage("انضمام"),
    "joinAsHost": MessageLookupByLibrary.simpleMessage("انضم كمضيف"),
    "joinOnlineHint": MessageLookupByLibrary.simpleMessage(
      "انضم بالصوت والصورة من هنا، وتبقى صفحة الاجتماع أمامك.",
    ),
    "ku": MessageLookupByLibrary.simpleMessage("كردي"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "lastName": MessageLookupByLibrary.simpleMessage("الاسم الأخير"),
    "lesson": MessageLookupByLibrary.simpleMessage("درس"),
    "listenOnly": MessageLookupByLibrary.simpleMessage("استماع فقط"),
    "liveAskToSpeak": MessageLookupByLibrary.simpleMessage("طلب الكلمة"),
    "liveChangeItem": MessageLookupByLibrary.simpleMessage("تغيير البند"),
    "liveClearScreen": MessageLookupByLibrary.simpleMessage("إخلاء الشاشة"),
    "liveConnected": MessageLookupByLibrary.simpleMessage("مباشر"),
    "liveConnecting": MessageLookupByLibrary.simpleMessage("جارٍ الاتصال…"),
    "liveControls": MessageLookupByLibrary.simpleMessage("التحكم"),
    "liveCurrentItem": MessageLookupByLibrary.simpleMessage("البند المعروض"),
    "liveDisconnected": MessageLookupByLibrary.simpleMessage("غير متصل"),
    "liveEndSpeaker": MessageLookupByLibrary.simpleMessage("إنهاء الكلمة"),
    "liveGiveFloor": MessageLookupByLibrary.simpleMessage("منح الكلمة"),
    "liveMinusMinute": MessageLookupByLibrary.simpleMessage("إنقاص دقيقة"),
    "liveMinutes": m27,
    "liveNextSpeaker": MessageLookupByLibrary.simpleMessage("المتحدث التالي"),
    "liveNoItem": MessageLookupByLibrary.simpleMessage("لا يوجد بند معروض"),
    "liveNoLimit": MessageLookupByLibrary.simpleMessage("بلا حد"),
    "liveNobodySpeaking": MessageLookupByLibrary.simpleMessage(
      "لا أحد يتحدث الآن",
    ),
    "liveNow": MessageLookupByLibrary.simpleMessage("مباشر الآن"),
    "livePause": MessageLookupByLibrary.simpleMessage("إيقاف مؤقت"),
    "livePaused": MessageLookupByLibrary.simpleMessage("متوقف"),
    "livePickItem": MessageLookupByLibrary.simpleMessage("عرض بند على الشاشة"),
    "livePickItemTitle": MessageLookupByLibrary.simpleMessage("البند المعروض"),
    "livePlusMinute": MessageLookupByLibrary.simpleMessage("إضافة دقيقة"),
    "liveQueue": m28,
    "liveReconnecting": MessageLookupByLibrary.simpleMessage(
      "جارٍ إعادة الاتصال…",
    ),
    "liveRemoveFromQueue": MessageLookupByLibrary.simpleMessage(
      "إزالة من قائمة الانتظار",
    ),
    "liveRequestSent": MessageLookupByLibrary.simpleMessage("أُرسل طلبك"),
    "liveReset": MessageLookupByLibrary.simpleMessage("إعادة ضبط"),
    "liveResetDescription": MessageLookupByLibrary.simpleMessage(
      "سيُمسح الوقت المستغرق حتى الآن.",
    ),
    "liveResetTitle": MessageLookupByLibrary.simpleMessage(
      "إعادة ضبط مؤقّت هذا البند؟",
    ),
    "liveSkip": MessageLookupByLibrary.simpleMessage("تخطّي"),
    "liveSkipHint": MessageLookupByLibrary.simpleMessage(
      "يُتجاوز دوره ويُسجَّل الطلب كمتخطّى.",
    ),
    "liveSpeakerLimit": m29,
    "liveSpeakerLimitHint": MessageLookupByLibrary.simpleMessage(
      "يُطبّق على المتحدثين القادمين.",
    ),
    "liveSpeakerLimitTitle": MessageLookupByLibrary.simpleMessage(
      "وقت كل متحدث",
    ),
    "liveSpeaking": MessageLookupByLibrary.simpleMessage("يتحدث الآن"),
    "liveStart": MessageLookupByLibrary.simpleMessage("تشغيل"),
    "liveTapToRetry": MessageLookupByLibrary.simpleMessage(
      "التحديثات المباشرة متوقفة. اضغط لإعادة الاتصال.",
    ),
    "liveUpdates": MessageLookupByLibrary.simpleMessage("التحديثات المباشرة"),
    "liveWithdraw": MessageLookupByLibrary.simpleMessage("سحب الطلب"),
    "liveWithdrawFor": MessageLookupByLibrary.simpleMessage("سحب طلبه"),
    "liveWithdrawForHint": MessageLookupByLibrary.simpleMessage(
      "كأنه سحبه بنفسه، مثلاً عند مغادرته.",
    ),
    "liveYourPlace": m30,
    "liveYourTurn": MessageLookupByLibrary.simpleMessage("الكلمة لك الآن"),
    "location": MessageLookupByLibrary.simpleMessage("الموقع"),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "أدخل بيانات حسابك للوصول إلى لجانك واجتماعاتك.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logoutDescription": MessageLookupByLibrary.simpleMessage(
      "ستحتاج لإدخال بياناتك مرة أخرى للدخول.",
    ),
    "logoutQuestion": MessageLookupByLibrary.simpleMessage("تسجيل الخروج؟"),
    "mail": MessageLookupByLibrary.simpleMessage("ذكر"),
    "max": MessageLookupByLibrary.simpleMessage("الأقصى"),
    "meeting": MessageLookupByLibrary.simpleMessage("الاجتماع"),
    "meetingModeHybrid": MessageLookupByLibrary.simpleMessage(
      "هجين (حضوري وعن بُعد)",
    ),
    "meetingModeInPerson": MessageLookupByLibrary.simpleMessage("حضوري"),
    "meetingModeOnline": MessageLookupByLibrary.simpleMessage("عن بُعد"),
    "meetingRunningNow": MessageLookupByLibrary.simpleMessage(
      "الاجتماع جارٍ الآن",
    ),
    "meetings": MessageLookupByLibrary.simpleMessage("الاجتماعات"),
    "meetingsBehind": MessageLookupByLibrary.simpleMessage("متأخر"),
    "meetingsCount": m31,
    "meetingsHeld": MessageLookupByLibrary.simpleMessage("منعقدة"),
    "meetingsMinimum": MessageLookupByLibrary.simpleMessage(
      "الحد الأدنى السنوي",
    ),
    "meetingsMissing": m32,
    "meetingsOnTrack": MessageLookupByLibrary.simpleMessage("على المسار"),
    "meetingsScheduledLabel": MessageLookupByLibrary.simpleMessage("مجدولة"),
    "meetingsShort": MessageLookupByLibrary.simpleMessage("دون الحد"),
    "meetingsThisYear": MessageLookupByLibrary.simpleMessage(
      "اجتماعات هذا العام",
    ),
    "member": MessageLookupByLibrary.simpleMessage("عضو"),
    "members": MessageLookupByLibrary.simpleMessage("الأعضاء"),
    "membersAtRisk": MessageLookupByLibrary.simpleMessage(
      "أعضاء معرّضون للتجاوز",
    ),
    "membersCount": m33,
    "middleName": MessageLookupByLibrary.simpleMessage("الاسم الأوسط"),
    "min": MessageLookupByLibrary.simpleMessage("دقيقة"),
    "minutes": MessageLookupByLibrary.simpleMessage("دقائق"),
    "minutesAnswerBy": m34,
    "minutesAnswersClosed": MessageLookupByLibrary.simpleMessage(
      "انتهى موعد الرد على المحضر.",
    ),
    "minutesApprovals": MessageLookupByLibrary.simpleMessage("ردود الأعضاء"),
    "minutesApprovedDone": MessageLookupByLibrary.simpleMessage(
      "تم اعتماد المحضر",
    ),
    "minutesApprovedOf": m35,
    "minutesChairLast": MessageLookupByLibrary.simpleMessage(
      "يعتمد الرئيس المحضر بعد بقية الأعضاء.",
    ),
    "minutesChairWaits": MessageLookupByLibrary.simpleMessage(
      "يمكنك الاعتماد بعد أن يرد بقية الأعضاء، ويمكنك الرفض في أي وقت.",
    ),
    "minutesConfirmed": MessageLookupByLibrary.simpleMessage("معتمد"),
    "minutesRejectedCount": m36,
    "minutesRejectedDone": MessageLookupByLibrary.simpleMessage(
      "تم إرسال الرفض",
    ),
    "minutesUnderReview": MessageLookupByLibrary.simpleMessage("قيد المراجعة"),
    "muteMic": MessageLookupByLibrary.simpleMessage("كتم الميكروفون"),
    "myAttendance": MessageLookupByLibrary.simpleMessage("حضوري"),
    "myComment": MessageLookupByLibrary.simpleMessage("تعليقي"),
    "myInfo": MessageLookupByLibrary.simpleMessage("معلوماتي"),
    "myLocation": MessageLookupByLibrary.simpleMessage("موقعي الحالي"),
    "myOrder": MessageLookupByLibrary.simpleMessage("طلباتي"),
    "myOrders": MessageLookupByLibrary.simpleMessage("طلباتي"),
    "myProposals": m37,
    "myTasks": MessageLookupByLibrary.simpleMessage("مهامي"),
    "name": MessageLookupByLibrary.simpleMessage("الاسم"),
    "nameEmpty": MessageLookupByLibrary.simpleMessage("حقل الاسم مطلوب"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("التقويم"),
    "navCommittees": MessageLookupByLibrary.simpleMessage("لجاني"),
    "navSettings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "need11": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون رقم الهاتف مكونًا من 11 رقمًا",
    ),
    "need8": MessageLookupByLibrary.simpleMessage(
      "يجب أن تحتوي كلمة المرور على 8 أحرف وأرقام على الأقل",
    ),
    "needLogin": MessageLookupByLibrary.simpleMessage(
      "للمتابعة يرجى تسجيل الدخول",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("كلمة المرور الجديدة"),
    "newPasswordTitle": MessageLookupByLibrary.simpleMessage("كلمة مرور جديدة"),
    "new_arrival": MessageLookupByLibrary.simpleMessage("وصول جديد"),
    "new_check_email": MessageLookupByLibrary.simpleMessage(
      "تحقق من بريدك الإلكتروني للحصول على رابط التأكيد",
    ),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "noAgendaYet": MessageLookupByLibrary.simpleMessage(
      "لم يُضف جدول الأعمال بعد",
    ),
    "noAgendaYetDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر البنود هنا فور إضافتها، ويمكنك التعليق على كل بند.",
    ),
    "noCirculations": MessageLookupByLibrary.simpleMessage(
      "لا توجد قرارات بالتمرير",
    ),
    "noCirculationsDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا القرارات التي يطرحها أمين السر للتصويت.",
    ),
    "noCommitteeDescription": MessageLookupByLibrary.simpleMessage(
      "لا يوجد وصف مسجّل لهذه اللجنة.",
    ),
    "noCommitteeStatement": MessageLookupByLibrary.simpleMessage(
      "لا يوجد بيان مسجّل لهذه اللجنة.",
    ),
    "noCommitteesDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا اللجان فور إضافتك إليها. اسحب الشاشة للأسفل للتحديث.",
    ),
    "noComplianceRule": MessageLookupByLibrary.simpleMessage(
      "لا توجد قاعدة حضور لهذه اللجنة.",
    ),
    "noDeadline": MessageLookupByLibrary.simpleMessage("بلا موعد نهائي"),
    "noDelegationCandidates": MessageLookupByLibrary.simpleMessage(
      "لا يوجد أعضاء آخرون في هذه اللجنة.",
    ),
    "noDelegations": MessageLookupByLibrary.simpleMessage("لا توجد تفويضات"),
    "noDelegationsDescription": MessageLookupByLibrary.simpleMessage(
      "فوّض صفتك لعضو آخر لفترة محددة، مثلاً قبل السفر.",
    ),
    "noDocumentsYet": MessageLookupByLibrary.simpleMessage("لا توجد وثائق بعد"),
    "noDocumentsYetDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا وثائق اللجنة عند إضافتها.",
    ),
    "noGoalsYet": MessageLookupByLibrary.simpleMessage("لم تُحدَّد أهداف بعد"),
    "noGoalsYetDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا أهداف اللجنة ومهامها عند إضافتها.",
    ),
    "noInternet": MessageLookupByLibrary.simpleMessage(
      "يرجى التحقق من اتصالك بالإنترنت",
    ),
    "noMeetingsThisDay": MessageLookupByLibrary.simpleMessage(
      "لا اجتماعات في هذا اليوم",
    ),
    "noMeetingsThisDayHint": MessageLookupByLibrary.simpleMessage(
      "الأيام التي فيها اجتماعات معلّمة بنقطة بنفسجية.",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage("لا توجد إشعارات"),
    "noNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا الإشعارات فور وصولها. اسحب للأسفل للتحديث.",
    ),
    "noRecommendations": MessageLookupByLibrary.simpleMessage("لا توجد توصيات"),
    "noRecommendationsDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا التوصيات المرفوعة من هذه اللجنة أو إليها.",
    ),
    "noSubCommittees": MessageLookupByLibrary.simpleMessage(
      "ليس لهذه اللجنة لجنة أم ولا لجان فرعية.",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("لا توجد مهام"),
    "noVoters": MessageLookupByLibrary.simpleMessage("لم يختره أحد"),
    "noVotesForMeeting": MessageLookupByLibrary.simpleMessage(
      "لا توجد تصويتات لهذا الاجتماع",
    ),
    "noVotesForMeetingDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا الاستطلاعات عند فتحها، ونتائجها بعد نشرها.",
    ),
    "noVotesPending": MessageLookupByLibrary.simpleMessage(
      "لا تصويتات بانتظارك",
    ),
    "noWorkload": MessageLookupByLibrary.simpleMessage("لا توجد مهام بعد"),
    "noWorkloadDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا المهام المنشورة والمسندة في هذه اللجنة.",
    ),
    "notACirculationVoter": MessageLookupByLibrary.simpleMessage(
      "لست من المصوّتين على هذا القرار.",
    ),
    "notAnsweredYet": MessageLookupByLibrary.simpleMessage("لم يرد بعد"),
    "notConnected": MessageLookupByLibrary.simpleMessage("غير متصل"),
    "notLoggedIn": MessageLookupByLibrary.simpleMessage(
      "المستخدم الحالي لم يسجل الدخول",
    ),
    "notVotedYet": MessageLookupByLibrary.simpleMessage("لم يصوّت"),
    "notVotedYetCount": m38,
    "notYet": MessageLookupByLibrary.simpleMessage("ليس بعد"),
    "noteCannotHear": MessageLookupByLibrary.simpleMessage("لا أسمع"),
    "noteCannotSee": MessageLookupByLibrary.simpleMessage("لا أرى الشاشة"),
    "noteNeedHelp": MessageLookupByLibrary.simpleMessage("أحتاج مساعدة"),
    "notification": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "notifications": MessageLookupByLibrary.simpleMessage("إشعارات"),
    "numberOfPeople": MessageLookupByLibrary.simpleMessage("عدد الأشخاص"),
    "numberPhone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "offer": MessageLookupByLibrary.simpleMessage("عرض"),
    "ok": MessageLookupByLibrary.simpleMessage("حسناً"),
    "onlineMeeting": MessageLookupByLibrary.simpleMessage("الاجتماع الأونلاين"),
    "oops": MessageLookupByLibrary.simpleMessage("حدث خطأ ما!"),
    "openMinutes": MessageLookupByLibrary.simpleMessage("فتح المحضر"),
    "or": MessageLookupByLibrary.simpleMessage("أو"),
    "order_summary": MessageLookupByLibrary.simpleMessage("ملخص الطلب"),
    "other": MessageLookupByLibrary.simpleMessage("آخر"),
    "otpSentTo": MessageLookupByLibrary.simpleMessage(
      "أرسلنا الرمز برسالة نصية إلى",
    ),
    "parentCommittee": MessageLookupByLibrary.simpleMessage("اللجنة الأم"),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "passwordEmpty": MessageLookupByLibrary.simpleMessage(
      "حقل كلمة المرور مطلوب",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور غير متطابقة",
    ),
    "passwordReset": MessageLookupByLibrary.simpleMessage(
      "تم إعادة تعيين كلمة المرور الخاصة بك!",
    ),
    "paymentFailed": MessageLookupByLibrary.simpleMessage("فشل الدفع"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("طريقة الدفع"),
    "payment_summary": MessageLookupByLibrary.simpleMessage("ملخص الدفع"),
    "pending": MessageLookupByLibrary.simpleMessage("معلقة"),
    "pendingCount": m39,
    "phoneCall": MessageLookupByLibrary.simpleMessage("اتصال هاتفي"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "phoneNumberCanNotBeChange": MessageLookupByLibrary.simpleMessage(
      "لا يمكن تغيير رقم الهاتف",
    ),
    "phoneNumberEmpty": MessageLookupByLibrary.simpleMessage(
      "حقل رقم الهاتف مطلوب",
    ),
    "phoneSms": MessageLookupByLibrary.simpleMessage("رسالة نصية على الهاتف"),
    "planned": MessageLookupByLibrary.simpleMessage("جاهزة"),
    "pleasCreateAccount": MessageLookupByLibrary.simpleMessage(
      "يرجى إنشاء حساب",
    ),
    "pleasSetYourAddress": MessageLookupByLibrary.simpleMessage(
      "الرجاء تعيين عنوانك",
    ),
    "pointOfOrder": MessageLookupByLibrary.simpleMessage("نقطة نظام"),
    "policy": MessageLookupByLibrary.simpleMessage("سياسة الاستخدام والخصوصية"),
    "policyJust": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
    "pollNotOpenYet": MessageLookupByLibrary.simpleMessage("لم يُفتح بعد"),
    "pollOutcomePassed": MessageLookupByLibrary.simpleMessage("ناجح"),
    "pollOutcomeRejected": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "pollOutcomeTied": MessageLookupByLibrary.simpleMessage("متعادل"),
    "polls": MessageLookupByLibrary.simpleMessage("الاستطلاعات"),
    "postponed": MessageLookupByLibrary.simpleMessage("مؤجلة"),
    "poweredByCoretech": MessageLookupByLibrary.simpleMessage(
      "صمم بواسطة CORETECH",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "price": MessageLookupByLibrary.simpleMessage("السعر"),
    "processing": MessageLookupByLibrary.simpleMessage("معالجة"),
    "product": MessageLookupByLibrary.simpleMessage("منتج"),
    "profile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "profileImage": MessageLookupByLibrary.simpleMessage("صورة شخصية"),
    "proposalAccepted": MessageLookupByLibrary.simpleMessage(
      "تم قبول الاقتراح",
    ),
    "proposalNoteHint": MessageLookupByLibrary.simpleMessage(
      "الخلفية وسبب الأهمية…",
    ),
    "proposalNoteOptional": MessageLookupByLibrary.simpleMessage(
      "تفاصيل (اختيارية)",
    ),
    "proposalRejected": MessageLookupByLibrary.simpleMessage("تم رفض الاقتراح"),
    "proposalSent": MessageLookupByLibrary.simpleMessage("أُرسل اقتراحك"),
    "proposalTitle": MessageLookupByLibrary.simpleMessage("عنوان البند"),
    "proposalTitleHint": MessageLookupByLibrary.simpleMessage(
      "ما الذي تريد مناقشته؟",
    ),
    "proposeItem": MessageLookupByLibrary.simpleMessage("اقتراح بند"),
    "proposeItemHint": MessageLookupByLibrary.simpleMessage(
      "يراجعه أمين السر وقد يضيفه إلى جدول الأعمال.",
    ),
    "published": MessageLookupByLibrary.simpleMessage("منشورة"),
    "publishedResults": MessageLookupByLibrary.simpleMessage(
      "النتائج المنشورة",
    ),
    "quantity": MessageLookupByLibrary.simpleMessage("الكمية"),
    "quickMessage": MessageLookupByLibrary.simpleMessage("رسالة سريعة للمدير"),
    "quorumChairRequired": MessageLookupByLibrary.simpleMessage(
      "حضور الرئيس شرط لاكتمال النصاب.",
    ),
    "quorumChairRequiredYou": MessageLookupByLibrary.simpleMessage(
      "حضورك مطلوب لاكتمال النصاب.",
    ),
    "quorumMet": m40,
    "quorumNotMet": m41,
    "quorumPresentOfRequired": m42,
    "quorumProxies": m43,
    "quorumRecordedAt": m44,
    "quorumRuleCount": m45,
    "quorumRulePercent": m46,
    "quorumSplit": m47,
    "quorumStatusMet": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "quorumStatusNotMet": MessageLookupByLibrary.simpleMessage("غير مكتمل"),
    "quorumTitle": MessageLookupByLibrary.simpleMessage("النصاب"),
    "raise": MessageLookupByLibrary.simpleMessage("رفع"),
    "raiseRecommendation": MessageLookupByLibrary.simpleMessage("رفع توصية"),
    "raisedBy": m48,
    "rated": MessageLookupByLibrary.simpleMessage("تم التقييم"),
    "rePassword": MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
    "readOnly": MessageLookupByLibrary.simpleMessage("للقراءة فقط"),
    "ready": MessageLookupByLibrary.simpleMessage("جاهز"),
    "readyToDeliver": MessageLookupByLibrary.simpleMessage("جاهز للتسليم"),
    "reasonOptional": MessageLookupByLibrary.simpleMessage("السبب (اختياري)"),
    "receiverPhone": MessageLookupByLibrary.simpleMessage("هاتف المستلم"),
    "recommendationApproved": MessageLookupByLibrary.simpleMessage("معتمدة"),
    "recommendationBodyHint": MessageLookupByLibrary.simpleMessage(
      "التفاصيل (اختياري)",
    ),
    "recommendationPending": MessageLookupByLibrary.simpleMessage(
      "بانتظار الرد",
    ),
    "recommendationRaised": MessageLookupByLibrary.simpleMessage(
      "تم رفع التوصية",
    ),
    "recommendationRejected": MessageLookupByLibrary.simpleMessage("مرفوضة"),
    "recommendationTitleHint": MessageLookupByLibrary.simpleMessage("العنوان"),
    "recommendationWithdrawn": MessageLookupByLibrary.simpleMessage("مسحوبة"),
    "recommendations": MessageLookupByLibrary.simpleMessage("التوصيات"),
    "recommendationsReceived": MessageLookupByLibrary.simpleMessage(
      "واردة من اللجان الفرعية",
    ),
    "recommendationsSent": MessageLookupByLibrary.simpleMessage(
      "مرفوعة من هذه اللجنة",
    ),
    "recommendationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "اللجان الفرعية",
    ),
    "region": MessageLookupByLibrary.simpleMessage("المنطقة"),
    "registeredBefore": MessageLookupByLibrary.simpleMessage("مسجل سابقًا"),
    "registered_before": MessageLookupByLibrary.simpleMessage("مسجل سابقًا"),
    "reject": MessageLookupByLibrary.simpleMessage("رفض"),
    "rejectAbsenceTitle": MessageLookupByLibrary.simpleMessage(
      "رفض طلب الاعتذار؟",
    ),
    "rejectMinutesHint": MessageLookupByLibrary.simpleMessage(
      "ما الذي يجب تصحيحه؟",
    ),
    "rejectMinutesTitle": MessageLookupByLibrary.simpleMessage("رفض المحضر؟"),
    "rejectProposalHint": MessageLookupByLibrary.simpleMessage(
      "اكتب للعضو سبب الرفض",
    ),
    "rejectProposalTitle": MessageLookupByLibrary.simpleMessage(
      "رفض هذا الاقتراح؟",
    ),
    "rejectRecommendationTitle": MessageLookupByLibrary.simpleMessage(
      "رفض هذه التوصية؟",
    ),
    "rejected": MessageLookupByLibrary.simpleMessage("مرفوضة"),
    "rejectedState": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "rejectionReason": MessageLookupByLibrary.simpleMessage("السبب"),
    "related_products": MessageLookupByLibrary.simpleMessage("منتجات ذات صلة"),
    "rememberMe": MessageLookupByLibrary.simpleMessage("تذكرني"),
    "rememberPassword": MessageLookupByLibrary.simpleMessage(
      "أتذكر كلمة المرور",
    ),
    "removeAttachment": MessageLookupByLibrary.simpleMessage("إزالة الملف"),
    "requestAbsence": MessageLookupByLibrary.simpleMessage("طلبات الغياب"),
    "requestAbsenceAction": MessageLookupByLibrary.simpleMessage("طلب اعتذار"),
    "requestAbsenceHint": MessageLookupByLibrary.simpleMessage(
      "ما سبب عدم تمكنك من الحضور؟",
    ),
    "requestAbsenceTitle": MessageLookupByLibrary.simpleMessage("طلب اعتذار"),
    "requestSent": MessageLookupByLibrary.simpleMessage("أُرسل الطلب للمدير"),
    "requestService": MessageLookupByLibrary.simpleMessage("طلب خدمة"),
    "requestServiceHint": MessageLookupByLibrary.simpleMessage(
      "سيصلك تأكيد الخدمات المساندة أو ردّها هنا.",
    ),
    "requestToSpeak": MessageLookupByLibrary.simpleMessage("طلب الكلام"),
    "resend": MessageLookupByLibrary.simpleMessage("إعادة الإرسال"),
    "resendCode": MessageLookupByLibrary.simpleMessage("إعادة إرسال الرمز"),
    "reservationSent": MessageLookupByLibrary.simpleMessage("تم تسجيل تحفّظك"),
    "reservationWithdrawn": MessageLookupByLibrary.simpleMessage(
      "تم سحب تحفّظك",
    ),
    "reservationsCount": m49,
    "reserveHint": MessageLookupByLibrary.simpleMessage("ما سبب تحفّظك؟"),
    "reserveOnDecision": MessageLookupByLibrary.simpleMessage("تحفّظ"),
    "reserveTitle": MessageLookupByLibrary.simpleMessage(
      "التحفّظ على هذا القرار؟",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "respondedBy": m50,
    "responseNoteHint": MessageLookupByLibrary.simpleMessage(
      "ملاحظة للجنة الفرعية (اختياري)",
    ),
    "responseSent": MessageLookupByLibrary.simpleMessage("تم إرسال الرد"),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "returned": MessageLookupByLibrary.simpleMessage("استعادة"),
    "reviewOrder": MessageLookupByLibrary.simpleMessage("عرض الطلب"),
    "reviewProposals": MessageLookupByLibrary.simpleMessage("اقتراحات الأعضاء"),
    "reviewProposalsHint": MessageLookupByLibrary.simpleMessage(
      "ارفض مع ذكر السبب، أو اقبل بعد إضافة البند إلى جدول الأعمال.",
    ),
    "reviews": MessageLookupByLibrary.simpleMessage("التقييمات"),
    "revokeDelegation": MessageLookupByLibrary.simpleMessage("سحب"),
    "revokeDelegationFromMe": m51,
    "revokeDelegationTitle": MessageLookupByLibrary.simpleMessage(
      "سحب هذا التفويض؟",
    ),
    "revokeDelegationToMe": MessageLookupByLibrary.simpleMessage(
      "ستتوقف عن التصرّف بهذه الصفة فوراً.",
    ),
    "running": MessageLookupByLibrary.simpleMessage("جارية"),
    "saveChange": MessageLookupByLibrary.simpleMessage("حفظ التغيير"),
    "save_for_later": MessageLookupByLibrary.simpleMessage("حفظ لاحقًا؟"),
    "scheduled": MessageLookupByLibrary.simpleMessage("مجدولة"),
    "scopeDecisions": MessageLookupByLibrary.simpleMessage("القرارات"),
    "scopeMeetings": MessageLookupByLibrary.simpleMessage("الاجتماعات"),
    "scopeMembers": MessageLookupByLibrary.simpleMessage("الأعضاء"),
    "scopeMinutes": MessageLookupByLibrary.simpleMessage("المحاضر"),
    "scopeReports": MessageLookupByLibrary.simpleMessage("التقارير"),
    "scopeRules": MessageLookupByLibrary.simpleMessage("القواعد"),
    "scopeTasks": MessageLookupByLibrary.simpleMessage("المهام"),
    "screenShareNotSupported": MessageLookupByLibrary.simpleMessage(
      "مشاركة الشاشة غير مدعومة على متصفح الجوال",
    ),
    "screenSharingText": MessageLookupByLibrary.simpleMessage(
      "يشارك MMS الشاشة الآن.",
    ),
    "screenSharingTitle": MessageLookupByLibrary.simpleMessage("مشاركة الشاشة"),
    "searchResult": MessageLookupByLibrary.simpleMessage("نتائج البحث"),
    "search_In_All": MessageLookupByLibrary.simpleMessage("البحث في الكل"),
    "seconds": MessageLookupByLibrary.simpleMessage("ثواني"),
    "secretary": MessageLookupByLibrary.simpleMessage("أمين السر"),
    "see_all": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "selectAll": MessageLookupByLibrary.simpleMessage("تحديد الكل"),
    "selectFromMap": MessageLookupByLibrary.simpleMessage("من الخريطة"),
    "selectGovernor": MessageLookupByLibrary.simpleMessage("اختر المحافظة"),
    "sendProposal": MessageLookupByLibrary.simpleMessage("إرسال الاقتراح"),
    "sendRequest": MessageLookupByLibrary.simpleMessage("إرسال الطلب"),
    "sendSuggestion": MessageLookupByLibrary.simpleMessage("إرسال الاقتراح"),
    "serverError": MessageLookupByLibrary.simpleMessage("خطأ في الخادم"),
    "serviceCancelled": MessageLookupByLibrary.simpleMessage("ملغى"),
    "serviceConfirmed": MessageLookupByLibrary.simpleMessage("مؤكَّد"),
    "serviceDelivered": MessageLookupByLibrary.simpleMessage("تم التنفيذ"),
    "serviceDetailsHint": MessageLookupByLibrary.simpleMessage(
      "ما الذي تحتاجه؟",
    ),
    "serviceEquipment": MessageLookupByLibrary.simpleMessage("تجهيزات"),
    "serviceHospitality": MessageLookupByLibrary.simpleMessage("ضيافة"),
    "serviceOther": MessageLookupByLibrary.simpleMessage("أخرى"),
    "serviceRejected": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "serviceRequested": MessageLookupByLibrary.simpleMessage("تم إرسال الطلب"),
    "serviceRequestedState": MessageLookupByLibrary.simpleMessage("مطلوب"),
    "setReview": MessageLookupByLibrary.simpleMessage(
      "يرجى إضافة تقييم لهذا المنتج",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "sgnIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول."),
    "share": MessageLookupByLibrary.simpleMessage("مشاركة"),
    "shareScreen": MessageLookupByLibrary.simpleMessage("مشاركة الشاشة"),
    "shipping": MessageLookupByLibrary.simpleMessage("مشحون"),
    "showLess": MessageLookupByLibrary.simpleMessage("عرض أقل"),
    "showMore": MessageLookupByLibrary.simpleMessage("عرض المزيد"),
    "showPassword": MessageLookupByLibrary.simpleMessage("إظهار"),
    "showSubItems": m52,
    "signInToContinue": MessageLookupByLibrary.simpleMessage(
      "يجب عليك إضافة بياناتك الخاصة لتسهيل التواصل معك",
    ),
    "signInWithSocial": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول باستخدام الشبكات الاجتماعية:",
    ),
    "signInWithSocialNetworks": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول ببرامج التواصل ",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("الاشتراك"),
    "sizes": MessageLookupByLibrary.simpleMessage("الأحجام"),
    "startDate": MessageLookupByLibrary.simpleMessage("تاريخ البدء"),
    "startedAt": MessageLookupByLibrary.simpleMessage("بدأ الساعة"),
    "statement": MessageLookupByLibrary.simpleMessage("بيان"),
    "statusClosed": MessageLookupByLibrary.simpleMessage("مغلق"),
    "statusOpen": MessageLookupByLibrary.simpleMessage("مفتوح"),
    "statusPending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "stopShare": MessageLookupByLibrary.simpleMessage("إيقاف المشاركة"),
    "subCategories": MessageLookupByLibrary.simpleMessage("تصنيفات فرعية"),
    "subCommitteesCount": m53,
    "subTitleDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "سوف يتم حذف الحساب بجميع البيانات والكورسات",
    ),
    "subTitleNotification": MessageLookupByLibrary.simpleMessage(
      "جميع إعدادات الإخطارات",
    ),
    "subTitlePassword": MessageLookupByLibrary.simpleMessage(
      "قفل الجهاز، أقفال التطبيقات",
    ),
    "subTitlePolicy": MessageLookupByLibrary.simpleMessage(
      "إعدادات القفل، مستشعر الحركة",
    ),
    "subTitleSupport": MessageLookupByLibrary.simpleMessage(
      "خدمه العملاء رسال واتصل",
    ),
    "submitVote": MessageLookupByLibrary.simpleMessage("إرسال الصوت"),
    "subtotal": MessageLookupByLibrary.simpleMessage("المجموع الفرعي"),
    "successfully": MessageLookupByLibrary.simpleMessage("بنجاح."),
    "suggested": MessageLookupByLibrary.simpleMessage("مقترح"),
    "suggestedFor": MessageLookupByLibrary.simpleMessage("ضيف مقترح لحضور"),
    "suggestedGuest": MessageLookupByLibrary.simpleMessage("ضيف مقترح"),
    "suggestedGuests": MessageLookupByLibrary.simpleMessage("ضيوف مقترحون"),
    "suggestingGuest": MessageLookupByLibrary.simpleMessage("ضيف مقترح"),
    "summaries": MessageLookupByLibrary.simpleMessage("الملازم"),
    "support": MessageLookupByLibrary.simpleMessage("الدعم"),
    "suspended": MessageLookupByLibrary.simpleMessage("معلّق"),
    "tallySoFar": MessageLookupByLibrary.simpleMessage("الحصيلة حتى الآن"),
    "taskCancelled": MessageLookupByLibrary.simpleMessage("ملغاة"),
    "taskCompleted": MessageLookupByLibrary.simpleMessage("منجزة"),
    "taskInProgress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
    "taskOnHold": MessageLookupByLibrary.simpleMessage("معلّقة"),
    "tasks": MessageLookupByLibrary.simpleMessage("المهام"),
    "tasksCount": m54,
    "tasksOf": m55,
    "teachingStaff": MessageLookupByLibrary.simpleMessage("الكادر التدريسي"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "الشروط والأحكام",
    ),
    "toCommittee": m56,
    "toLabel": MessageLookupByLibrary.simpleMessage("إلى"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "trackingOrder": MessageLookupByLibrary.simpleMessage("تتبع الطلب"),
    "unFollow": MessageLookupByLibrary.simpleMessage("إلغاء متابعة"),
    "unmuteMic": MessageLookupByLibrary.simpleMessage("تشغيل الميكروفون"),
    "unpublished": MessageLookupByLibrary.simpleMessage("غير منشور"),
    "update": MessageLookupByLibrary.simpleMessage("تعديل"),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "استخدم الموقع الحالي",
    ),
    "userName": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "verify": MessageLookupByLibrary.simpleMessage("التحقق"),
    "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
    "viewProfile": MessageLookupByLibrary.simpleMessage("عرض الملف الشخصي"),
    "vote": MessageLookupByLibrary.simpleMessage("تصويت"),
    "voteReason": MessageLookupByLibrary.simpleMessage("السبب"),
    "voteReasonHint": MessageLookupByLibrary.simpleMessage(
      "ما سبب الرفض أو الامتناع؟",
    ),
    "voteRecorded": MessageLookupByLibrary.simpleMessage("تم تسجيل صوتك"),
    "voteUnit": MessageLookupByLibrary.simpleMessage("صوتاً"),
    "voters": MessageLookupByLibrary.simpleMessage("الناخبون"),
    "votes": MessageLookupByLibrary.simpleMessage("الأصوات"),
    "votesCount": m57,
    "votesPending": m58,
    "votesTitle": MessageLookupByLibrary.simpleMessage("التصويتات"),
    "votingEnded": MessageLookupByLibrary.simpleMessage("انتهى التصويت"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("أهلا بعودتك!"),
    "whoVoted": MessageLookupByLibrary.simpleMessage("من صوّت"),
    "wishList": MessageLookupByLibrary.simpleMessage("قائمة أماني"),
    "wishlist": MessageLookupByLibrary.simpleMessage("قائمة الرغبات"),
    "withdraw": MessageLookupByLibrary.simpleMessage("سحب"),
    "withdrawInterest": MessageLookupByLibrary.simpleMessage("سحب الإفصاح"),
    "withdrawInterestDescription": MessageLookupByLibrary.simpleMessage(
      "ستُحتسب مجدداً في نصاب هذا البند والتصويت عليه.",
    ),
    "withdrawInterestTitle": MessageLookupByLibrary.simpleMessage(
      "سحب الإفصاح؟",
    ),
    "withdrawProposal": MessageLookupByLibrary.simpleMessage("سحب"),
    "withdrawProposalTitle": MessageLookupByLibrary.simpleMessage(
      "سحب هذا الاقتراح؟",
    ),
    "withdrawRecommendationTitle": MessageLookupByLibrary.simpleMessage(
      "سحب هذه التوصية؟",
    ),
    "withdrawReservation": MessageLookupByLibrary.simpleMessage("سحب التحفّظ"),
    "withdrawReservationTitle": MessageLookupByLibrary.simpleMessage(
      "سحب تحفّظك؟",
    ),
    "withdrawSuggestionConfirm": MessageLookupByLibrary.simpleMessage(
      "سحب اقتراح هذا الضيف؟",
    ),
    "workload": MessageLookupByLibrary.simpleMessage("الأعباء"),
    "workloadDoneCount": m59,
    "workloadDueSoonCount": m60,
    "workloadOpen": MessageLookupByLibrary.simpleMessage("مفتوحة"),
    "workloadOpenCount": m61,
    "workloadOverdue": MessageLookupByLibrary.simpleMessage("متأخرة"),
    "workloadOverdueCount": m62,
    "workloadSubtitle": MessageLookupByLibrary.simpleMessage("المهام لكل عضو"),
    "workloadUnassigned": MessageLookupByLibrary.simpleMessage("غير مسندة"),
    "workloadUnavailable": MessageLookupByLibrary.simpleMessage(
      "الأعباء غير متاحة",
    ),
    "writeYourComment": MessageLookupByLibrary.simpleMessage(
      "اكتب تعليقك هنا…",
    ),
    "wrongEmail": MessageLookupByLibrary.simpleMessage(
      "خطأ في البريد الإلكتروني",
    ),
    "wrongPhone": MessageLookupByLibrary.simpleMessage("رقم هاتف غير صحيح"),
    "yesterday": MessageLookupByLibrary.simpleMessage("أمس"),
    "you": MessageLookupByLibrary.simpleMessage("أنت"),
    "youApproved": MessageLookupByLibrary.simpleMessage("اعتمدته"),
    "youRejected": MessageLookupByLibrary.simpleMessage("رفضته"),
    "youVotedCanChange": m63,
    "yourAbsenceRequest": MessageLookupByLibrary.simpleMessage("طلب اعتذارك"),
    "yourAddress": MessageLookupByLibrary.simpleMessage("عنوانك"),
    "yourAnswer": MessageLookupByLibrary.simpleMessage("ردّك"),
    "yourComment": MessageLookupByLibrary.simpleMessage("تعليقك"),
    "yourConnectionHasBeenSuspendedByTheAdminButYou":
        MessageLookupByLibrary.simpleMessage(
          "تم تعليق اتصالك من قبل المسؤول، لكنك لا تزال متصلاً. يرجى الانتظار حتى يُسمح لك بالاستئناف.",
        ),
    "yourEmail": MessageLookupByLibrary.simpleMessage("بريدك الإلكتروني"),
    "yourLocation": MessageLookupByLibrary.simpleMessage("موقعك"),
    "yourMembership": MessageLookupByLibrary.simpleMessage("عضويتك"),
    "yourName": MessageLookupByLibrary.simpleMessage("اسمك"),
    "yourOrder": MessageLookupByLibrary.simpleMessage("طلبك"),
    "yourPhone": MessageLookupByLibrary.simpleMessage("رقم هاتفك"),
    "yourReservation": MessageLookupByLibrary.simpleMessage("تحفّظك"),
    "yourVote": MessageLookupByLibrary.simpleMessage("صوتك"),
    "yourVoteIs": m64,
  };
}
