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

  static String m0(count) =>
      "${Intl.plural(count, zero: 'No committees', one: '1 committee', other: '${count} committees')}";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'No discussions', one: '1 discussion', other: '${count} discussions')}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'No documents', one: '1 document', other: '${count} documents')}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'No goals', one: '1 goal', other: '${count} goals')}";

  static String m4(count) => "Hide sub-items (${count})";

  static String m5(count) =>
      "${Intl.plural(count, zero: 'No items', one: '1 item', other: '${count} items')}";

  static String m6(count) =>
      "${Intl.plural(count, zero: 'No meetings', one: '1 meeting', other: '${count} meetings')}";

  static String m7(count) =>
      "${Intl.plural(count, zero: 'No members', one: '1 member', other: '${count} members')}";

  static String m8(count) => "Show sub-items (${count})";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'No tasks', one: '1 task', other: '${count} tasks')}";

  static String m10(count) => "${count} awaiting your vote";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
    "accountCreated": MessageLookupByLibrary.simpleMessage("Account Created!"),
    "addComment": MessageLookupByLibrary.simpleMessage("Add comment"),
    "addCorectData": MessageLookupByLibrary.simpleMessage(
      "يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء",
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
    "agendas": MessageLookupByLibrary.simpleMessage("Agendas"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Already Have An Account?",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Apply"),
    "apply_filters": MessageLookupByLibrary.simpleMessage("Apply filters"),
    "approved": MessageLookupByLibrary.simpleMessage("Approved"),
    "ar": MessageLookupByLibrary.simpleMessage("Arabic"),
    "archived": MessageLookupByLibrary.simpleMessage("Published"),
    "at": MessageLookupByLibrary.simpleMessage("At"),
    "attendanceNotRecorded": MessageLookupByLibrary.simpleMessage(
      "Attendance not recorded",
    ),
    "attendanceRecorded": MessageLookupByLibrary.simpleMessage(
      "Attendance recorded",
    ),
    "attendees": MessageLookupByLibrary.simpleMessage("Attendees"),
    "attendeesAndGuests": MessageLookupByLibrary.simpleMessage(
      "Attendees & guests",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backToLogin": MessageLookupByLibrary.simpleMessage("Back to login"),
    "birthday": MessageLookupByLibrary.simpleMessage("birthday"),
    "build": MessageLookupByLibrary.simpleMessage("Build"),
    "buildNumber": MessageLookupByLibrary.simpleMessage("Build Number"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
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
    "choosing": MessageLookupByLibrary.simpleMessage("Choosing"),
    "city": MessageLookupByLibrary.simpleMessage("City"),
    "clickToUpdate": MessageLookupByLibrary.simpleMessage("Click To Update"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "codeSentToEmail": MessageLookupByLibrary.simpleMessage(
      "Confirmation code sent to email: ",
    ),
    "code_invalid": MessageLookupByLibrary.simpleMessage(
      "This Code Is Invalid CODE",
    ),
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
    "committeesCount": m0,
    "company": MessageLookupByLibrary.simpleMessage("Company"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
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
    "discussionsCount": m1,
    "doNotHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t Have An Account?",
    ),
    "documents": MessageLookupByLibrary.simpleMessage("Documents"),
    "documentsCount": m2,
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
    "dueDate": MessageLookupByLibrary.simpleMessage("Due date"),
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
    "enterOTP": MessageLookupByLibrary.simpleMessage(
      "Enter Your OTP Code Here.",
    ),
    "enter_new_password_and_confirm": MessageLookupByLibrary.simpleMessage(
      "Enter New Password And Confirm.",
    ),
    "estimatedFor": MessageLookupByLibrary.simpleMessage("Estimated For"),
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
    "fromLabel": MessageLookupByLibrary.simpleMessage("From"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "goals": MessageLookupByLibrary.simpleMessage("Goals"),
    "goalsCount": m3,
    "governor": MessageLookupByLibrary.simpleMessage("governor"),
    "guest": MessageLookupByLibrary.simpleMessage("Guest"),
    "guests": MessageLookupByLibrary.simpleMessage("Guests"),
    "haveBeenCreated": MessageLookupByLibrary.simpleMessage(
      "Your Account Had Been Created",
    ),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "helperPhoneText": MessageLookupByLibrary.simpleMessage(
      "start with 07 and 11 digit",
    ),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Hide"),
    "hideSubItems": m4,
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "homeAddress": MessageLookupByLibrary.simpleMessage("Home Address"),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "iAmNotCurrentlyAMemberOfAnyCommittees":
        MessageLookupByLibrary.simpleMessage(
          "I am not currently a member of any committees.",
        ),
    "identityImage": MessageLookupByLibrary.simpleMessage("Identity Image"),
    "isSuccess": MessageLookupByLibrary.simpleMessage("Success!"),
    "is_required": MessageLookupByLibrary.simpleMessage("Required"),
    "itemsCount": m5,
    "ku": MessageLookupByLibrary.simpleMessage("Kurdish"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastName": MessageLookupByLibrary.simpleMessage("Last name"),
    "lesson": MessageLookupByLibrary.simpleMessage("Lesson"),
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
    "meetings": MessageLookupByLibrary.simpleMessage("Meetings"),
    "meetingsCount": m6,
    "member": MessageLookupByLibrary.simpleMessage("Member"),
    "members": MessageLookupByLibrary.simpleMessage("Members"),
    "membersCount": m7,
    "middleName": MessageLookupByLibrary.simpleMessage("Middle Name"),
    "min": MessageLookupByLibrary.simpleMessage("Min"),
    "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
    "myComment": MessageLookupByLibrary.simpleMessage("My comment"),
    "myInfo": MessageLookupByLibrary.simpleMessage("My Info"),
    "myLocation": MessageLookupByLibrary.simpleMessage("My Location"),
    "myOrder": MessageLookupByLibrary.simpleMessage("My Orders"),
    "myOrders": MessageLookupByLibrary.simpleMessage("My Orders"),
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
    "noCommitteeDescription": MessageLookupByLibrary.simpleMessage(
      "No description is recorded for this committee.",
    ),
    "noCommitteeStatement": MessageLookupByLibrary.simpleMessage(
      "No statement is recorded for this committee.",
    ),
    "noCommitteesDescription": MessageLookupByLibrary.simpleMessage(
      "Your committees will appear here once you are added. Pull down to refresh.",
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
    "noVotesPending": MessageLookupByLibrary.simpleMessage(
      "No votes awaiting you",
    ),
    "notYet": MessageLookupByLibrary.simpleMessage("Not Yet"),
    "notification": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "numberPhone": MessageLookupByLibrary.simpleMessage("Number Phone"),
    "offer": MessageLookupByLibrary.simpleMessage("Offer"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "oops": MessageLookupByLibrary.simpleMessage("Oops!"),
    "order_summary": MessageLookupByLibrary.simpleMessage("Order summary"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otpSentTo": MessageLookupByLibrary.simpleMessage(
      "We sent the code by SMS to",
    ),
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
    "policy": MessageLookupByLibrary.simpleMessage(
      "Terms of Use and Privacy Policy",
    ),
    "policyJust": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
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
    "published": MessageLookupByLibrary.simpleMessage("Published"),
    "rated": MessageLookupByLibrary.simpleMessage("Rated"),
    "rePassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "ready": MessageLookupByLibrary.simpleMessage("Ready"),
    "readyToDeliver": MessageLookupByLibrary.simpleMessage("Ready To Deliver"),
    "receiverPhone": MessageLookupByLibrary.simpleMessage("receiverPhone"),
    "region": MessageLookupByLibrary.simpleMessage("Region"),
    "registeredBefore": MessageLookupByLibrary.simpleMessage(
      "Registered Before",
    ),
    "registered_before": MessageLookupByLibrary.simpleMessage(
      "Registered Before",
    ),
    "rejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "related_products": MessageLookupByLibrary.simpleMessage(
      "Related Products",
    ),
    "rememberMe": MessageLookupByLibrary.simpleMessage("Remember Me"),
    "rememberPassword": MessageLookupByLibrary.simpleMessage(
      "Remember Password",
    ),
    "requestAbsence": MessageLookupByLibrary.simpleMessage(
      "Requests for absence",
    ),
    "resend": MessageLookupByLibrary.simpleMessage("Resend"),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend code"),
    "reset_password": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "returned": MessageLookupByLibrary.simpleMessage("Returned"),
    "reviewOrder": MessageLookupByLibrary.simpleMessage("Review Order"),
    "reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
    "running": MessageLookupByLibrary.simpleMessage("Running"),
    "saveChange": MessageLookupByLibrary.simpleMessage("save change"),
    "save_for_later": MessageLookupByLibrary.simpleMessage("Save For Later?"),
    "scheduled": MessageLookupByLibrary.simpleMessage("Scheduled"),
    "searchResult": MessageLookupByLibrary.simpleMessage("Search Result"),
    "search_In_All": MessageLookupByLibrary.simpleMessage("Search In All"),
    "seconds": MessageLookupByLibrary.simpleMessage("seconds"),
    "secretary": MessageLookupByLibrary.simpleMessage("Secretary"),
    "see_all": MessageLookupByLibrary.simpleMessage("See All"),
    "selectFromMap": MessageLookupByLibrary.simpleMessage("From Map"),
    "selectGovernor": MessageLookupByLibrary.simpleMessage("Select Governor"),
    "sendSuggestion": MessageLookupByLibrary.simpleMessage("Send suggestion"),
    "setReview": MessageLookupByLibrary.simpleMessage(
      "Please Send Your Rating For The Product",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "sgnIn": MessageLookupByLibrary.simpleMessage("Sign In."),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "shipping": MessageLookupByLibrary.simpleMessage("Shipping"),
    "showLess": MessageLookupByLibrary.simpleMessage("Show less"),
    "showMore": MessageLookupByLibrary.simpleMessage("Show more"),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show"),
    "showSubItems": m8,
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
    "statement": MessageLookupByLibrary.simpleMessage("Statement"),
    "statusClosed": MessageLookupByLibrary.simpleMessage("Closed"),
    "statusOpen": MessageLookupByLibrary.simpleMessage("Open"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "subCategories": MessageLookupByLibrary.simpleMessage("Sub Categories"),
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
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "successfully": MessageLookupByLibrary.simpleMessage("Successfully."),
    "suggested": MessageLookupByLibrary.simpleMessage("Suggested"),
    "suggestedFor": MessageLookupByLibrary.simpleMessage("Suggested guest for"),
    "suggestedGuest": MessageLookupByLibrary.simpleMessage("Suggested Guest"),
    "suggestedGuests": MessageLookupByLibrary.simpleMessage("Suggested Guests"),
    "suggestingGuest": MessageLookupByLibrary.simpleMessage("Suggesting Guest"),
    "summaries": MessageLookupByLibrary.simpleMessage("Summaries"),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "tasks": MessageLookupByLibrary.simpleMessage("tasks"),
    "tasksCount": m9,
    "teachingStaff": MessageLookupByLibrary.simpleMessage("Teaching staff"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms And Conditions",
    ),
    "toLabel": MessageLookupByLibrary.simpleMessage("To"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "trackingOrder": MessageLookupByLibrary.simpleMessage("Tracking Order"),
    "unFollow": MessageLookupByLibrary.simpleMessage("Un Follow"),
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
    "voters": MessageLookupByLibrary.simpleMessage("Voters"),
    "votes": MessageLookupByLibrary.simpleMessage("Votes"),
    "votesPending": m10,
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
    "wishList": MessageLookupByLibrary.simpleMessage("WishList"),
    "wishlist": MessageLookupByLibrary.simpleMessage("Wishlist"),
    "writeYourComment": MessageLookupByLibrary.simpleMessage(
      "Write your comment here…",
    ),
    "wrongEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "wrongPhone": MessageLookupByLibrary.simpleMessage("Invalid phone number"),
    "you": MessageLookupByLibrary.simpleMessage("You"),
    "yourAddress": MessageLookupByLibrary.simpleMessage("Your Address"),
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
  };
}
