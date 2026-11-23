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

  static String m0(count) =>
      "${Intl.plural(count, zero: 'لا لجان', one: 'لجنة واحدة', two: 'لجنتان', few: '${count} لجان', many: '${count} لجنة', other: '${count} لجنة')}";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'لا نقاشات', one: 'نقاش واحد', two: 'نقاشان', few: '${count} نقاشات', many: '${count} نقاشاً', other: '${count} نقاش')}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'لا وثائق', one: 'وثيقة واحدة', two: 'وثيقتان', few: '${count} وثائق', many: '${count} وثيقة', other: '${count} وثيقة')}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'لا أهداف', one: 'هدف واحد', two: 'هدفان', few: '${count} أهداف', many: '${count} هدفاً', other: '${count} هدف')}";

  static String m4(count) => "إخفاء البنود الفرعية (${count})";

  static String m5(title, status) => "«${title}»: ${status}";

  static String m6(count) =>
      "${Intl.plural(count, zero: 'لا بنود', one: 'بند واحد', two: 'بندان', few: '${count} بنود', many: '${count} بنداً', other: '${count} بند')}";

  static String m7(count) => "قائمة الانتظار (${count})";

  static String m8(place) => "ترتيبك ${place} في قائمة الانتظار";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'لا اجتماعات', one: 'اجتماع واحد', two: 'اجتماعان', few: '${count} اجتماعات', many: '${count} اجتماعاً', other: '${count} اجتماع')}";

  static String m10(count) =>
      "${Intl.plural(count, zero: 'لا أعضاء', one: 'عضو واحد', two: 'عضوان', few: '${count} أعضاء', many: '${count} عضواً', other: '${count} عضو')}";

  static String m11(count) => "اقتراحاتي (${count})";

  static String m12(present, required) =>
      "النصاب مكتمل: ${present} من ${required}";

  static String m13(present, required) =>
      "النصاب غير مكتمل: ${present} من ${required}";

  static String m14(count) => "عرض البنود الفرعية (${count})";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'لا مهام', one: 'مهمة واحدة', two: 'مهمتان', few: '${count} مهام', many: '${count} مهمة', other: '${count} مهمة')}";

  static String m16(count) => "${count} بانتظار تصويتك";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("من نحن"),
    "aboutUs": MessageLookupByLibrary.simpleMessage("معلومات عنا"),
    "accountCreated": MessageLookupByLibrary.simpleMessage("تم إنشاء الحساب!"),
    "addComment": MessageLookupByLibrary.simpleMessage("إضافة تعليق"),
    "addCorectData": MessageLookupByLibrary.simpleMessage(
      "يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء",
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
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "هل لديك حساب بالفعل؟",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("تطبيق"),
    "apply_filters": MessageLookupByLibrary.simpleMessage("تطبيق الفلاتر"),
    "approved": MessageLookupByLibrary.simpleMessage("تمت الموافقة"),
    "ar": MessageLookupByLibrary.simpleMessage("عربي"),
    "archived": MessageLookupByLibrary.simpleMessage("مؤرشف"),
    "at": MessageLookupByLibrary.simpleMessage("عند"),
    "attachFileOptional": MessageLookupByLibrary.simpleMessage(
      "إرفاق ملف (اختياري)",
    ),
    "attachmentLimit": MessageLookupByLibrary.simpleMessage("حتى 10 ميغابايت"),
    "attachmentTooLarge": MessageLookupByLibrary.simpleMessage(
      "حجم الملف أكبر من 10 ميغابايت.",
    ),
    "attendanceNotRecorded": MessageLookupByLibrary.simpleMessage(
      "لم يُسجَّل الحضور",
    ),
    "attendanceRecorded": MessageLookupByLibrary.simpleMessage("سُجّل الحضور"),
    "attendees": MessageLookupByLibrary.simpleMessage("الحضور"),
    "attendeesAndGuests": MessageLookupByLibrary.simpleMessage(
      "الحضور والضيوف",
    ),
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
    "canceled": MessageLookupByLibrary.simpleMessage("ملغي"),
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
    "city": MessageLookupByLibrary.simpleMessage("المدينة"),
    "clickToUpdate": MessageLookupByLibrary.simpleMessage("انقر للتعديل"),
    "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
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
    "committeesCount": m0,
    "company": MessageLookupByLibrary.simpleMessage("جهة العمل"),
    "completed": MessageLookupByLibrary.simpleMessage("منتهي"),
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
    "decidedByChair": MessageLookupByLibrary.simpleMessage("بصوت الرئيس"),
    "declare": MessageLookupByLibrary.simpleMessage("إفصاح"),
    "declareInterest": MessageLookupByLibrary.simpleMessage(
      "الإفصاح عن تعارض مصالح",
    ),
    "declareInterestHint": MessageLookupByLibrary.simpleMessage(
      "لن تُحتسب في نصاب هذا البند ولا في أغلبيته، وقد لا يمكنك التصويت على تصويتاته.",
    ),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
    "deliveryDate": MessageLookupByLibrary.simpleMessage("تاريخ التسليم "),
    "description": MessageLookupByLibrary.simpleMessage("الوصف"),
    "devBy": MessageLookupByLibrary.simpleMessage("تم التطوير بواسطة"),
    "didNotReceiveOTP": MessageLookupByLibrary.simpleMessage("لم تتلقَ الرمز؟"),
    "dinar": MessageLookupByLibrary.simpleMessage("دينار"),
    "discussion": MessageLookupByLibrary.simpleMessage("نقاش"),
    "discussions": MessageLookupByLibrary.simpleMessage("نقاشات"),
    "discussionsCount": m1,
    "doNotHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "لا تمتلك حساب؟",
    ),
    "documents": MessageLookupByLibrary.simpleMessage("المستندات"),
    "documentsCount": m2,
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
    "dueDate": MessageLookupByLibrary.simpleMessage("تاريخ الاستحقاق"),
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
    "fromLabel": MessageLookupByLibrary.simpleMessage("من"),
    "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "fullscreen": MessageLookupByLibrary.simpleMessage("ملء الشاشة"),
    "gender": MessageLookupByLibrary.simpleMessage("الجنس"),
    "goals": MessageLookupByLibrary.simpleMessage("الأهداف"),
    "goalsCount": m3,
    "governor": MessageLookupByLibrary.simpleMessage("المحافظة"),
    "guest": MessageLookupByLibrary.simpleMessage("ضيف"),
    "guests": MessageLookupByLibrary.simpleMessage("الضيوف"),
    "haveBeenCreated": MessageLookupByLibrary.simpleMessage("تم إنشاء حسابك"),
    "help": MessageLookupByLibrary.simpleMessage("المساعدة"),
    "helperPhoneText": MessageLookupByLibrary.simpleMessage(
      "يبدأ ب 07 ويحتوي 11 رَقَم",
    ),
    "hidePassword": MessageLookupByLibrary.simpleMessage("إخفاء"),
    "hideSubItems": m4,
    "hijriDate": MessageLookupByLibrary.simpleMessage("هجري"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "homeAddress": MessageLookupByLibrary.simpleMessage("عنوان المنزل"),
    "hours": MessageLookupByLibrary.simpleMessage("ساعات"),
    "hubAgendaUpdated": MessageLookupByLibrary.simpleMessage(
      "تحديث على جدول الأعمال",
    ),
    "hubAgendaUpdatedBody": m5,
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
    "itemsCount": m6,
    "join": MessageLookupByLibrary.simpleMessage("انضمام"),
    "joinOnlineHint": MessageLookupByLibrary.simpleMessage(
      "انضم بالصوت والصورة من هنا، وتبقى صفحة الاجتماع أمامك.",
    ),
    "ku": MessageLookupByLibrary.simpleMessage("كردي"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "lastName": MessageLookupByLibrary.simpleMessage("الاسم الأخير"),
    "lesson": MessageLookupByLibrary.simpleMessage("درس"),
    "listenOnly": MessageLookupByLibrary.simpleMessage("استماع فقط"),
    "liveAskToSpeak": MessageLookupByLibrary.simpleMessage("طلب الكلمة"),
    "liveConnected": MessageLookupByLibrary.simpleMessage("مباشر"),
    "liveConnecting": MessageLookupByLibrary.simpleMessage("جارٍ الاتصال…"),
    "liveCurrentItem": MessageLookupByLibrary.simpleMessage("البند المعروض"),
    "liveDisconnected": MessageLookupByLibrary.simpleMessage("غير متصل"),
    "liveNoItem": MessageLookupByLibrary.simpleMessage("لا يوجد بند معروض"),
    "liveNobodySpeaking": MessageLookupByLibrary.simpleMessage(
      "لا أحد يتحدث الآن",
    ),
    "liveNow": MessageLookupByLibrary.simpleMessage("مباشر الآن"),
    "livePaused": MessageLookupByLibrary.simpleMessage("متوقف"),
    "liveQueue": m7,
    "liveReconnecting": MessageLookupByLibrary.simpleMessage(
      "جارٍ إعادة الاتصال…",
    ),
    "liveRequestSent": MessageLookupByLibrary.simpleMessage("أُرسل طلبك"),
    "liveSpeaking": MessageLookupByLibrary.simpleMessage("يتحدث الآن"),
    "liveTapToRetry": MessageLookupByLibrary.simpleMessage(
      "التحديثات المباشرة متوقفة. اضغط لإعادة الاتصال.",
    ),
    "liveUpdates": MessageLookupByLibrary.simpleMessage("التحديثات المباشرة"),
    "liveWithdraw": MessageLookupByLibrary.simpleMessage("سحب الطلب"),
    "liveYourPlace": m8,
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
    "meetingsCount": m9,
    "member": MessageLookupByLibrary.simpleMessage("عضو"),
    "members": MessageLookupByLibrary.simpleMessage("الأعضاء"),
    "membersCount": m10,
    "middleName": MessageLookupByLibrary.simpleMessage("الاسم الأوسط"),
    "min": MessageLookupByLibrary.simpleMessage("دقيقة"),
    "minutes": MessageLookupByLibrary.simpleMessage("دقائق"),
    "muteMic": MessageLookupByLibrary.simpleMessage("كتم الميكروفون"),
    "myComment": MessageLookupByLibrary.simpleMessage("تعليقي"),
    "myInfo": MessageLookupByLibrary.simpleMessage("معلوماتي"),
    "myLocation": MessageLookupByLibrary.simpleMessage("موقعي الحالي"),
    "myOrder": MessageLookupByLibrary.simpleMessage("طلباتي"),
    "myOrders": MessageLookupByLibrary.simpleMessage("طلباتي"),
    "myProposals": m11,
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
    "noCommitteeDescription": MessageLookupByLibrary.simpleMessage(
      "لا يوجد وصف مسجّل لهذه اللجنة.",
    ),
    "noCommitteeStatement": MessageLookupByLibrary.simpleMessage(
      "لا يوجد بيان مسجّل لهذه اللجنة.",
    ),
    "noCommitteesDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا اللجان فور إضافتك إليها. اسحب الشاشة للأسفل للتحديث.",
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
    "noVotesForMeeting": MessageLookupByLibrary.simpleMessage(
      "لا توجد تصويتات لهذا الاجتماع",
    ),
    "noVotesForMeetingDescription": MessageLookupByLibrary.simpleMessage(
      "ستظهر هنا الاستطلاعات عند فتحها، ونتائجها بعد نشرها.",
    ),
    "noVotesPending": MessageLookupByLibrary.simpleMessage(
      "لا تصويتات بانتظارك",
    ),
    "notConnected": MessageLookupByLibrary.simpleMessage("غير متصل"),
    "notLoggedIn": MessageLookupByLibrary.simpleMessage(
      "المستخدم الحالي لم يسجل الدخول",
    ),
    "notYet": MessageLookupByLibrary.simpleMessage("ليس بعد"),
    "noteCannotHear": MessageLookupByLibrary.simpleMessage("لا أسمع"),
    "noteCannotSee": MessageLookupByLibrary.simpleMessage("لا أرى الشاشة"),
    "noteNeedHelp": MessageLookupByLibrary.simpleMessage("أحتاج مساعدة"),
    "notification": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "notifications": MessageLookupByLibrary.simpleMessage("إشعارات"),
    "numberPhone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "offer": MessageLookupByLibrary.simpleMessage("عرض"),
    "ok": MessageLookupByLibrary.simpleMessage("حسناً"),
    "onlineMeeting": MessageLookupByLibrary.simpleMessage("الاجتماع الأونلاين"),
    "oops": MessageLookupByLibrary.simpleMessage("حدث خطأ ما!"),
    "or": MessageLookupByLibrary.simpleMessage("أو"),
    "order_summary": MessageLookupByLibrary.simpleMessage("ملخص الطلب"),
    "other": MessageLookupByLibrary.simpleMessage("آخر"),
    "otpSentTo": MessageLookupByLibrary.simpleMessage(
      "أرسلنا الرمز برسالة نصية إلى",
    ),
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
    "proposalNoteHint": MessageLookupByLibrary.simpleMessage(
      "الخلفية وسبب الأهمية…",
    ),
    "proposalNoteOptional": MessageLookupByLibrary.simpleMessage(
      "تفاصيل (اختيارية)",
    ),
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
    "quickMessage": MessageLookupByLibrary.simpleMessage("رسالة سريعة للمدير"),
    "quorumMet": m12,
    "quorumNotMet": m13,
    "rated": MessageLookupByLibrary.simpleMessage("تم التقييم"),
    "rePassword": MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
    "readOnly": MessageLookupByLibrary.simpleMessage("للقراءة فقط"),
    "ready": MessageLookupByLibrary.simpleMessage("جاهز"),
    "readyToDeliver": MessageLookupByLibrary.simpleMessage("جاهز للتسليم"),
    "receiverPhone": MessageLookupByLibrary.simpleMessage("هاتف المستلم"),
    "region": MessageLookupByLibrary.simpleMessage("المنطقة"),
    "registeredBefore": MessageLookupByLibrary.simpleMessage("مسجل سابقًا"),
    "registered_before": MessageLookupByLibrary.simpleMessage("مسجل سابقًا"),
    "rejected": MessageLookupByLibrary.simpleMessage("مرفوضة"),
    "rejectionReason": MessageLookupByLibrary.simpleMessage("السبب"),
    "related_products": MessageLookupByLibrary.simpleMessage("منتجات ذات صلة"),
    "rememberMe": MessageLookupByLibrary.simpleMessage("تذكرني"),
    "rememberPassword": MessageLookupByLibrary.simpleMessage(
      "أتذكر كلمة المرور",
    ),
    "removeAttachment": MessageLookupByLibrary.simpleMessage("إزالة الملف"),
    "requestAbsence": MessageLookupByLibrary.simpleMessage("طلبات الغياب"),
    "requestSent": MessageLookupByLibrary.simpleMessage("أُرسل الطلب للمدير"),
    "requestToSpeak": MessageLookupByLibrary.simpleMessage("طلب الكلام"),
    "resend": MessageLookupByLibrary.simpleMessage("إعادة الإرسال"),
    "resendCode": MessageLookupByLibrary.simpleMessage("إعادة إرسال الرمز"),
    "reset_password": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "returned": MessageLookupByLibrary.simpleMessage("استعادة"),
    "reviewOrder": MessageLookupByLibrary.simpleMessage("عرض الطلب"),
    "reviews": MessageLookupByLibrary.simpleMessage("التقييمات"),
    "running": MessageLookupByLibrary.simpleMessage("جارية"),
    "saveChange": MessageLookupByLibrary.simpleMessage("حفظ التغيير"),
    "save_for_later": MessageLookupByLibrary.simpleMessage("حفظ لاحقًا؟"),
    "scheduled": MessageLookupByLibrary.simpleMessage("مجدولة"),
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
    "selectFromMap": MessageLookupByLibrary.simpleMessage("من الخريطة"),
    "selectGovernor": MessageLookupByLibrary.simpleMessage("اختر المحافظة"),
    "sendProposal": MessageLookupByLibrary.simpleMessage("إرسال الاقتراح"),
    "sendSuggestion": MessageLookupByLibrary.simpleMessage("إرسال الاقتراح"),
    "serverError": MessageLookupByLibrary.simpleMessage("خطأ في الخادم"),
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
    "showSubItems": m14,
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
    "tasks": MessageLookupByLibrary.simpleMessage("المهام"),
    "tasksCount": m15,
    "teachingStaff": MessageLookupByLibrary.simpleMessage("الكادر التدريسي"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "الشروط والأحكام",
    ),
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
    "votesPending": m16,
    "votesTitle": MessageLookupByLibrary.simpleMessage("التصويتات"),
    "votingEnded": MessageLookupByLibrary.simpleMessage("انتهى التصويت"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("أهلا بعودتك!"),
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
    "withdrawSuggestionConfirm": MessageLookupByLibrary.simpleMessage(
      "سحب اقتراح هذا الضيف؟",
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
    "yourAddress": MessageLookupByLibrary.simpleMessage("عنوانك"),
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
    "yourVote": MessageLookupByLibrary.simpleMessage("صوتك"),
  };
}
