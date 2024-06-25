// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Invalid email`
  String get wrongEmail {
    return Intl.message(
      'Invalid email',
      name: 'wrongEmail',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Choosing`
  String get choosing {
    return Intl.message(
      'Choosing',
      name: 'choosing',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Educational Grade`
  String get educationalGrade {
    return Intl.message(
      'Educational Grade',
      name: 'educationalGrade',
      desc: '',
      args: [],
    );
  }

  /// `Mail`
  String get mail {
    return Intl.message(
      'Mail',
      name: 'mail',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get fav {
    return Intl.message(
      'Favorites',
      name: 'fav',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrder {
    return Intl.message(
      'My Orders',
      name: 'myOrder',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please create an account`
  String get pleasCreateAccount {
    return Intl.message(
      'Please create an account',
      name: 'pleasCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Home Address`
  String get homeAddress {
    return Intl.message(
      'Home Address',
      name: 'homeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get rePassword {
    return Intl.message(
      'Confirm Password',
      name: 'rePassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get noInternet {
    return Intl.message(
      'Please check your internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Name field is required`
  String get nameEmpty {
    return Intl.message(
      'Name field is required',
      name: 'nameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Phone number field is required`
  String get phoneNumberEmpty {
    return Intl.message(
      'Phone number field is required',
      name: 'phoneNumberEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email field is required`
  String get emailEmpty {
    return Intl.message(
      'Email field is required',
      name: 'emailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password field is required`
  String get passwordEmpty {
    return Intl.message(
      'Password field is required',
      name: 'passwordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueTo {
    return Intl.message(
      'Continue',
      name: 'continueTo',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirmation Code`
  String get confirmCode {
    return Intl.message(
      'Enter Confirmation Code',
      name: 'confirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation code sent to email: `
  String get codeSentToEmail {
    return Intl.message(
      'Confirmation code sent to email: ',
      name: 'codeSentToEmail',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use and Privacy Policy`
  String get policy {
    return Intl.message(
      'Terms of Use and Privacy Policy',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get policyJust {
    return Intl.message(
      'Privacy Policy',
      name: 'policyJust',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact {
    return Intl.message(
      'Contact Us',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Change Name`
  String get changeName {
    return Intl.message(
      'Change Name',
      name: 'changeName',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get changePhone {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhone',
      desc: '',
      args: [],
    );
  }

  /// `Change Address`
  String get changeAddress {
    return Intl.message(
      'Change Address',
      name: 'changeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePass {
    return Intl.message(
      'Change Password',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }

  /// `Phone number cannot be changed`
  String get phoneNumberCanNotBeChange {
    return Intl.message(
      'Phone number cannot be changed',
      name: 'phoneNumberCanNotBeChange',
      desc: '',
      args: [],
    );
  }

  /// `Continue Sign Up`
  String get continueSignUp {
    return Intl.message(
      'Continue Sign Up',
      name: 'continueSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get wrongPhone {
    return Intl.message(
      'Invalid phone number',
      name: 'wrongPhone',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك إضافة بياناتك الخاصة لتسهيل التواصل معك`
  String get signInToContinue {
    return Intl.message(
      'يجب عليك إضافة بياناتك الخاصة لتسهيل التواصل معك',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have An Account?`
  String get doNotHaveAnAccount {
    return Intl.message(
      'Don\'t Have An Account?',
      name: 'doNotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In With Social Networks:`
  String get signInWithSocial {
    return Intl.message(
      'Sign In With Social Networks:',
      name: 'signInWithSocial',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get createNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء`
  String get addCorectData {
    return Intl.message(
      'يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء',
      name: 'addCorectData',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `birthday`
  String get birthday {
    return Intl.message(
      'birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `The Phone Number Is 11 Digits`
  String get need11 {
    return Intl.message(
      'The Phone Number Is 11 Digits',
      name: 'need11',
      desc: '',
      args: [],
    );
  }

  /// `The Password Is More Than 8 Letters And Numbers`
  String get need8 {
    return Intl.message(
      'The Password Is More Than 8 Letters And Numbers',
      name: 'need8',
      desc: '',
      args: [],
    );
  }

  /// `confirm password`
  String get confirmPassword {
    return Intl.message(
      'confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already Have An Account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already Have An Account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In.`
  String get sgnIn {
    return Intl.message(
      'Sign In.',
      name: 'sgnIn',
      desc: '',
      args: [],
    );
  }

  /// `Please Choose How You Would Like To Send The Verification Code`
  String get confirmMethod {
    return Intl.message(
      'Please Choose How You Would Like To Send The Verification Code',
      name: 'confirmMethod',
      desc: '',
      args: [],
    );
  }

  /// `Phone Call`
  String get phoneCall {
    return Intl.message(
      'Phone Call',
      name: 'phoneCall',
      desc: '',
      args: [],
    );
  }

  /// `Phone SMS`
  String get phoneSms {
    return Intl.message(
      'Phone SMS',
      name: 'phoneSms',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your OTP Code Here.`
  String get enterOTP {
    return Intl.message(
      'Enter Your OTP Code Here.',
      name: 'enterOTP',
      desc: '',
      args: [],
    );
  }

  /// `Didn't Receive The OTP?`
  String get didNotReceiveOTP {
    return Intl.message(
      'Didn\'t Receive The OTP?',
      name: 'didNotReceiveOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `verify`
  String get verify {
    return Intl.message(
      'verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Account Created!`
  String get accountCreated {
    return Intl.message(
      'Account Created!',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Your Account Had Been Created`
  String get haveBeenCreated {
    return Intl.message(
      'Your Account Had Been Created',
      name: 'haveBeenCreated',
      desc: '',
      args: [],
    );
  }

  /// `Successfully.`
  String get successfully {
    return Intl.message(
      'Successfully.',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Number Phone`
  String get numberPhone {
    return Intl.message(
      'Number Phone',
      name: 'numberPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your Password Has\nBeen Reset!`
  String get passwordReset {
    return Intl.message(
      'Your Password Has\nBeen Reset!',
      name: 'passwordReset',
      desc: '',
      args: [],
    );
  }

  /// `save change`
  String get saveChange {
    return Intl.message(
      'save change',
      name: 'saveChange',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get yourAddress {
    return Intl.message(
      'Your Address',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone`
  String get yourPhone {
    return Intl.message(
      'Your Phone',
      name: 'yourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get yourEmail {
    return Intl.message(
      'Your Email',
      name: 'yourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `first name`
  String get firstName {
    return Intl.message(
      'first name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Use Current Location`
  String get useCurrentLocation {
    return Intl.message(
      'Use Current Location',
      name: 'useCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Registered Before`
  String get registeredBefore {
    return Intl.message(
      'Registered Before',
      name: 'registeredBefore',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get changeEmail {
    return Intl.message(
      'Change Email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `My Info`
  String get myInfo {
    return Intl.message(
      'My Info',
      name: 'myInfo',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `WishList`
  String get wishList {
    return Intl.message(
      'WishList',
      name: 'wishList',
      desc: '',
      args: [],
    );
  }

  /// `F.A.q`
  String get faq {
    return Intl.message(
      'F.A.q',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms And Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Done resend code`
  String get done_resend_code {
    return Intl.message(
      'Done resend code',
      name: 'done_resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Search In All`
  String get search_In_All {
    return Intl.message(
      'Search In All',
      name: 'search_In_All',
      desc: '',
      args: [],
    );
  }

  /// `Flash Deal`
  String get flash_deal {
    return Intl.message(
      'Flash Deal',
      name: 'flash_deal',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message(
      'See All',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get offer {
    return Intl.message(
      'Offer',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get min {
    return Intl.message(
      'Min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Sizes`
  String get sizes {
    return Intl.message(
      'Sizes',
      name: 'sizes',
      desc: '',
      args: [],
    );
  }

  /// `Registered Before`
  String get registered_before {
    return Intl.message(
      'Registered Before',
      name: 'registered_before',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get max {
    return Intl.message(
      'Max',
      name: 'max',
      desc: '',
      args: [],
    );
  }

  /// `Apply filters`
  String get apply_filters {
    return Intl.message(
      'Apply filters',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Colors`
  String get colors {
    return Intl.message(
      'Colors',
      name: 'colors',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `New Check Your Email For\nConfirmation Link`
  String get new_check_email {
    return Intl.message(
      'New Check Your Email For\nConfirmation Link',
      name: 'new_check_email',
      desc: '',
      args: [],
    );
  }

  /// `Expiration`
  String get expiration {
    return Intl.message(
      'Expiration',
      name: 'expiration',
      desc: '',
      args: [],
    );
  }

  /// `Save For Later?`
  String get save_for_later {
    return Intl.message(
      'Save For Later?',
      name: 'save_for_later',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Address`
  String get confirm_address {
    return Intl.message(
      'Confirm Address',
      name: 'confirm_address',
      desc: '',
      args: [],
    );
  }

  /// `Cvc`
  String get cvc {
    return Intl.message(
      'Cvc',
      name: 'cvc',
      desc: '',
      args: [],
    );
  }

  /// `Card Name`
  String get card_name {
    return Intl.message(
      'Card Name',
      name: 'card_name',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get card_number {
    return Intl.message(
      'Card Number',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `Payment Summary`
  String get payment_summary {
    return Intl.message(
      'Payment Summary',
      name: 'payment_summary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Additional service`
  String get additional_service {
    return Intl.message(
      'Additional service',
      name: 'additional_service',
      desc: '',
      args: [],
    );
  }

  /// `Order summary`
  String get order_summary {
    return Intl.message(
      'Order summary',
      name: 'order_summary',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Code`
  String get coupon_code {
    return Intl.message(
      'Coupon Code',
      name: 'coupon_code',
      desc: '',
      args: [],
    );
  }

  /// `This Code Is Invalid CODE`
  String get code_invalid {
    return Intl.message(
      'This Code Is Invalid CODE',
      name: 'code_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Related Products`
  String get related_products {
    return Intl.message(
      'Related Products',
      name: 'related_products',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get add_to_cart {
    return Intl.message(
      'Add To Cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `New Arrival`
  String get new_arrival {
    return Intl.message(
      'New Arrival',
      name: 'new_arrival',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get is_required {
    return Intl.message(
      'Required',
      name: 'is_required',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get oops {
    return Intl.message(
      'Oops!',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password And Confirm.`
  String get enter_new_password_and_confirm {
    return Intl.message(
      'Enter New Password And Confirm.',
      name: 'enter_new_password_and_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `update`
  String get update {
    return Intl.message(
      'update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `governor`
  String get governor {
    return Intl.message(
      'governor',
      name: 'governor',
      desc: '',
      args: [],
    );
  }

  /// `receiverPhone`
  String get receiverPhone {
    return Intl.message(
      'receiverPhone',
      name: 'receiverPhone',
      desc: '',
      args: [],
    );
  }

  /// `Select Governor`
  String get selectGovernor {
    return Intl.message(
      'Select Governor',
      name: 'selectGovernor',
      desc: '',
      args: [],
    );
  }

  /// `From Map`
  String get selectFromMap {
    return Intl.message(
      'From Map',
      name: 'selectFromMap',
      desc: '',
      args: [],
    );
  }

  /// `My Location`
  String get myLocation {
    return Intl.message(
      'My Location',
      name: 'myLocation',
      desc: '',
      args: [],
    );
  }

  /// `start with 07 and 11 digit`
  String get helperPhoneText {
    return Intl.message(
      'start with 07 and 11 digit',
      name: 'helperPhoneText',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, Your Search Is \nNot Available`
  String get emptySearch {
    return Intl.message(
      'Sorry, Your Search Is \nNot Available',
      name: 'emptySearch',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Requests`
  String get emptyCart {
    return Intl.message(
      'Sorry, There Are \nNo Requests',
      name: 'emptyCart',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Requests`
  String get emptyFav {
    return Intl.message(
      'Sorry, There Are \nNo Requests',
      name: 'emptyFav',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Offers`
  String get emptyOffers {
    return Intl.message(
      'Sorry, There Are \nNo Offers',
      name: 'emptyOffers',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Notifications`
  String get emptyNotifications {
    return Intl.message(
      'Sorry, There Are \nNo Notifications',
      name: 'emptyNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Orders`
  String get emptyOrders {
    return Intl.message(
      'Sorry, There Are \nNo Orders',
      name: 'emptyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Address`
  String get confirmAddress {
    return Intl.message(
      'Confirm Address',
      name: 'confirmAddress',
      desc: '',
      args: [],
    );
  }

  /// `Cash Payment`
  String get cashPayment {
    return Intl.message(
      'Cash Payment',
      name: 'cashPayment',
      desc: '',
      args: [],
    );
  }

  /// `E-Payment`
  String get ePayment {
    return Intl.message(
      'E-Payment',
      name: 'ePayment',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Order Created`
  String get donePending {
    return Intl.message(
      'Order Created',
      name: 'donePending',
      desc: '',
      args: [],
    );
  }

  /// `Order Processed`
  String get doneProcessing {
    return Intl.message(
      'Order Processed',
      name: 'doneProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Order Was Ready`
  String get doneReady {
    return Intl.message(
      'Order Was Ready',
      name: 'doneReady',
      desc: '',
      args: [],
    );
  }

  /// `Order Shipped`
  String get doneShipping {
    return Intl.message(
      'Order Shipped',
      name: 'doneShipping',
      desc: '',
      args: [],
    );
  }

  /// `Order Completed`
  String get doneCompleted {
    return Intl.message(
      'Order Completed',
      name: 'doneCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Order Canceled`
  String get doneCanceled {
    return Intl.message(
      'Order Canceled',
      name: 'doneCanceled',
      desc: '',
      args: [],
    );
  }

  /// ` PaymentFailed`
  String get donePaymentFailed {
    return Intl.message(
      ' PaymentFailed',
      name: 'donePaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Order Returned`
  String get doneReturned {
    return Intl.message(
      'Order Returned',
      name: 'doneReturned',
      desc: '',
      args: [],
    );
  }

  /// `At`
  String get at {
    return Intl.message(
      'At',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get ready {
    return Intl.message(
      'Ready',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Returned`
  String get returned {
    return Intl.message(
      'Returned',
      name: 'returned',
      desc: '',
      args: [],
    );
  }

  /// `Not Yet`
  String get notYet {
    return Intl.message(
      'Not Yet',
      name: 'notYet',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Order`
  String get trackingOrder {
    return Intl.message(
      'Tracking Order',
      name: 'trackingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Your Order`
  String get yourOrder {
    return Intl.message(
      'Your Order',
      name: 'yourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Date`
  String get deliveryDate {
    return Intl.message(
      'Delivery Date',
      name: 'deliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Ready To Deliver`
  String get readyToDeliver {
    return Intl.message(
      'Ready To Deliver',
      name: 'readyToDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Estimated For`
  String get estimatedFor {
    return Intl.message(
      'Estimated For',
      name: 'estimatedFor',
      desc: '',
      args: [],
    );
  }

  /// `Pleas Set Your Address`
  String get pleasSetYourAddress {
    return Intl.message(
      'Pleas Set Your Address',
      name: 'pleasSetYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Review Order`
  String get reviewOrder {
    return Intl.message(
      'Review Order',
      name: 'reviewOrder',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get ar {
    return Intl.message(
      'Arabic',
      name: 'ar',
      desc: '',
      args: [],
    );
  }

  /// `Kurdish`
  String get ku {
    return Intl.message(
      'Kurdish',
      name: 'ku',
      desc: '',
      args: [],
    );
  }

  /// `Dollar`
  String get dollar {
    return Intl.message(
      'Dollar',
      name: 'dollar',
      desc: '',
      args: [],
    );
  }

  /// `Dinar`
  String get dinar {
    return Intl.message(
      'Dinar',
      name: 'dinar',
      desc: '',
      args: [],
    );
  }

  /// `Please Send Your Rating For The Product`
  String get setReview {
    return Intl.message(
      'Please Send Your Rating For The Product',
      name: 'setReview',
      desc: '',
      args: [],
    );
  }

  /// `No Reviews found`
  String get emptyReview {
    return Intl.message(
      'No Reviews found',
      name: 'emptyReview',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get addReview {
    return Intl.message(
      'Add Review',
      name: 'addReview',
      desc: '',
      args: [],
    );
  }

  /// `Search Result`
  String get searchResult {
    return Intl.message(
      'Search Result',
      name: 'searchResult',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Sub Categories`
  String get subCategories {
    return Intl.message(
      'Sub Categories',
      name: 'subCategories',
      desc: '',
      args: [],
    );
  }

  /// `Rated`
  String get rated {
    return Intl.message(
      'Rated',
      name: 'rated',
      desc: '',
      args: [],
    );
  }

  /// `Sign In With Social Networks`
  String get signInWithSocialNetworks {
    return Intl.message(
      'Sign In With Social Networks',
      name: 'signInWithSocialNetworks',
      desc: '',
      args: [],
    );
  }

  /// `Done Payment`
  String get confirmPayment {
    return Intl.message(
      'Done Payment',
      name: 'confirmPayment',
      desc: '',
      args: [],
    );
  }

  /// `Please Log In to continue `
  String get needLogin {
    return Intl.message(
      'Please Log In to continue ',
      name: 'needLogin',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get yourLocation {
    return Intl.message(
      'Your Location',
      name: 'yourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Identity Image`
  String get identityImage {
    return Intl.message(
      'Identity Image',
      name: 'identityImage',
      desc: '',
      args: [],
    );
  }

  /// `Done Pick`
  String get donePick {
    return Intl.message(
      'Done Pick',
      name: 'donePick',
      desc: '',
      args: [],
    );
  }

  /// `Click To Update`
  String get clickToUpdate {
    return Intl.message(
      'Click To Update',
      name: 'clickToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Profile Image`
  String get profileImage {
    return Intl.message(
      'Profile Image',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `The code has been sent! If necessary, we can resend the code up to two additional times.`
  String get doneSendCode {
    return Intl.message(
      'The code has been sent! If necessary, we can resend the code up to two additional times.',
      name: 'doneSendCode',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a text message containing your verification code to the phone number: `
  String get doneSendSms {
    return Intl.message(
      'We have sent a text message containing your verification code to the phone number: ',
      name: 'doneSendSms',
      desc: '',
      args: [],
    );
  }

  /// `Remember Password`
  String get rememberPassword {
    return Intl.message(
      'Remember Password',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get isSuccess {
    return Intl.message(
      'Success!',
      name: 'isSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Change File`
  String get changeFile {
    return Intl.message(
      'Change File',
      name: 'changeFile',
      desc: '',
      args: [],
    );
  }

  /// `Download File`
  String get downloadFile {
    return Intl.message(
      'Download File',
      name: 'downloadFile',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Phone`
  String get confirmYourPhone {
    return Intl.message(
      'Confirm Your Phone',
      name: 'confirmYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Teaching staff`
  String get teachingStaff {
    return Intl.message(
      'Teaching staff',
      name: 'teachingStaff',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get lesson {
    return Intl.message(
      'Lesson',
      name: 'lesson',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message(
      'Follow',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `Un Follow`
  String get unFollow {
    return Intl.message(
      'Un Follow',
      name: 'unFollow',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Free lessons`
  String get freeLesson {
    return Intl.message(
      'Free lessons',
      name: 'freeLesson',
      desc: '',
      args: [],
    );
  }

  /// `Free Summary`
  String get freeSummary {
    return Intl.message(
      'Free Summary',
      name: 'freeSummary',
      desc: '',
      args: [],
    );
  }

  /// `Summaries`
  String get summaries {
    return Intl.message(
      'Summaries',
      name: 'summaries',
      desc: '',
      args: [],
    );
  }

  /// `Educational Progress`
  String get educationalProgress {
    return Intl.message(
      'Educational Progress',
      name: 'educationalProgress',
      desc: '',
      args: [],
    );
  }

  /// `All Notifications`
  String get subTitleNotification {
    return Intl.message(
      'All Notifications',
      name: 'subTitleNotification',
      desc: '',
      args: [],
    );
  }

  /// `To change password`
  String get subTitlePassword {
    return Intl.message(
      'To change password',
      name: 'subTitlePassword',
      desc: '',
      args: [],
    );
  }

  /// `Our support `
  String get subTitleSupport {
    return Intl.message(
      'Our support ',
      name: 'subTitleSupport',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy and conditions `
  String get subTitlePolicy {
    return Intl.message(
      'Privacy policy and conditions ',
      name: 'subTitlePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Delete all your data `
  String get subTitleDeleteAccount {
    return Intl.message(
      'Delete all your data ',
      name: 'subTitleDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Build Number`
  String get buildNumber {
    return Intl.message(
      'Build Number',
      name: 'buildNumber',
      desc: '',
      args: [],
    );
  }

  /// `Middle Name`
  String get middleName {
    return Intl.message(
      'Middle Name',
      name: 'middleName',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Planned`
  String get planned {
    return Intl.message(
      'Planned',
      name: 'planned',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled`
  String get scheduled {
    return Intl.message(
      'Scheduled',
      name: 'scheduled',
      desc: '',
      args: [],
    );
  }

  /// `Postponed`
  String get postponed {
    return Intl.message(
      'Postponed',
      name: 'postponed',
      desc: '',
      args: [],
    );
  }

  /// `Running`
  String get running {
    return Intl.message(
      'Running',
      name: 'running',
      desc: '',
      args: [],
    );
  }

  /// `Published`
  String get archived {
    return Intl.message(
      'Published',
      name: 'archived',
      desc: '',
      args: [],
    );
  }

  /// `Meeting`
  String get meeting {
    return Intl.message(
      'Meeting',
      name: 'meeting',
      desc: '',
      args: [],
    );
  }

  /// `Add guest`
  String get addGuest {
    return Intl.message(
      'Add guest',
      name: 'addGuest',
      desc: '',
      args: [],
    );
  }

  /// `Requests for absence`
  String get requestAbsence {
    return Intl.message(
      'Requests for absence',
      name: 'requestAbsence',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Power by `
  String get devBy {
    return Intl.message(
      'Power by ',
      name: 'devBy',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Vote`
  String get vote {
    return Intl.message(
      'Vote',
      name: 'vote',
      desc: '',
      args: [],
    );
  }

  /// `Votes`
  String get votes {
    return Intl.message(
      'Votes',
      name: 'votes',
      desc: '',
      args: [],
    );
  }

  /// `Edit Vote`
  String get editVote {
    return Intl.message(
      'Edit Vote',
      name: 'editVote',
      desc: '',
      args: [],
    );
  }

  /// `Suggesting Guest`
  String get suggestingGuest {
    return Intl.message(
      'Suggesting Guest',
      name: 'suggestingGuest',
      desc: '',
      args: [],
    );
  }

  /// `Suggested Guest`
  String get suggestedGuest {
    return Intl.message(
      'Suggested Guest',
      name: 'suggestedGuest',
      desc: '',
      args: [],
    );
  }

  /// `Suggested Guests`
  String get suggestedGuests {
    return Intl.message(
      'Suggested Guests',
      name: 'suggestedGuests',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message(
      'Member',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `Chair`
  String get chair {
    return Intl.message(
      'Chair',
      name: 'chair',
      desc: '',
      args: [],
    );
  }

  /// `Secretary`
  String get secretary {
    return Intl.message(
      'Secretary',
      name: 'secretary',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest {
    return Intl.message(
      'Guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Voters`
  String get voters {
    return Intl.message(
      'Voters',
      name: 'voters',
      desc: '',
      args: [],
    );
  }

  /// `Agendas`
  String get agendas {
    return Intl.message(
      'Agendas',
      name: 'agendas',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
