// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) => "${count} absences";

  static String m1(count) => "${count} in a row";

  static String m2(role) => "You are acting as ${role}";

  static String m3(role, date) => "You are acting as ${role} until ${date}";

  static String m4(attended, invited) => "Attended ${attended} of ${invited}";

  static String m5(seconds) => "New code in ${seconds} s";

  static String m6(count) => "Votes (${count})";

  static String m7(count) => "${count} awaiting your vote";

  static String m8(days, hours) => "Closes in ${days}d ${hours}h";

  static String m9(hours, minutes) => "Closes in ${hours}h ${minutes}m";

  static String m10(minutes) => "Closes in ${minutes}m";

  static String m11(count) =>
      "${Intl.plural(count, zero: 'No committees', one: '1 committee', other: '${count} committees')}";

  static String m12(count) => "${count} decisions";

  static String m13(name) => "Delegated by ${name}";

  static String m14(from, to) => "From ${from} to ${to}";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'No discussions', one: '1 discussion', other: '${count} discussions')}";

  static String m16(count) =>
      "${Intl.plural(count, zero: 'No documents', one: '1 document', other: '${count} documents')}";

  static String m17(date) => "Due ${date}";

  static String m18(name, count) => "${name} × ${count}";

  static String m19(count) => "${count} excused";

  static String m20(name) => "From ${name}";

  static String m21(count) =>
      "${Intl.plural(count, zero: 'No goals', one: '1 goal', other: '${count} goals')}";

  static String m22(count) => "Hide sub-items (${count})";

  static String m23(count) => "Hospitality for ${count}";

  static String m24(title, status) => "“${title}”: ${status}";

  static String m25(count) => "${count} in the hall";

  static String m26(count) =>
      "${Intl.plural(count, zero: 'No items', one: '1 item', other: '${count} items')}";

  static String m27(count) => "${count} min";

  static String m28(count) => "Waiting (${count})";

  static String m29(time) => "Time per speaker: ${time}";

  static String m30(place) => "You are number ${place} in the queue";

  static String m31(count) =>
      "${Intl.plural(count, zero: 'No meetings', one: '1 meeting', other: '${count} meetings')}";

  static String m32(count) => "${count} more needed to reach the minimum";

  static String m33(count) =>
      "${Intl.plural(count, zero: 'No members', one: '1 member', other: '${count} members')}";

  static String m34(date) => "Answer by ${date}";

  static String m35(approved, total) => "${approved} of ${total} approved";

  static String m36(count) => "${count} rejected";

  static String m37(count) => "My proposals (${count})";

  static String m38(count) => "Not voted yet (${count})";

  static String m39(count) => "${count} pending";

  static String m40(present, required) =>
      "Quorum met: ${present} of ${required}";

  static String m41(present, required) =>
      "No quorum: ${present} of ${required}";

  static String m42(present, required) =>
      "${present} present of ${required} required";

  static String m43(count) => "Includes ${count} by proxy";

  static String m44(time) => "Recorded when the meeting started, at ${time}";

  static String m45(value) => "Needs ${value} members";

  static String m46(value, base) => "Needs ${value}% of ${base} members";

  static String m47(hall, remote) => "${hall} in the hall · ${remote} remote";

  static String m48(name) => "Raised by ${name}";

  static String m49(count) => "${count} reservations";

  static String m50(name) => "Answered by ${name}";

  static String m51(name) => "${name} will stop acting for you right away.";

  static String m52(count) => "Show sub-items (${count})";

  static String m53(count) => "Sub-committees (${count})";

  static String m54(count) =>
      "${Intl.plural(count, zero: 'No tasks', one: '1 task', other: '${count} tasks')}";

  static String m55(name) => "${name}\'s tasks";

  static String m56(name) => "To ${name}";

  static String m57(voted, total) => "${voted} of ${total} voted";

  static String m58(count) => "${count} awaiting your vote";

  static String m59(count) => "${count} done this year";

  static String m60(count) => "${count} due this week";

  static String m61(count) => "${count} open";

  static String m62(count) => "${count} overdue";

  static String m63(choice) =>
      "You voted ${choice}. You can change it until it closes.";

  static String m64(choice) => "Your vote: ${choice}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
    "absenceAccepted": MessageLookupByLibrary.simpleMessage(
      "The absence was accepted",
    ),
    "absenceAcceptedState": MessageLookupByLibrary.simpleMessage("Excused"),
    "absencePending": MessageLookupByLibrary.simpleMessage("Pending"),
    "absenceRejected": MessageLookupByLibrary.simpleMessage(
      "The absence was rejected",
    ),
    "absenceRejectedState": MessageLookupByLibrary.simpleMessage("Rejected"),
    "absenceRequests": MessageLookupByLibrary.simpleMessage("Absence requests"),
    "absenceRequestsHint": MessageLookupByLibrary.simpleMessage(
      "Members who asked to be excused from this meeting.",
    ),
    "absencesCount": m0,
    "absencesInRow": m1,
    "acceptAbsence": MessageLookupByLibrary.simpleMessage("Accept"),
    "acceptAbsenceTitle": MessageLookupByLibrary.simpleMessage(
      "Accept this absence request?",
    ),
    "acceptNeedsAgendaItem": MessageLookupByLibrary.simpleMessage(
      "Add the item to the agenda on the web first, then accept the proposal here.",
    ),
    "acceptProposal": MessageLookupByLibrary.simpleMessage("Accept"),
    "acceptProposalHint": MessageLookupByLibrary.simpleMessage(
      "Choose the item you added for this proposal.",
    ),
    "acceptProposalTitle": MessageLookupByLibrary.simpleMessage(
      "Which agenda item is it?",
    ),
    "accountCreated": MessageLookupByLibrary.simpleMessage("Account Created!"),
    "actingAs": m2,
    "actingAsUntil": m3,
    "addComment": MessageLookupByLibrary.simpleMessage("Add comment"),
    "addCorectData": MessageLookupByLibrary.simpleMessage(
      "يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء",
    ),
    "addDelegation": MessageLookupByLibrary.simpleMessage("Add delegation"),
    "addDelegationHint": MessageLookupByLibrary.simpleMessage(
      "You keep your role meanwhile. The member acts for you only in the areas you choose.",
    ),
    "addGuest": MessageLookupByLibrary.simpleMessage("Add guest"),
    "addGuestHint": MessageLookupByLibrary.simpleMessage(
      "All fields are required. The guest appears under \"Suggested guests\" after sending.",
    ),
    "addReview": MessageLookupByLibrary.simpleMessage("Add Review"),
    "add_to_cart": MessageLookupByLibrary.simpleMessage("Add To Cart"),
    "additional_service": MessageLookupByLibrary.simpleMessage(
      "Additional service",
    ),
    "agendaItem": MessageLookupByLibrary.simpleMessage("Agenda item"),
    "agendaProposals": MessageLookupByLibrary.simpleMessage("Agenda proposals"),
    "agendaProposalsClosed": MessageLookupByLibrary.simpleMessage(
      "Proposals are closed for this meeting.",
    ),
    "agendaProposalsHint": MessageLookupByLibrary.simpleMessage(
      "Suggest an item before the agenda is published.",
    ),
    "agendaRequestAccepted": MessageLookupByLibrary.simpleMessage("Accepted"),
    "agendaRequestClosed": MessageLookupByLibrary.simpleMessage("Closed"),
    "agendaRequestPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "agendaRequestRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "agendaStatusActive": MessageLookupByLibrary.simpleMessage("In progress"),
    "agendaStatusConcluded": MessageLookupByLibrary.simpleMessage("Concluded"),
    "agendaStatusDelayed": MessageLookupByLibrary.simpleMessage("Delayed"),
    "agendaStatusPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "agendas": MessageLookupByLibrary.simpleMessage("Agendas"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "allMembers": MessageLookupByLibrary.simpleMessage("All members"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Already Have An Account?",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Apply"),
    "apply_filters": MessageLookupByLibrary.simpleMessage("Apply filters"),
    "approvalNeedsHalf": MessageLookupByLibrary.simpleMessage(
      "Approved when approvals pass half of all voters\' weight. Abstaining and not voting count against.",
    ),
    "approvalWeight": MessageLookupByLibrary.simpleMessage("Approval"),
    "approve": MessageLookupByLibrary.simpleMessage("Approve"),
    "approveRecommendationTitle": MessageLookupByLibrary.simpleMessage(
      "Approve this recommendation?",
    ),
    "approved": MessageLookupByLibrary.simpleMessage("Approved"),
    "approvedState": MessageLookupByLibrary.simpleMessage("Approved"),
    "ar": MessageLookupByLibrary.simpleMessage("Arabic"),
    "archived": MessageLookupByLibrary.simpleMessage("Published"),
    "at": MessageLookupByLibrary.simpleMessage("At"),
    "attachFileOptional": MessageLookupByLibrary.simpleMessage(
      "Attach a file (optional)",
    ),
    "attachment": MessageLookupByLibrary.simpleMessage("Attachment"),
    "attachmentLimit": MessageLookupByLibrary.simpleMessage("Up to 10 MB"),
    "attachmentTooLarge": MessageLookupByLibrary.simpleMessage(
      "The file is larger than 10 MB.",
    ),
    "attendanceCompliance": MessageLookupByLibrary.simpleMessage("Attendance"),
    "attendanceNotRecorded": MessageLookupByLibrary.simpleMessage(
      "Attendance not recorded",
    ),
    "attendanceRecorded": MessageLookupByLibrary.simpleMessage(
      "Attendance recorded",
    ),
    "attendanceSubtitleLead": MessageLookupByLibrary.simpleMessage(
      "Meetings this year and members at risk",
    ),
    "attendanceSubtitleMember": MessageLookupByLibrary.simpleMessage(
      "Your attendance this year",
    ),
    "attendanceUnavailable": MessageLookupByLibrary.simpleMessage(
      "Attendance isn\'t available",
    ),
    "attendedOf": m4,
    "attendees": MessageLookupByLibrary.simpleMessage("Attendees"),
    "attendeesAndGuests": MessageLookupByLibrary.simpleMessage(
      "Attendees & guests",
    ),
    "awaitingYourVote": MessageLookupByLibrary.simpleMessage(
      "Awaiting your vote",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backToLogin": MessageLookupByLibrary.simpleMessage("Back to login"),
    "basicInfo": MessageLookupByLibrary.simpleMessage("Basic information"),
    "birthday": MessageLookupByLibrary.simpleMessage("birthday"),
    "build": MessageLookupByLibrary.simpleMessage("Build"),
    "buildNumber": MessageLookupByLibrary.simpleMessage("Build Number"),
    "cameraOff": MessageLookupByLibrary.simpleMessage("Turn camera off"),
    "cameraOn": MessageLookupByLibrary.simpleMessage("Turn camera on"),
    "cameraPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Allow camera access in the settings to scan, or type the code below.",
    ),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "The camera isn\'t available. Type the code below.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelRequest": MessageLookupByLibrary.simpleMessage("Cancel request"),
    "cancelServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Cancel this request?",
    ),
    "canceled": MessageLookupByLibrary.simpleMessage("Canceled"),
    "card_name": MessageLookupByLibrary.simpleMessage("Card Name"),
    "card_number": MessageLookupByLibrary.simpleMessage("Card Number"),
    "cart": MessageLookupByLibrary.simpleMessage("Cart"),
    "cashPayment": MessageLookupByLibrary.simpleMessage("Cash Payment"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "chair": MessageLookupByLibrary.simpleMessage("Chair"),
    "changeAddress": MessageLookupByLibrary.simpleMessage("Change Address"),
    "changeEmail": MessageLookupByLibrary.simpleMessage("Change Email"),
    "changeFile": MessageLookupByLibrary.simpleMessage("Change File"),
    "changeLanguage": MessageLookupByLibrary.simpleMessage("Change Language"),
    "changeName": MessageLookupByLibrary.simpleMessage("Change Name"),
    "changePass": MessageLookupByLibrary.simpleMessage("Change Password"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "changePhone": MessageLookupByLibrary.simpleMessage("Change Phone Number"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Change profile photo"),
    "changeVote": MessageLookupByLibrary.simpleMessage("Change vote"),
    "checkIn": MessageLookupByLibrary.simpleMessage("Check in"),
    "checkInAlready": MessageLookupByLibrary.simpleMessage(
      "You were already checked in",
    ),
    "checkInAt": MessageLookupByLibrary.simpleMessage("at"),
    "checkInCardHint": MessageLookupByLibrary.simpleMessage(
      "Record your arrival with the QR code at the hall door.",
    ),
    "checkInCardTitle": MessageLookupByLibrary.simpleMessage("Hall check-in"),
    "checkInCodeHint": MessageLookupByLibrary.simpleMessage(
      "Attendees scan this code with the app to check in.",
    ),
    "checkInCodeNext": m5,
    "checkInCodeShow": MessageLookupByLibrary.simpleMessage("Show the hall QR"),
    "checkInCodeShowHint": MessageLookupByLibrary.simpleMessage(
      "Display it on a tablet at the door for check-in.",
    ),
    "checkInCodeTitle": MessageLookupByLibrary.simpleMessage("Hall QR"),
    "checkInCodeUnavailable": MessageLookupByLibrary.simpleMessage(
      "The code isn\'t available",
    ),
    "checkInDone": MessageLookupByLibrary.simpleMessage("You\'re checked in"),
    "checkInInHall": MessageLookupByLibrary.simpleMessage("in the hall"),
    "checkInOnline": MessageLookupByLibrary.simpleMessage("online"),
    "checkInOtherMeeting": MessageLookupByLibrary.simpleMessage(
      "This code is for another meeting.",
    ),
    "checkInScanButton": MessageLookupByLibrary.simpleMessage("Scan the code"),
    "checkInScanHint": MessageLookupByLibrary.simpleMessage(
      "Point the camera at the QR code at the hall door.",
    ),
    "checkInTypeCode": MessageLookupByLibrary.simpleMessage(
      "Type the six-digit code shown under the QR",
    ),
    "checkedInAt": MessageLookupByLibrary.simpleMessage("Checked in at"),
    "choosing": MessageLookupByLibrary.simpleMessage("Choosing"),
    "circulation": MessageLookupByLibrary.simpleMessage(
      "Decision by circulation",
    ),
    "circulationAbstain": MessageLookupByLibrary.simpleMessage("Abstain"),
    "circulationApprove": MessageLookupByLibrary.simpleMessage("Approve"),
    "circulationApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "circulationClosed": MessageLookupByLibrary.simpleMessage("Closed"),
    "circulationDraft": MessageLookupByLibrary.simpleMessage("Draft"),
    "circulationNotFound": MessageLookupByLibrary.simpleMessage(
      "This decision couldn\'t be loaded",
    ),
    "circulationOpen": MessageLookupByLibrary.simpleMessage("Open"),
    "circulationReasonHint": MessageLookupByLibrary.simpleMessage(
      "Add a short reason for your vote",
    ),
    "circulationReject": MessageLookupByLibrary.simpleMessage("Reject"),
    "circulationRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "circulationResult": MessageLookupByLibrary.simpleMessage("Result"),
    "circulationVoteSaved": MessageLookupByLibrary.simpleMessage(
      "Your vote was saved",
    ),
    "circulationVotes": m6,
    "circulationVotingClosed": MessageLookupByLibrary.simpleMessage(
      "The deadline has passed; voting is closed.",
    ),
    "circulationWithdrawn": MessageLookupByLibrary.simpleMessage("Withdrawn"),
    "circulations": MessageLookupByLibrary.simpleMessage(
      "Decisions by circulation",
    ),
    "circulationsAwaiting": m7,
    "circulationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Vote on decisions without a meeting",
    ),
    "city": MessageLookupByLibrary.simpleMessage("City"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Clear all"),
    "clickToUpdate": MessageLookupByLibrary.simpleMessage("Click To Update"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "closedAt": MessageLookupByLibrary.simpleMessage("Closed"),
    "closesInDaysHours": m8,
    "closesInHoursMinutes": m9,
    "closesInMinutes": m10,
    "codeSentToEmail": MessageLookupByLibrary.simpleMessage(
      "Confirmation code sent to email: ",
    ),
    "code_invalid": MessageLookupByLibrary.simpleMessage(
      "This Code Is Invalid CODE",
    ),
    "collapse": MessageLookupByLibrary.simpleMessage("Collapse"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colors": MessageLookupByLibrary.simpleMessage("Colors"),
    "commentHint": MessageLookupByLibrary.simpleMessage(
      "One comment per item, and it can\'t be edited after sending.",
    ),
    "committeeCalendar": MessageLookupByLibrary.simpleMessage(
      "Committee calendar",
    ),
    "committeeDescription": MessageLookupByLibrary.simpleMessage(
      "Committee description",
    ),
    "committeeMeetings": MessageLookupByLibrary.simpleMessage(
      "Committee meetings",
    ),
    "committeeStatement": MessageLookupByLibrary.simpleMessage(
      "Committee statement",
    ),
    "committeesCount": m11,
    "company": MessageLookupByLibrary.simpleMessage("Company"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "complianceOk": MessageLookupByLibrary.simpleMessage("OK"),
    "complianceReached": MessageLookupByLibrary.simpleMessage("Over the limit"),
    "complianceWarning": MessageLookupByLibrary.simpleMessage("Near the limit"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmAddress": MessageLookupByLibrary.simpleMessage("Confirm Address"),
    "confirmCode": MessageLookupByLibrary.simpleMessage(
      "Enter Confirmation Code",
    ),
    "confirmMethod": MessageLookupByLibrary.simpleMessage(
      "Please Choose How You Would Like To Send The Verification Code",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "confirm New Password",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("confirm password"),
    "confirmPayment": MessageLookupByLibrary.simpleMessage("Done Payment"),
    "confirmYourPhone": MessageLookupByLibrary.simpleMessage(
      "Confirm Your Phone",
    ),
    "confirm_address": MessageLookupByLibrary.simpleMessage("Confirm Address"),
    "confirmation": MessageLookupByLibrary.simpleMessage("Confirmation"),
    "connect": MessageLookupByLibrary.simpleMessage("Connect"),
    "connected": MessageLookupByLibrary.simpleMessage("Connected"),
    "connectionSuspendedTitle": MessageLookupByLibrary.simpleMessage(
      "Your connection is paused",
    ),
    "contact": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "continueSignUp": MessageLookupByLibrary.simpleMessage("Continue Sign Up"),
    "continueTo": MessageLookupByLibrary.simpleMessage("Continue"),
    "country": MessageLookupByLibrary.simpleMessage("Country"),
    "coupon_code": MessageLookupByLibrary.simpleMessage("Coupon Code"),
    "courses": MessageLookupByLibrary.simpleMessage("Courses"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "createNewAccount": MessageLookupByLibrary.simpleMessage(
      "Create New Account",
    ),
    "currency": MessageLookupByLibrary.simpleMessage("Currency"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current Password"),
    "cvc": MessageLookupByLibrary.simpleMessage("Cvc"),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "deadline": MessageLookupByLibrary.simpleMessage("Deadline"),
    "deadlinePassed": MessageLookupByLibrary.simpleMessage("Deadline passed"),
    "decidedByChair": MessageLookupByLibrary.simpleMessage(
      "decided by the chair",
    ),
    "decisionText": MessageLookupByLibrary.simpleMessage("Decision text"),
    "decisions": MessageLookupByLibrary.simpleMessage("Decisions"),
    "decisionsCount": m12,
    "declare": MessageLookupByLibrary.simpleMessage("Declare"),
    "declareInterest": MessageLookupByLibrary.simpleMessage(
      "Declare an interest",
    ),
    "declareInterestHint": MessageLookupByLibrary.simpleMessage(
      "You will be left out of this item\'s quorum and majority, and you may not be able to vote on its polls.",
    ),
    "delegateAction": MessageLookupByLibrary.simpleMessage("Delegate"),
    "delegateTo": MessageLookupByLibrary.simpleMessage("Delegate to"),
    "delegatedBy": m13,
    "delegationActive": MessageLookupByLibrary.simpleMessage("Active"),
    "delegationAdded": MessageLookupByLibrary.simpleMessage(
      "The delegation was added",
    ),
    "delegationAllScopes": MessageLookupByLibrary.simpleMessage("All areas"),
    "delegationEnded": MessageLookupByLibrary.simpleMessage("Ended"),
    "delegationEnds": MessageLookupByLibrary.simpleMessage("Ends"),
    "delegationFromTo": m14,
    "delegationPeriod": MessageLookupByLibrary.simpleMessage("Period"),
    "delegationPeriodHint": MessageLookupByLibrary.simpleMessage(
      "Up to a year. It ends at the end of the last day.",
    ),
    "delegationReasonHint": MessageLookupByLibrary.simpleMessage(
      "For example: travelling for a conference",
    ),
    "delegationReasonOptional": MessageLookupByLibrary.simpleMessage(
      "Reason (optional)",
    ),
    "delegationRevoked": MessageLookupByLibrary.simpleMessage(
      "The delegation was revoked",
    ),
    "delegationRevokedState": MessageLookupByLibrary.simpleMessage("Revoked"),
    "delegationRole": MessageLookupByLibrary.simpleMessage("Role"),
    "delegationScopes": MessageLookupByLibrary.simpleMessage("Areas"),
    "delegationStarts": MessageLookupByLibrary.simpleMessage("Starts"),
    "delegationUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "delegations": MessageLookupByLibrary.simpleMessage("Delegations"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
    "deliveryDate": MessageLookupByLibrary.simpleMessage("Delivery Date"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "devBy": MessageLookupByLibrary.simpleMessage("Power by "),
    "didNotReceiveOTP": MessageLookupByLibrary.simpleMessage(
      "Didn\'t Receive The OTP?",
    ),
    "dinar": MessageLookupByLibrary.simpleMessage("Dinar"),
    "discussion": MessageLookupByLibrary.simpleMessage("Discussion"),
    "discussions": MessageLookupByLibrary.simpleMessage("Discussions"),
    "discussionsCount": m15,
    "doNotHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t Have An Account?",
    ),
    "documents": MessageLookupByLibrary.simpleMessage("Documents"),
    "documentsCount": m16,
    "dollar": MessageLookupByLibrary.simpleMessage("Dollar"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "doneCanceled": MessageLookupByLibrary.simpleMessage("Order Canceled"),
    "doneCompleted": MessageLookupByLibrary.simpleMessage("Order Completed"),
    "donePaymentFailed": MessageLookupByLibrary.simpleMessage(" PaymentFailed"),
    "donePending": MessageLookupByLibrary.simpleMessage("Order Created"),
    "donePick": MessageLookupByLibrary.simpleMessage("Done Pick"),
    "doneProcessing": MessageLookupByLibrary.simpleMessage("Order Processed"),
    "doneReady": MessageLookupByLibrary.simpleMessage("Order Was Ready"),
    "doneReturned": MessageLookupByLibrary.simpleMessage("Order Returned"),
    "doneSendCode": MessageLookupByLibrary.simpleMessage(
      "The code has been sent! If necessary, we can resend the code up to two additional times.",
    ),
    "doneSendSms": MessageLookupByLibrary.simpleMessage(
      "We have sent a text message containing your verification code to the phone number: ",
    ),
    "doneShipping": MessageLookupByLibrary.simpleMessage("Order Shipped"),
    "done_resend_code": MessageLookupByLibrary.simpleMessage(
      "Done resend code",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "downloadFile": MessageLookupByLibrary.simpleMessage("Download File"),
    "draft": MessageLookupByLibrary.simpleMessage("Draft"),
    "draftHiddenFromMembers": MessageLookupByLibrary.simpleMessage(
      "Members can\'t see this yet.",
    ),
    "dueDate": MessageLookupByLibrary.simpleMessage("Due date"),
    "dueOn": m17,
    "ePayment": MessageLookupByLibrary.simpleMessage("E-Payment"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "editVote": MessageLookupByLibrary.simpleMessage("Edit Vote"),
    "educationalGrade": MessageLookupByLibrary.simpleMessage(
      "Educational Grade",
    ),
    "educationalProgress": MessageLookupByLibrary.simpleMessage(
      "Educational Progress",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailEmpty": MessageLookupByLibrary.simpleMessage(
      "Email field is required",
    ),
    "emptyCart": MessageLookupByLibrary.simpleMessage(
      "Sorry, There Are \nNo Requests",
    ),
    "emptyFav": MessageLookupByLibrary.simpleMessage(
      "Sorry, There Are \nNo Requests",
    ),
    "emptyNotifications": MessageLookupByLibrary.simpleMessage(
      "Sorry, There Are \nNo Notifications",
    ),
    "emptyOffers": MessageLookupByLibrary.simpleMessage(
      "Sorry, There Are \nNo Offers",
    ),
    "emptyOrders": MessageLookupByLibrary.simpleMessage(
      "Sorry, There Are \nNo Orders",
    ),
    "emptyReview": MessageLookupByLibrary.simpleMessage("No Reviews found"),
    "emptySearch": MessageLookupByLibrary.simpleMessage(
      "Sorry, Your Search Is \nNot Available",
    ),
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "endCall": MessageLookupByLibrary.simpleMessage("End call"),
    "endCallConfirm": MessageLookupByLibrary.simpleMessage("End the call?"),
    "endCallConfirmDescription": MessageLookupByLibrary.simpleMessage(
      "You will leave the online meeting and stay on the meeting page.",
    ),
    "enterOTP": MessageLookupByLibrary.simpleMessage(
      "Enter Your OTP Code Here.",
    ),
    "enter_new_password_and_confirm": MessageLookupByLibrary.simpleMessage(
      "Enter New Password And Confirm.",
    ),
    "equipmentDetailsHint": MessageLookupByLibrary.simpleMessage(
      "Notes (optional)",
    ),
    "equipmentQuantity": m18,
    "errAgendaRequestNotPending": MessageLookupByLibrary.simpleMessage(
      "This proposal has already been answered.",
    ),
    "errAgendaRequestTitleRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a title for the proposal.",
    ),
    "errAgendaRequestsClosed": MessageLookupByLibrary.simpleMessage(
      "Proposals are closed: the agenda is published or the meeting has started.",
    ),
    "errAlreadyVoted": MessageLookupByLibrary.simpleMessage(
      "A vote has already been recorded for this person on this poll.",
    ),
    "errCheckInClosed": MessageLookupByLibrary.simpleMessage(
      "Check-in is open only while the meeting is scheduled or running.",
    ),
    "errCheckInCodeInvalid": MessageLookupByLibrary.simpleMessage(
      "The code is wrong or has expired. Scan it again.",
    ),
    "errCheckInNotInvited": MessageLookupByLibrary.simpleMessage(
      "You aren\'t invited to this meeting.",
    ),
    "errCheckInTooManyTries": MessageLookupByLibrary.simpleMessage(
      "Too many wrong codes. Try again in a few minutes.",
    ),
    "errCirculationChoiceInvalid": MessageLookupByLibrary.simpleMessage(
      "Choose approve, reject or abstain.",
    ),
    "errCirculationDeadlinePast": MessageLookupByLibrary.simpleMessage(
      "The deadline must be in the future.",
    ),
    "errCirculationNoVoters": MessageLookupByLibrary.simpleMessage(
      "The committee has no members to vote.",
    ),
    "errCirculationNotDraft": MessageLookupByLibrary.simpleMessage(
      "Only a draft can be changed, deleted or sent for votes.",
    ),
    "errCirculationNotOpen": MessageLookupByLibrary.simpleMessage(
      "Voting on this decision is closed.",
    ),
    "errCirculationReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "The reason can be at most 500 characters.",
    ),
    "errCirculationStatementRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the decision text.",
    ),
    "errCirculationTitleRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a title.",
    ),
    "errCirculationTitleTooLong": MessageLookupByLibrary.simpleMessage(
      "The title can be at most 300 characters.",
    ),
    "errCommitteeAlreadyHasAChair": MessageLookupByLibrary.simpleMessage(
      "This committee already has a chair.",
    ),
    "errCommitteeAlreadyHasASecretary": MessageLookupByLibrary.simpleMessage(
      "This committee already has a secretary.",
    ),
    "errCommitteeIsInactive": MessageLookupByLibrary.simpleMessage(
      "The committee is inactive, so it takes no new meetings.",
    ),
    "errComplianceRuleInvalid": MessageLookupByLibrary.simpleMessage(
      "Each limit must be a whole number from 1 (warning from 0).",
    ),
    "errDecisionLinkInvalid": MessageLookupByLibrary.simpleMessage(
      "The earlier decision must be a published decision of the same committee.",
    ),
    "errDelegationInvalid": MessageLookupByLibrary.simpleMessage(
      "This delegation isn\'t possible: check the role, the member, the dates (up to a year, ending in the future), the scopes, and that it doesn\'t overlap another.",
    ),
    "errHallCapacityExceeded": MessageLookupByLibrary.simpleMessage(
      "The hall can\'t seat all the committee\'s members.",
    ),
    "errHallIsBooked": MessageLookupByLibrary.simpleMessage(
      "The hall is booked for another meeting at that time.",
    ),
    "errHallServiceInvalid": MessageLookupByLibrary.simpleMessage(
      "The request can\'t be saved: the meeting has no hall or is over, the equipment or quantity is wrong, details are missing or too long, or the request is already closed.",
    ),
    "errInterestAlreadyDeclared": MessageLookupByLibrary.simpleMessage(
      "An interest in this item is already declared.",
    ),
    "errInterestDeclared": MessageLookupByLibrary.simpleMessage(
      "This voter declared an interest in the item and can\'t vote on it.",
    ),
    "errInterestNoteTooLong": MessageLookupByLibrary.simpleMessage(
      "The note is too long (500 characters at most).",
    ),
    "errLifecycleInvalid": MessageLookupByLibrary.simpleMessage(
      "Check the dates: a term can\'t end before it starts, and a temporary committee needs an end date.",
    ),
    "errLiveInvalid": MessageLookupByLibrary.simpleMessage(
      "This can\'t be done now: the meeting isn\'t in progress, the item belongs to another meeting, or the length is outside 1 second to 8 hours.",
    ),
    "errMeetingNotOnline": MessageLookupByLibrary.simpleMessage(
      "This meeting has no online room.",
    ),
    "errMeetingOnHoliday": MessageLookupByLibrary.simpleMessage(
      "A meeting can\'t be held during a holiday.",
    ),
    "errMeetingOnWeekend": MessageLookupByLibrary.simpleMessage(
      "A meeting can\'t be held on a weekend day.",
    ),
    "errMeetingStatusChangeNotAllowed": MessageLookupByLibrary.simpleMessage(
      "The meeting can\'t move from its current status to that one.",
    ),
    "errMinuteAlreadyFinal": MessageLookupByLibrary.simpleMessage(
      "The minutes are already confirmed.",
    ),
    "errMinuteApprovalClosed": MessageLookupByLibrary.simpleMessage(
      "The deadline for answering has passed.",
    ),
    "errMinuteApprovalsPending": MessageLookupByLibrary.simpleMessage(
      "The minutes can\'t be confirmed until the approval path is complete.",
    ),
    "errMinuteChairApprovesLast": MessageLookupByLibrary.simpleMessage(
      "The chair approves after the other members.",
    ),
    "errMinuteReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "The reason can be at most 500 characters.",
    ),
    "errMinuteRejectionReasonRequired": MessageLookupByLibrary.simpleMessage(
      "Give a reason for rejecting the minutes.",
    ),
    "errNotFound": MessageLookupByLibrary.simpleMessage(
      "The item wasn\'t found.",
    ),
    "errNoticeGroupUnknown": MessageLookupByLibrary.simpleMessage(
      "Unknown kind of notification.",
    ),
    "errNoticeLanguageNotSupported": MessageLookupByLibrary.simpleMessage(
      "Choose Arabic or English for your notifications.",
    ),
    "errOptionIsNotInPoll": MessageLookupByLibrary.simpleMessage(
      "This option doesn\'t belong to this poll.",
    ),
    "errPartySuspendInvalid": MessageLookupByLibrary.simpleMessage(
      "This person can\'t be deactivated or reactivated now (it may be your own account, or already in that state).",
    ),
    "errPeriodicTemplateInvalid": MessageLookupByLibrary.simpleMessage(
      "The template can\'t be saved: 1 to 12 meetings ahead, at most 30 items, each with a title up to 500 characters and up to 600 minutes.",
    ),
    "errPollIsNotOpen": MessageLookupByLibrary.simpleMessage(
      "Voting is only possible while the poll is open.",
    ),
    "errQuorumRuleInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter a number of at least 1 (a percentage up to 100).",
    ),
    "errReasonRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a reason.",
    ),
    "errRecommendationInvalid": MessageLookupByLibrary.simpleMessage(
      "The recommendation can\'t be saved: the committee has no parent or is inactive, the text is missing or too long, or it was already answered.",
    ),
    "errReportYearInvalid": MessageLookupByLibrary.simpleMessage(
      "The year must be between 1900 and 3000.",
    ),
    "errReservationReasonRequired": MessageLookupByLibrary.simpleMessage(
      "Give a reason for the reservation.",
    ),
    "errReservationReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "The reason can be at most 500 characters.",
    ),
    "errSpeakerInvalid": MessageLookupByLibrary.simpleMessage(
      "This step on the speaker queue doesn\'t apply now (the meeting isn\'t in progress, you have already asked, nobody is waiting, or the limit is over an hour).",
    ),
    "errSubcommitteeInvalid": MessageLookupByLibrary.simpleMessage(
      "This committee can\'t be placed there: it would be under itself, or the structure would be deeper than 5 levels.",
    ),
    "errTaskDecisionInvalid": MessageLookupByLibrary.simpleMessage(
      "The decision must belong to the same committee as the task.",
    ),
    "errTaskReassignInvalid": MessageLookupByLibrary.simpleMessage(
      "Pick tasks assigned to this member, and another member of the committee to move them to.",
    ),
    "errUnauthorizedUser": MessageLookupByLibrary.simpleMessage(
      "You aren\'t authorized to do this.",
    ),
    "errUserSuspended": MessageLookupByLibrary.simpleMessage(
      "This account is deactivated. Contact the system administrator.",
    ),
    "errValidationError": MessageLookupByLibrary.simpleMessage(
      "Some of the data isn\'t valid.",
    ),
    "errVoteReasonRequired": MessageLookupByLibrary.simpleMessage(
      "Give a reason for objecting or abstaining.",
    ),
    "errVoteReasonTooLong": MessageLookupByLibrary.simpleMessage(
      "The reason is too long (500 characters at most).",
    ),
    "errVotingRuleInvalid": MessageLookupByLibrary.simpleMessage(
      "Choose a valid majority.",
    ),
    "errYouCanNotChangePollTypeAfterVoting":
        MessageLookupByLibrary.simpleMessage(
          "The vote type can\'t be changed once votes have been cast.",
        ),
    "errYouDoNotHavePermission": MessageLookupByLibrary.simpleMessage(
      "You don\'t have permission to do this.",
    ),
    "estimatedFor": MessageLookupByLibrary.simpleMessage("Estimated For"),
    "excusedCount": m19,
    "expiration": MessageLookupByLibrary.simpleMessage("Expiration"),
    "faq": MessageLookupByLibrary.simpleMessage("F.A.q"),
    "fav": MessageLookupByLibrary.simpleMessage("Favorites"),
    "female": MessageLookupByLibrary.simpleMessage("Female"),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "firstName": MessageLookupByLibrary.simpleMessage("first name"),
    "flash_deal": MessageLookupByLibrary.simpleMessage("Flash Deal"),
    "follow": MessageLookupByLibrary.simpleMessage("Follow"),
    "forgetPassword": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "forgetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter the phone number registered to your account.",
    ),
    "forgetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Recover your password",
    ),
    "formationDate": MessageLookupByLibrary.simpleMessage("Formation date"),
    "freeLesson": MessageLookupByLibrary.simpleMessage("Free lessons"),
    "freeSummary": MessageLookupByLibrary.simpleMessage("Free Summary"),
    "fromCommittee": m20,
    "fromLabel": MessageLookupByLibrary.simpleMessage("From"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "fullscreen": MessageLookupByLibrary.simpleMessage("Full screen"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "goals": MessageLookupByLibrary.simpleMessage("Goals"),
    "goalsCount": m21,
    "governor": MessageLookupByLibrary.simpleMessage("governor"),
    "guest": MessageLookupByLibrary.simpleMessage("Guest"),
    "guests": MessageLookupByLibrary.simpleMessage("Guests"),
    "hallServices": MessageLookupByLibrary.simpleMessage("Hall services"),
    "hallServicesHint": MessageLookupByLibrary.simpleMessage(
      "Ask facilities for hospitality or another service.",
    ),
    "haveBeenCreated": MessageLookupByLibrary.simpleMessage(
      "Your Account Had Been Created",
    ),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "helperPhoneText": MessageLookupByLibrary.simpleMessage(
      "start with 07 and 11 digit",
    ),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Hide"),
    "hideSubItems": m22,
    "hijriDate": MessageLookupByLibrary.simpleMessage("Hijri"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "homeAddress": MessageLookupByLibrary.simpleMessage("Home Address"),
    "hospitalityDetailsHint": MessageLookupByLibrary.simpleMessage(
      "For example: coffee and water at 10:00",
    ),
    "hospitalityFor": m23,
    "host": MessageLookupByLibrary.simpleMessage("Host"),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "hubAgendaUpdated": MessageLookupByLibrary.simpleMessage("Agenda updated"),
    "hubAgendaUpdatedBody": m24,
    "hubDecisionPublished": MessageLookupByLibrary.simpleMessage(
      "A decision was published",
    ),
    "hubDiscussionClosed": MessageLookupByLibrary.simpleMessage(
      "A discussion was closed",
    ),
    "hubDiscussionOpened": MessageLookupByLibrary.simpleMessage(
      "A discussion was opened",
    ),
    "hubDiscussionUpdated": MessageLookupByLibrary.simpleMessage(
      "A discussion was updated",
    ),
    "hubPollClosed": MessageLookupByLibrary.simpleMessage("A vote was closed"),
    "hubPollOpened": MessageLookupByLibrary.simpleMessage("A vote was opened"),
    "hubPollPublished": MessageLookupByLibrary.simpleMessage(
      "Vote results published",
    ),
    "hubPollUpdated": MessageLookupByLibrary.simpleMessage(
      "A vote was updated",
    ),
    "iAmNotCurrentlyAMemberOfAnyCommittees":
        MessageLookupByLibrary.simpleMessage(
          "I am not currently a member of any committees.",
        ),
    "identityImage": MessageLookupByLibrary.simpleMessage("Identity Image"),
    "inHall": m25,
    "interestDeclared": MessageLookupByLibrary.simpleMessage(
      "You declared an interest in this item",
    ),
    "interestNoteHint": MessageLookupByLibrary.simpleMessage(
      "Briefly describe the interest",
    ),
    "interestNoteOptional": MessageLookupByLibrary.simpleMessage(
      "Note (optional)",
    ),
    "isSuccess": MessageLookupByLibrary.simpleMessage("Success!"),
    "is_required": MessageLookupByLibrary.simpleMessage("Required"),
    "itemsCount": m26,
    "join": MessageLookupByLibrary.simpleMessage("Join"),
    "joinAsHost": MessageLookupByLibrary.simpleMessage("Join as host"),
    "joinOnlineHint": MessageLookupByLibrary.simpleMessage(
      "Join with audio and video here while the meeting page stays in front of you.",
    ),
    "ku": MessageLookupByLibrary.simpleMessage("Kurdish"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastName": MessageLookupByLibrary.simpleMessage("Last name"),
    "lesson": MessageLookupByLibrary.simpleMessage("Lesson"),
    "listenOnly": MessageLookupByLibrary.simpleMessage("Listen only"),
    "liveAskToSpeak": MessageLookupByLibrary.simpleMessage("Ask to speak"),
    "liveChangeItem": MessageLookupByLibrary.simpleMessage("Change item"),
    "liveClearScreen": MessageLookupByLibrary.simpleMessage("Clear the screen"),
    "liveConnected": MessageLookupByLibrary.simpleMessage("Live"),
    "liveConnecting": MessageLookupByLibrary.simpleMessage("Connecting…"),
    "liveControls": MessageLookupByLibrary.simpleMessage("Controls"),
    "liveCurrentItem": MessageLookupByLibrary.simpleMessage("On screen"),
    "liveDisconnected": MessageLookupByLibrary.simpleMessage("Offline"),
    "liveEndSpeaker": MessageLookupByLibrary.simpleMessage("End turn"),
    "liveGiveFloor": MessageLookupByLibrary.simpleMessage("Give the floor"),
    "liveMinusMinute": MessageLookupByLibrary.simpleMessage(
      "Take off a minute",
    ),
    "liveMinutes": m27,
    "liveNextSpeaker": MessageLookupByLibrary.simpleMessage("Next speaker"),
    "liveNoItem": MessageLookupByLibrary.simpleMessage(
      "No agenda item on screen",
    ),
    "liveNoLimit": MessageLookupByLibrary.simpleMessage("No limit"),
    "liveNobodySpeaking": MessageLookupByLibrary.simpleMessage(
      "Nobody has the floor",
    ),
    "liveNow": MessageLookupByLibrary.simpleMessage("Live now"),
    "livePause": MessageLookupByLibrary.simpleMessage("Pause"),
    "livePaused": MessageLookupByLibrary.simpleMessage("Paused"),
    "livePickItem": MessageLookupByLibrary.simpleMessage(
      "Put an item on screen",
    ),
    "livePickItemTitle": MessageLookupByLibrary.simpleMessage("Item on screen"),
    "livePlusMinute": MessageLookupByLibrary.simpleMessage("Add a minute"),
    "liveQueue": m28,
    "liveReconnecting": MessageLookupByLibrary.simpleMessage("Reconnecting…"),
    "liveRemoveFromQueue": MessageLookupByLibrary.simpleMessage(
      "Remove from the queue",
    ),
    "liveRequestSent": MessageLookupByLibrary.simpleMessage(
      "Your request was sent",
    ),
    "liveReset": MessageLookupByLibrary.simpleMessage("Reset"),
    "liveResetDescription": MessageLookupByLibrary.simpleMessage(
      "The time spent so far will be cleared.",
    ),
    "liveResetTitle": MessageLookupByLibrary.simpleMessage(
      "Reset this item\'s timer?",
    ),
    "liveSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "liveSkipHint": MessageLookupByLibrary.simpleMessage(
      "Their turn is passed over and recorded as skipped.",
    ),
    "liveSpeakerLimit": m29,
    "liveSpeakerLimitHint": MessageLookupByLibrary.simpleMessage(
      "Applies to the next speakers.",
    ),
    "liveSpeakerLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Time per speaker",
    ),
    "liveSpeaking": MessageLookupByLibrary.simpleMessage("Speaking"),
    "liveStart": MessageLookupByLibrary.simpleMessage("Start"),
    "liveTapToRetry": MessageLookupByLibrary.simpleMessage(
      "Live updates are off. Tap to reconnect.",
    ),
    "liveUpdates": MessageLookupByLibrary.simpleMessage("Live updates"),
    "liveWithdraw": MessageLookupByLibrary.simpleMessage("Withdraw"),
    "liveWithdrawFor": MessageLookupByLibrary.simpleMessage(
      "Withdraw their request",
    ),
    "liveWithdrawForHint": MessageLookupByLibrary.simpleMessage(
      "As if they withdrew it themselves, for example when they leave.",
    ),
    "liveYourPlace": m30,
    "liveYourTurn": MessageLookupByLibrary.simpleMessage("You have the floor"),
    "location": MessageLookupByLibrary.simpleMessage("Location"),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your account details to access your committees and meetings.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutDescription": MessageLookupByLibrary.simpleMessage(
      "You will need to enter your details again to sign in.",
    ),
    "logoutQuestion": MessageLookupByLibrary.simpleMessage("Log out?"),
    "mail": MessageLookupByLibrary.simpleMessage("Mail"),
    "max": MessageLookupByLibrary.simpleMessage("Max"),
    "meeting": MessageLookupByLibrary.simpleMessage("Meeting"),
    "meetingModeHybrid": MessageLookupByLibrary.simpleMessage(
      "Hybrid (in person and online)",
    ),
    "meetingModeInPerson": MessageLookupByLibrary.simpleMessage("In person"),
    "meetingModeOnline": MessageLookupByLibrary.simpleMessage("Online"),
    "meetingRunningNow": MessageLookupByLibrary.simpleMessage(
      "The meeting is live now",
    ),
    "meetings": MessageLookupByLibrary.simpleMessage("Meetings"),
    "meetingsBehind": MessageLookupByLibrary.simpleMessage("Behind"),
    "meetingsCount": m31,
    "meetingsHeld": MessageLookupByLibrary.simpleMessage("Held"),
    "meetingsMinimum": MessageLookupByLibrary.simpleMessage("Yearly minimum"),
    "meetingsMissing": m32,
    "meetingsOnTrack": MessageLookupByLibrary.simpleMessage("On track"),
    "meetingsScheduledLabel": MessageLookupByLibrary.simpleMessage("Scheduled"),
    "meetingsShort": MessageLookupByLibrary.simpleMessage("Short"),
    "meetingsThisYear": MessageLookupByLibrary.simpleMessage(
      "Meetings this year",
    ),
    "member": MessageLookupByLibrary.simpleMessage("Member"),
    "members": MessageLookupByLibrary.simpleMessage("Members"),
    "membersAtRisk": MessageLookupByLibrary.simpleMessage("Members at risk"),
    "membersCount": m33,
    "middleName": MessageLookupByLibrary.simpleMessage("Middle Name"),
    "min": MessageLookupByLibrary.simpleMessage("Min"),
    "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
    "minutesAnswerBy": m34,
    "minutesAnswersClosed": MessageLookupByLibrary.simpleMessage(
      "The deadline for answering has passed.",
    ),
    "minutesApprovals": MessageLookupByLibrary.simpleMessage(
      "Members\' answers",
    ),
    "minutesApprovedDone": MessageLookupByLibrary.simpleMessage(
      "You approved the minutes",
    ),
    "minutesApprovedOf": m35,
    "minutesChairLast": MessageLookupByLibrary.simpleMessage(
      "The chair approves after the other members.",
    ),
    "minutesChairWaits": MessageLookupByLibrary.simpleMessage(
      "You can approve once the other members have answered. You can reject at any time.",
    ),
    "minutesConfirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "minutesRejectedCount": m36,
    "minutesRejectedDone": MessageLookupByLibrary.simpleMessage(
      "Your rejection was sent",
    ),
    "minutesUnderReview": MessageLookupByLibrary.simpleMessage("Under review"),
    "muteMic": MessageLookupByLibrary.simpleMessage("Mute microphone"),
    "myAttendance": MessageLookupByLibrary.simpleMessage("My attendance"),
    "myComment": MessageLookupByLibrary.simpleMessage("My comment"),
    "myInfo": MessageLookupByLibrary.simpleMessage("My Info"),
    "myLocation": MessageLookupByLibrary.simpleMessage("My Location"),
    "myOrder": MessageLookupByLibrary.simpleMessage("My Orders"),
    "myOrders": MessageLookupByLibrary.simpleMessage("My Orders"),
    "myProposals": m37,
    "myTasks": MessageLookupByLibrary.simpleMessage("My tasks"),
    "name": MessageLookupByLibrary.simpleMessage("name"),
    "nameEmpty": MessageLookupByLibrary.simpleMessage("Name field is required"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "navCommittees": MessageLookupByLibrary.simpleMessage("My committees"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "need11": MessageLookupByLibrary.simpleMessage(
      "The Phone Number Is 11 Digits",
    ),
    "need8": MessageLookupByLibrary.simpleMessage(
      "The Password Is More Than 8 Letters And Numbers",
    ),
    "needLogin": MessageLookupByLibrary.simpleMessage(
      "Please Log In to continue ",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "newPasswordTitle": MessageLookupByLibrary.simpleMessage("New password"),
    "new_arrival": MessageLookupByLibrary.simpleMessage("New Arrival"),
    "new_check_email": MessageLookupByLibrary.simpleMessage(
      "New Check Your Email For\nConfirmation Link",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noAgendaYet": MessageLookupByLibrary.simpleMessage(
      "The agenda hasn\'t been added yet",
    ),
    "noAgendaYetDescription": MessageLookupByLibrary.simpleMessage(
      "Items will appear here once added, and you can comment on each one.",
    ),
    "noCirculations": MessageLookupByLibrary.simpleMessage(
      "No decisions by circulation",
    ),
    "noCirculationsDescription": MessageLookupByLibrary.simpleMessage(
      "Decisions the secretary sends for votes will appear here.",
    ),
    "noCommitteeDescription": MessageLookupByLibrary.simpleMessage(
      "No description is recorded for this committee.",
    ),
    "noCommitteeStatement": MessageLookupByLibrary.simpleMessage(
      "No statement is recorded for this committee.",
    ),
    "noCommitteesDescription": MessageLookupByLibrary.simpleMessage(
      "Your committees will appear here once you are added. Pull down to refresh.",
    ),
    "noComplianceRule": MessageLookupByLibrary.simpleMessage(
      "This committee has no attendance rule.",
    ),
    "noDeadline": MessageLookupByLibrary.simpleMessage("No deadline"),
    "noDelegationCandidates": MessageLookupByLibrary.simpleMessage(
      "There are no other members in this committee.",
    ),
    "noDelegations": MessageLookupByLibrary.simpleMessage("No delegations"),
    "noDelegationsDescription": MessageLookupByLibrary.simpleMessage(
      "Hand your role to another member for a period, for example before travelling.",
    ),
    "noDocumentsYet": MessageLookupByLibrary.simpleMessage("No documents yet"),
    "noDocumentsYetDescription": MessageLookupByLibrary.simpleMessage(
      "Committee documents will appear here once added.",
    ),
    "noGoalsYet": MessageLookupByLibrary.simpleMessage("No goals set yet"),
    "noGoalsYetDescription": MessageLookupByLibrary.simpleMessage(
      "Committee goals and tasks will appear here once added.",
    ),
    "noInternet": MessageLookupByLibrary.simpleMessage(
      "Please check your internet connection",
    ),
    "noMeetingsThisDay": MessageLookupByLibrary.simpleMessage(
      "No meetings on this day",
    ),
    "noMeetingsThisDayHint": MessageLookupByLibrary.simpleMessage(
      "Days with meetings are marked with a purple dot.",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage("No notifications"),
    "noNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Notifications will appear here as they arrive. Pull down to refresh.",
    ),
    "noRecommendations": MessageLookupByLibrary.simpleMessage(
      "No recommendations",
    ),
    "noRecommendationsDescription": MessageLookupByLibrary.simpleMessage(
      "Recommendations raised to or from this committee will show here.",
    ),
    "noSubCommittees": MessageLookupByLibrary.simpleMessage(
      "This committee has no parent or sub-committees.",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("No tasks"),
    "noVoters": MessageLookupByLibrary.simpleMessage("No one chose this"),
    "noVotesForMeeting": MessageLookupByLibrary.simpleMessage(
      "No votes for this meeting",
    ),
    "noVotesForMeetingDescription": MessageLookupByLibrary.simpleMessage(
      "Polls will appear here when opened, and their results once published.",
    ),
    "noVotesPending": MessageLookupByLibrary.simpleMessage(
      "No votes awaiting you",
    ),
    "noWorkload": MessageLookupByLibrary.simpleMessage("No tasks yet"),
    "noWorkloadDescription": MessageLookupByLibrary.simpleMessage(
      "Published tasks assigned in this committee will show here.",
    ),
    "notACirculationVoter": MessageLookupByLibrary.simpleMessage(
      "You are not a voter on this decision.",
    ),
    "notAnsweredYet": MessageLookupByLibrary.simpleMessage("No answer yet"),
    "notConnected": MessageLookupByLibrary.simpleMessage("Not connected"),
    "notLoggedIn": MessageLookupByLibrary.simpleMessage(
      "You are not signed in",
    ),
    "notVotedYet": MessageLookupByLibrary.simpleMessage("Not voted"),
    "notVotedYetCount": m38,
    "notYet": MessageLookupByLibrary.simpleMessage("Not Yet"),
    "noteCannotHear": MessageLookupByLibrary.simpleMessage("I can\'t hear"),
    "noteCannotSee": MessageLookupByLibrary.simpleMessage(
      "I can\'t see the screen",
    ),
    "noteNeedHelp": MessageLookupByLibrary.simpleMessage("I need help"),
    "notification": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "numberOfPeople": MessageLookupByLibrary.simpleMessage("Number of people"),
    "numberPhone": MessageLookupByLibrary.simpleMessage("Number Phone"),
    "offer": MessageLookupByLibrary.simpleMessage("Offer"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "onlineMeeting": MessageLookupByLibrary.simpleMessage("Online meeting"),
    "oops": MessageLookupByLibrary.simpleMessage("Oops!"),
    "openMinutes": MessageLookupByLibrary.simpleMessage("Open the minutes"),
    "or": MessageLookupByLibrary.simpleMessage("or"),
    "order_summary": MessageLookupByLibrary.simpleMessage("Order summary"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otpSentTo": MessageLookupByLibrary.simpleMessage(
      "We sent the code by SMS to",
    ),
    "parentCommittee": MessageLookupByLibrary.simpleMessage("Parent committee"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordEmpty": MessageLookupByLibrary.simpleMessage(
      "Password field is required",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Password does not match",
    ),
    "passwordReset": MessageLookupByLibrary.simpleMessage(
      "Your Password Has\nBeen Reset!",
    ),
    "paymentFailed": MessageLookupByLibrary.simpleMessage("Payment Failed"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
    "payment_summary": MessageLookupByLibrary.simpleMessage("Payment Summary"),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "pendingCount": m39,
    "phoneCall": MessageLookupByLibrary.simpleMessage("Phone call"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "phoneNumberCanNotBeChange": MessageLookupByLibrary.simpleMessage(
      "Phone number cannot be changed",
    ),
    "phoneNumberEmpty": MessageLookupByLibrary.simpleMessage(
      "Phone number field is required",
    ),
    "phoneSms": MessageLookupByLibrary.simpleMessage("Phone SMS"),
    "planned": MessageLookupByLibrary.simpleMessage("Planned"),
    "pleasCreateAccount": MessageLookupByLibrary.simpleMessage(
      "Please create an account",
    ),
    "pleasSetYourAddress": MessageLookupByLibrary.simpleMessage(
      "Pleas Set Your Address",
    ),
    "pointOfOrder": MessageLookupByLibrary.simpleMessage("Point of order"),
    "policy": MessageLookupByLibrary.simpleMessage(
      "Terms of Use and Privacy Policy",
    ),
    "policyJust": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "pollNotOpenYet": MessageLookupByLibrary.simpleMessage("Not open yet"),
    "pollOutcomePassed": MessageLookupByLibrary.simpleMessage("Passed"),
    "pollOutcomeRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "pollOutcomeTied": MessageLookupByLibrary.simpleMessage("Tied"),
    "polls": MessageLookupByLibrary.simpleMessage("Polls"),
    "postponed": MessageLookupByLibrary.simpleMessage("Postponed"),
    "poweredByCoretech": MessageLookupByLibrary.simpleMessage(
      "Powered by CORETECH",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "price": MessageLookupByLibrary.simpleMessage("Price"),
    "processing": MessageLookupByLibrary.simpleMessage("Processing"),
    "product": MessageLookupByLibrary.simpleMessage("Product"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileImage": MessageLookupByLibrary.simpleMessage("Profile Image"),
    "proposalAccepted": MessageLookupByLibrary.simpleMessage(
      "The proposal was accepted",
    ),
    "proposalNoteHint": MessageLookupByLibrary.simpleMessage(
      "Background, why it matters…",
    ),
    "proposalNoteOptional": MessageLookupByLibrary.simpleMessage(
      "Details (optional)",
    ),
    "proposalRejected": MessageLookupByLibrary.simpleMessage(
      "The proposal was rejected",
    ),
    "proposalSent": MessageLookupByLibrary.simpleMessage(
      "Your proposal was sent",
    ),
    "proposalTitle": MessageLookupByLibrary.simpleMessage("Item title"),
    "proposalTitleHint": MessageLookupByLibrary.simpleMessage(
      "What should be discussed?",
    ),
    "proposeItem": MessageLookupByLibrary.simpleMessage("Propose an item"),
    "proposeItemHint": MessageLookupByLibrary.simpleMessage(
      "The secretary reviews it and may add it to the agenda.",
    ),
    "published": MessageLookupByLibrary.simpleMessage("Published"),
    "publishedResults": MessageLookupByLibrary.simpleMessage(
      "Published results",
    ),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "quickMessage": MessageLookupByLibrary.simpleMessage(
      "Quick message to the host",
    ),
    "quorumChairRequired": MessageLookupByLibrary.simpleMessage(
      "The chair has to attend for the quorum to count.",
    ),
    "quorumChairRequiredYou": MessageLookupByLibrary.simpleMessage(
      "Your presence is required for quorum.",
    ),
    "quorumMet": m40,
    "quorumNotMet": m41,
    "quorumPresentOfRequired": m42,
    "quorumProxies": m43,
    "quorumRecordedAt": m44,
    "quorumRuleCount": m45,
    "quorumRulePercent": m46,
    "quorumSplit": m47,
    "quorumStatusMet": MessageLookupByLibrary.simpleMessage("Met"),
    "quorumStatusNotMet": MessageLookupByLibrary.simpleMessage("Not met"),
    "quorumTitle": MessageLookupByLibrary.simpleMessage("Quorum"),
    "raise": MessageLookupByLibrary.simpleMessage("Raise"),
    "raiseRecommendation": MessageLookupByLibrary.simpleMessage(
      "Raise a recommendation",
    ),
    "raisedBy": m48,
    "rated": MessageLookupByLibrary.simpleMessage("Rated"),
    "rePassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "readOnly": MessageLookupByLibrary.simpleMessage("Read only"),
    "ready": MessageLookupByLibrary.simpleMessage("Ready"),
    "readyToDeliver": MessageLookupByLibrary.simpleMessage("Ready To Deliver"),
    "reasonOptional": MessageLookupByLibrary.simpleMessage("Reason (optional)"),
    "receiverPhone": MessageLookupByLibrary.simpleMessage("receiverPhone"),
    "recommendationApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "recommendationBodyHint": MessageLookupByLibrary.simpleMessage(
      "Details (optional)",
    ),
    "recommendationPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "recommendationRaised": MessageLookupByLibrary.simpleMessage(
      "The recommendation was raised",
    ),
    "recommendationRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "recommendationTitleHint": MessageLookupByLibrary.simpleMessage("Title"),
    "recommendationWithdrawn": MessageLookupByLibrary.simpleMessage(
      "Withdrawn",
    ),
    "recommendations": MessageLookupByLibrary.simpleMessage("Recommendations"),
    "recommendationsReceived": MessageLookupByLibrary.simpleMessage(
      "From sub-committees",
    ),
    "recommendationsSent": MessageLookupByLibrary.simpleMessage(
      "Raised by this committee",
    ),
    "recommendationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sub-committees",
    ),
    "region": MessageLookupByLibrary.simpleMessage("Region"),
    "registeredBefore": MessageLookupByLibrary.simpleMessage(
      "Registered Before",
    ),
    "registered_before": MessageLookupByLibrary.simpleMessage(
      "Registered Before",
    ),
    "reject": MessageLookupByLibrary.simpleMessage("Reject"),
    "rejectAbsenceTitle": MessageLookupByLibrary.simpleMessage(
      "Reject this absence request?",
    ),
    "rejectMinutesHint": MessageLookupByLibrary.simpleMessage(
      "What should be corrected?",
    ),
    "rejectMinutesTitle": MessageLookupByLibrary.simpleMessage(
      "Reject the minutes?",
    ),
    "rejectProposalHint": MessageLookupByLibrary.simpleMessage(
      "Tell the member why",
    ),
    "rejectProposalTitle": MessageLookupByLibrary.simpleMessage(
      "Reject this proposal?",
    ),
    "rejectRecommendationTitle": MessageLookupByLibrary.simpleMessage(
      "Reject this recommendation?",
    ),
    "rejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "rejectedState": MessageLookupByLibrary.simpleMessage("Rejected"),
    "rejectionReason": MessageLookupByLibrary.simpleMessage("Reason"),
    "related_products": MessageLookupByLibrary.simpleMessage(
      "Related Products",
    ),
    "rememberMe": MessageLookupByLibrary.simpleMessage("Remember Me"),
    "rememberPassword": MessageLookupByLibrary.simpleMessage(
      "Remember Password",
    ),
    "removeAttachment": MessageLookupByLibrary.simpleMessage("Remove the file"),
    "requestAbsence": MessageLookupByLibrary.simpleMessage(
      "Requests for absence",
    ),
    "requestSent": MessageLookupByLibrary.simpleMessage(
      "Request sent to the host",
    ),
    "requestService": MessageLookupByLibrary.simpleMessage("Request a service"),
    "requestServiceHint": MessageLookupByLibrary.simpleMessage(
      "Facilities will confirm or reply here.",
    ),
    "requestToSpeak": MessageLookupByLibrary.simpleMessage("Request to speak"),
    "resend": MessageLookupByLibrary.simpleMessage("Resend"),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend code"),
    "reservationSent": MessageLookupByLibrary.simpleMessage(
      "Your reservation was recorded",
    ),
    "reservationWithdrawn": MessageLookupByLibrary.simpleMessage(
      "Your reservation was withdrawn",
    ),
    "reservationsCount": m49,
    "reserveHint": MessageLookupByLibrary.simpleMessage("Why do you reserve?"),
    "reserveOnDecision": MessageLookupByLibrary.simpleMessage("Reserve"),
    "reserveTitle": MessageLookupByLibrary.simpleMessage(
      "Reserve on this decision?",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "respondedBy": m50,
    "responseNoteHint": MessageLookupByLibrary.simpleMessage(
      "A note for the sub-committee (optional)",
    ),
    "responseSent": MessageLookupByLibrary.simpleMessage(
      "Your answer was sent",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Try again"),
    "returned": MessageLookupByLibrary.simpleMessage("Returned"),
    "reviewOrder": MessageLookupByLibrary.simpleMessage("Review Order"),
    "reviewProposals": MessageLookupByLibrary.simpleMessage(
      "Members\' proposals",
    ),
    "reviewProposalsHint": MessageLookupByLibrary.simpleMessage(
      "Reject with a reason, or accept once the item is on the agenda.",
    ),
    "reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
    "revokeDelegation": MessageLookupByLibrary.simpleMessage("Revoke"),
    "revokeDelegationFromMe": m51,
    "revokeDelegationTitle": MessageLookupByLibrary.simpleMessage(
      "Revoke this delegation?",
    ),
    "revokeDelegationToMe": MessageLookupByLibrary.simpleMessage(
      "You will stop acting in this role right away.",
    ),
    "running": MessageLookupByLibrary.simpleMessage("Running"),
    "saveChange": MessageLookupByLibrary.simpleMessage("save change"),
    "save_for_later": MessageLookupByLibrary.simpleMessage("Save For Later?"),
    "scheduled": MessageLookupByLibrary.simpleMessage("Scheduled"),
    "scopeDecisions": MessageLookupByLibrary.simpleMessage("Decisions"),
    "scopeMeetings": MessageLookupByLibrary.simpleMessage("Meetings"),
    "scopeMembers": MessageLookupByLibrary.simpleMessage("Members"),
    "scopeMinutes": MessageLookupByLibrary.simpleMessage("Minutes"),
    "scopeReports": MessageLookupByLibrary.simpleMessage("Reports"),
    "scopeRules": MessageLookupByLibrary.simpleMessage("Rules"),
    "scopeTasks": MessageLookupByLibrary.simpleMessage("Tasks"),
    "screenShareNotSupported": MessageLookupByLibrary.simpleMessage(
      "Screen sharing isn\'t supported on mobile web",
    ),
    "screenSharingText": MessageLookupByLibrary.simpleMessage(
      "MMS is sharing the screen.",
    ),
    "screenSharingTitle": MessageLookupByLibrary.simpleMessage(
      "Screen sharing",
    ),
    "searchResult": MessageLookupByLibrary.simpleMessage("Search Result"),
    "search_In_All": MessageLookupByLibrary.simpleMessage("Search In All"),
    "seconds": MessageLookupByLibrary.simpleMessage("seconds"),
    "secretary": MessageLookupByLibrary.simpleMessage("Secretary"),
    "see_all": MessageLookupByLibrary.simpleMessage("See All"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selectFromMap": MessageLookupByLibrary.simpleMessage("From Map"),
    "selectGovernor": MessageLookupByLibrary.simpleMessage("Select Governor"),
    "sendProposal": MessageLookupByLibrary.simpleMessage("Send proposal"),
    "sendRequest": MessageLookupByLibrary.simpleMessage("Send request"),
    "sendSuggestion": MessageLookupByLibrary.simpleMessage("Send suggestion"),
    "serverError": MessageLookupByLibrary.simpleMessage("Server error"),
    "serviceCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "serviceConfirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "serviceDelivered": MessageLookupByLibrary.simpleMessage("Delivered"),
    "serviceDetailsHint": MessageLookupByLibrary.simpleMessage(
      "What do you need?",
    ),
    "serviceEquipment": MessageLookupByLibrary.simpleMessage("Equipment"),
    "serviceHospitality": MessageLookupByLibrary.simpleMessage("Hospitality"),
    "serviceOther": MessageLookupByLibrary.simpleMessage("Other"),
    "serviceRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "serviceRequested": MessageLookupByLibrary.simpleMessage(
      "The request was sent",
    ),
    "serviceRequestedState": MessageLookupByLibrary.simpleMessage("Requested"),
    "setReview": MessageLookupByLibrary.simpleMessage(
      "Please Send Your Rating For The Product",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "sgnIn": MessageLookupByLibrary.simpleMessage("Sign In."),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "shareScreen": MessageLookupByLibrary.simpleMessage("Share screen"),
    "shipping": MessageLookupByLibrary.simpleMessage("Shipping"),
    "showLess": MessageLookupByLibrary.simpleMessage("Show less"),
    "showMore": MessageLookupByLibrary.simpleMessage("Show more"),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show"),
    "showSubItems": m52,
    "signInToContinue": MessageLookupByLibrary.simpleMessage(
      "يجب عليك إضافة بياناتك الخاصة لتسهيل التواصل معك",
    ),
    "signInWithSocial": MessageLookupByLibrary.simpleMessage(
      "Sign In With Social Networks:",
    ),
    "signInWithSocialNetworks": MessageLookupByLibrary.simpleMessage(
      "Sign In With Social Networks",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "sizes": MessageLookupByLibrary.simpleMessage("Sizes"),
    "startDate": MessageLookupByLibrary.simpleMessage("Start date"),
    "startedAt": MessageLookupByLibrary.simpleMessage("Started at"),
    "statement": MessageLookupByLibrary.simpleMessage("Statement"),
    "statusClosed": MessageLookupByLibrary.simpleMessage("Closed"),
    "statusOpen": MessageLookupByLibrary.simpleMessage("Open"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "stopShare": MessageLookupByLibrary.simpleMessage("Stop sharing"),
    "subCategories": MessageLookupByLibrary.simpleMessage("Sub Categories"),
    "subCommitteesCount": m53,
    "subTitleDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Delete all your data ",
    ),
    "subTitleNotification": MessageLookupByLibrary.simpleMessage(
      "All Notifications",
    ),
    "subTitlePassword": MessageLookupByLibrary.simpleMessage(
      "To change password",
    ),
    "subTitlePolicy": MessageLookupByLibrary.simpleMessage(
      "Privacy policy and conditions ",
    ),
    "subTitleSupport": MessageLookupByLibrary.simpleMessage("Our support "),
    "submitVote": MessageLookupByLibrary.simpleMessage("Submit vote"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "successfully": MessageLookupByLibrary.simpleMessage("Successfully."),
    "suggested": MessageLookupByLibrary.simpleMessage("Suggested"),
    "suggestedFor": MessageLookupByLibrary.simpleMessage("Suggested guest for"),
    "suggestedGuest": MessageLookupByLibrary.simpleMessage("Suggested Guest"),
    "suggestedGuests": MessageLookupByLibrary.simpleMessage("Suggested Guests"),
    "suggestingGuest": MessageLookupByLibrary.simpleMessage("Suggesting Guest"),
    "summaries": MessageLookupByLibrary.simpleMessage("Summaries"),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "suspended": MessageLookupByLibrary.simpleMessage("Suspended"),
    "tallySoFar": MessageLookupByLibrary.simpleMessage("Tally so far"),
    "taskCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "taskCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "taskInProgress": MessageLookupByLibrary.simpleMessage("In progress"),
    "taskOnHold": MessageLookupByLibrary.simpleMessage("On hold"),
    "tasks": MessageLookupByLibrary.simpleMessage("tasks"),
    "tasksCount": m54,
    "tasksOf": m55,
    "teachingStaff": MessageLookupByLibrary.simpleMessage("Teaching staff"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms And Conditions",
    ),
    "toCommittee": m56,
    "toLabel": MessageLookupByLibrary.simpleMessage("To"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "trackingOrder": MessageLookupByLibrary.simpleMessage("Tracking Order"),
    "unFollow": MessageLookupByLibrary.simpleMessage("Un Follow"),
    "unmuteMic": MessageLookupByLibrary.simpleMessage("Unmute microphone"),
    "unpublished": MessageLookupByLibrary.simpleMessage("UnPublished"),
    "update": MessageLookupByLibrary.simpleMessage("update"),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Use Current Location",
    ),
    "userName": MessageLookupByLibrary.simpleMessage("Username"),
    "verify": MessageLookupByLibrary.simpleMessage("verify"),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "viewProfile": MessageLookupByLibrary.simpleMessage("View profile"),
    "vote": MessageLookupByLibrary.simpleMessage("Vote"),
    "voteReason": MessageLookupByLibrary.simpleMessage("Reason"),
    "voteReasonHint": MessageLookupByLibrary.simpleMessage(
      "Why do you object or abstain?",
    ),
    "voteRecorded": MessageLookupByLibrary.simpleMessage(
      "Your vote is recorded",
    ),
    "voteUnit": MessageLookupByLibrary.simpleMessage("votes"),
    "voters": MessageLookupByLibrary.simpleMessage("Voters"),
    "votes": MessageLookupByLibrary.simpleMessage("Votes"),
    "votesCount": m57,
    "votesPending": m58,
    "votesTitle": MessageLookupByLibrary.simpleMessage("Votes"),
    "votingEnded": MessageLookupByLibrary.simpleMessage("Voting ended"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
    "whoVoted": MessageLookupByLibrary.simpleMessage("Who voted"),
    "wishList": MessageLookupByLibrary.simpleMessage("WishList"),
    "wishlist": MessageLookupByLibrary.simpleMessage("Wishlist"),
    "withdraw": MessageLookupByLibrary.simpleMessage("Withdraw"),
    "withdrawInterest": MessageLookupByLibrary.simpleMessage(
      "Withdraw disclosure",
    ),
    "withdrawInterestDescription": MessageLookupByLibrary.simpleMessage(
      "You will count again in this item\'s quorum and voting.",
    ),
    "withdrawInterestTitle": MessageLookupByLibrary.simpleMessage(
      "Withdraw your disclosure?",
    ),
    "withdrawProposal": MessageLookupByLibrary.simpleMessage("Withdraw"),
    "withdrawProposalTitle": MessageLookupByLibrary.simpleMessage(
      "Withdraw this proposal?",
    ),
    "withdrawRecommendationTitle": MessageLookupByLibrary.simpleMessage(
      "Withdraw this recommendation?",
    ),
    "withdrawReservation": MessageLookupByLibrary.simpleMessage("Withdraw"),
    "withdrawReservationTitle": MessageLookupByLibrary.simpleMessage(
      "Withdraw your reservation?",
    ),
    "withdrawSuggestionConfirm": MessageLookupByLibrary.simpleMessage(
      "Withdraw this guest suggestion?",
    ),
    "workload": MessageLookupByLibrary.simpleMessage("Workload"),
    "workloadDoneCount": m59,
    "workloadDueSoonCount": m60,
    "workloadOpen": MessageLookupByLibrary.simpleMessage("Open"),
    "workloadOpenCount": m61,
    "workloadOverdue": MessageLookupByLibrary.simpleMessage("Overdue"),
    "workloadOverdueCount": m62,
    "workloadSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tasks per member",
    ),
    "workloadUnassigned": MessageLookupByLibrary.simpleMessage("Unassigned"),
    "workloadUnavailable": MessageLookupByLibrary.simpleMessage(
      "The workload isn\'t available",
    ),
    "writeYourComment": MessageLookupByLibrary.simpleMessage(
      "Write your comment here…",
    ),
    "wrongEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "wrongPhone": MessageLookupByLibrary.simpleMessage("Invalid phone number"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "you": MessageLookupByLibrary.simpleMessage("You"),
    "youApproved": MessageLookupByLibrary.simpleMessage("You approved"),
    "youRejected": MessageLookupByLibrary.simpleMessage("You rejected"),
    "youVotedCanChange": m63,
    "yourAddress": MessageLookupByLibrary.simpleMessage("Your Address"),
    "yourAnswer": MessageLookupByLibrary.simpleMessage("Your answer"),
    "yourComment": MessageLookupByLibrary.simpleMessage("Your comment"),
    "yourConnectionHasBeenSuspendedByTheAdminButYou":
        MessageLookupByLibrary.simpleMessage(
          "Your connection has been suspended by the admin, but you are still connected. Please wait until you are allowed to resume.",
        ),
    "yourEmail": MessageLookupByLibrary.simpleMessage("Your Email"),
    "yourLocation": MessageLookupByLibrary.simpleMessage("Your Location"),
    "yourMembership": MessageLookupByLibrary.simpleMessage("Your membership"),
    "yourName": MessageLookupByLibrary.simpleMessage("Your Name"),
    "yourOrder": MessageLookupByLibrary.simpleMessage("Your Order"),
    "yourPhone": MessageLookupByLibrary.simpleMessage("Your Phone"),
    "yourReservation": MessageLookupByLibrary.simpleMessage("Your reservation"),
    "yourVote": MessageLookupByLibrary.simpleMessage("Your vote"),
    "yourVoteIs": m64,
  };
}
