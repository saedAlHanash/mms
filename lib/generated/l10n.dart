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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
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
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Choosing`
  String get choosing {
    return Intl.message('Choosing', name: 'choosing', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
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
    return Intl.message('Mail', name: 'mail', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Favorites`
  String get fav {
    return Intl.message('Favorites', name: 'fav', desc: '', args: []);
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
    return Intl.message('My Orders', name: 'myOrder', desc: '', args: []);
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
    return Intl.message('Username', name: 'userName', desc: '', args: []);
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
    return Intl.message('Region', name: 'region', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
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
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
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
    return Intl.message('Continue', name: 'continueTo', desc: '', args: []);
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
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
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
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
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
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Contact Us`
  String get contact {
    return Intl.message('Contact Us', name: 'contact', desc: '', args: []);
  }

  /// `Change Name`
  String get changeName {
    return Intl.message('Change Name', name: 'changeName', desc: '', args: []);
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
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
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
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
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
    return Intl.message('name', name: 'name', desc: '', args: []);
  }

  /// `birthday`
  String get birthday {
    return Intl.message('birthday', name: 'birthday', desc: '', args: []);
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
    return Intl.message('Sign In.', name: 'sgnIn', desc: '', args: []);
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

  /// `Phone call`
  String get phoneCall {
    return Intl.message('Phone call', name: 'phoneCall', desc: '', args: []);
  }

  /// `Phone SMS`
  String get phoneSms {
    return Intl.message('Phone SMS', name: 'phoneSms', desc: '', args: []);
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
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `verify`
  String get verify {
    return Intl.message('verify', name: 'verify', desc: '', args: []);
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
    return Intl.message('save change', name: 'saveChange', desc: '', args: []);
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
    return Intl.message('Your Phone', name: 'yourPhone', desc: '', args: []);
  }

  /// `Your Name`
  String get yourName {
    return Intl.message('Your Name', name: 'yourName', desc: '', args: []);
  }

  /// `Your Email`
  String get yourEmail {
    return Intl.message('Your Email', name: 'yourEmail', desc: '', args: []);
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
    return Intl.message('first name', name: 'firstName', desc: '', args: []);
  }

  /// `Last name`
  String get lastName {
    return Intl.message('Last name', name: 'lastName', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
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
    return Intl.message('Other', name: 'other', desc: '', args: []);
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
    return Intl.message('My Info', name: 'myInfo', desc: '', args: []);
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message('My Orders', name: 'myOrders', desc: '', args: []);
  }

  /// `WishList`
  String get wishList {
    return Intl.message('WishList', name: 'wishList', desc: '', args: []);
  }

  /// `F.A.q`
  String get faq {
    return Intl.message('F.A.q', name: 'faq', desc: '', args: []);
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
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
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
    return Intl.message('Flash Deal', name: 'flash_deal', desc: '', args: []);
  }

  /// `See All`
  String get see_all {
    return Intl.message('See All', name: 'see_all', desc: '', args: []);
  }

  /// `Offer`
  String get offer {
    return Intl.message('Offer', name: 'offer', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `seconds`
  String get seconds {
    return Intl.message('seconds', name: 'seconds', desc: '', args: []);
  }

  /// `Min`
  String get min {
    return Intl.message('Min', name: 'min', desc: '', args: []);
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `Sizes`
  String get sizes {
    return Intl.message('Sizes', name: 'sizes', desc: '', args: []);
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
    return Intl.message('Max', name: 'max', desc: '', args: []);
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
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Colors`
  String get colors {
    return Intl.message('Colors', name: 'colors', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
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
    return Intl.message('Expiration', name: 'expiration', desc: '', args: []);
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
    return Intl.message('Location', name: 'location', desc: '', args: []);
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
    return Intl.message('Cvc', name: 'cvc', desc: '', args: []);
  }

  /// `Card Name`
  String get card_name {
    return Intl.message('Card Name', name: 'card_name', desc: '', args: []);
  }

  /// `Card Number`
  String get card_number {
    return Intl.message('Card Number', name: 'card_number', desc: '', args: []);
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
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
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
    return Intl.message('Coupon Code', name: 'coupon_code', desc: '', args: []);
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
    return Intl.message('Wishlist', name: 'wishlist', desc: '', args: []);
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
    return Intl.message('Add To Cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `New Arrival`
  String get new_arrival {
    return Intl.message('New Arrival', name: 'new_arrival', desc: '', args: []);
  }

  /// `Required`
  String get is_required {
    return Intl.message('Required', name: 'is_required', desc: '', args: []);
  }

  /// `Oops!`
  String get oops {
    return Intl.message('Oops!', name: 'oops', desc: '', args: []);
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
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `update`
  String get update {
    return Intl.message('update', name: 'update', desc: '', args: []);
  }

  /// `governor`
  String get governor {
    return Intl.message('governor', name: 'governor', desc: '', args: []);
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
    return Intl.message('From Map', name: 'selectFromMap', desc: '', args: []);
  }

  /// `My Location`
  String get myLocation {
    return Intl.message('My Location', name: 'myLocation', desc: '', args: []);
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
    return Intl.message('E-Payment', name: 'ePayment', desc: '', args: []);
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
    return Intl.message('At', name: 'at', desc: '', args: []);
  }

  /// `Processing`
  String get processing {
    return Intl.message('Processing', name: 'processing', desc: '', args: []);
  }

  /// `Ready`
  String get ready {
    return Intl.message('Ready', name: 'ready', desc: '', args: []);
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Canceled`
  String get canceled {
    return Intl.message('Canceled', name: 'canceled', desc: '', args: []);
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
    return Intl.message('Returned', name: 'returned', desc: '', args: []);
  }

  /// `Not Yet`
  String get notYet {
    return Intl.message('Not Yet', name: 'notYet', desc: '', args: []);
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
    return Intl.message('Your Order', name: 'yourOrder', desc: '', args: []);
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
    return Intl.message('English', name: 'en', desc: '', args: []);
  }

  /// `Arabic`
  String get ar {
    return Intl.message('Arabic', name: 'ar', desc: '', args: []);
  }

  /// `Kurdish`
  String get ku {
    return Intl.message('Kurdish', name: 'ku', desc: '', args: []);
  }

  /// `Dollar`
  String get dollar {
    return Intl.message('Dollar', name: 'dollar', desc: '', args: []);
  }

  /// `Dinar`
  String get dinar {
    return Intl.message('Dinar', name: 'dinar', desc: '', args: []);
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
    return Intl.message('Add Review', name: 'addReview', desc: '', args: []);
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
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
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
    return Intl.message('Rated', name: 'rated', desc: '', args: []);
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
    return Intl.message('Product', name: 'product', desc: '', args: []);
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
    return Intl.message('Done Pick', name: 'donePick', desc: '', args: []);
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
    return Intl.message('Success!', name: 'isSuccess', desc: '', args: []);
  }

  /// `Change File`
  String get changeFile {
    return Intl.message('Change File', name: 'changeFile', desc: '', args: []);
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
    return Intl.message('Lesson', name: 'lesson', desc: '', args: []);
  }

  /// `Follow`
  String get follow {
    return Intl.message('Follow', name: 'follow', desc: '', args: []);
  }

  /// `Un Follow`
  String get unFollow {
    return Intl.message('Un Follow', name: 'unFollow', desc: '', args: []);
  }

  /// `Courses`
  String get courses {
    return Intl.message('Courses', name: 'courses', desc: '', args: []);
  }

  /// `Free lessons`
  String get freeLesson {
    return Intl.message('Free lessons', name: 'freeLesson', desc: '', args: []);
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
    return Intl.message('Summaries', name: 'summaries', desc: '', args: []);
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
    return Intl.message('Middle Name', name: 'middleName', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Approved`
  String get approved {
    return Intl.message('Approved', name: 'approved', desc: '', args: []);
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Planned`
  String get planned {
    return Intl.message('Planned', name: 'planned', desc: '', args: []);
  }

  /// `Scheduled`
  String get scheduled {
    return Intl.message('Scheduled', name: 'scheduled', desc: '', args: []);
  }

  /// `Postponed`
  String get postponed {
    return Intl.message('Postponed', name: 'postponed', desc: '', args: []);
  }

  /// `Running`
  String get running {
    return Intl.message('Running', name: 'running', desc: '', args: []);
  }

  /// `Published`
  String get archived {
    return Intl.message('Published', name: 'archived', desc: '', args: []);
  }

  /// `Meeting`
  String get meeting {
    return Intl.message('Meeting', name: 'meeting', desc: '', args: []);
  }

  /// `Add guest`
  String get addGuest {
    return Intl.message('Add guest', name: 'addGuest', desc: '', args: []);
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
    return Intl.message('Company', name: 'company', desc: '', args: []);
  }

  /// `Power by `
  String get devBy {
    return Intl.message('Power by ', name: 'devBy', desc: '', args: []);
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
    return Intl.message('Vote', name: 'vote', desc: '', args: []);
  }

  /// `Votes`
  String get votes {
    return Intl.message('Votes', name: 'votes', desc: '', args: []);
  }

  /// `Edit Vote`
  String get editVote {
    return Intl.message('Edit Vote', name: 'editVote', desc: '', args: []);
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
    return Intl.message('Member', name: 'member', desc: '', args: []);
  }

  /// `Chair`
  String get chair {
    return Intl.message('Chair', name: 'chair', desc: '', args: []);
  }

  /// `Secretary`
  String get secretary {
    return Intl.message('Secretary', name: 'secretary', desc: '', args: []);
  }

  /// `Guest`
  String get guest {
    return Intl.message('Guest', name: 'guest', desc: '', args: []);
  }

  /// `Voters`
  String get voters {
    return Intl.message('Voters', name: 'voters', desc: '', args: []);
  }

  /// `Agendas`
  String get agendas {
    return Intl.message('Agendas', name: 'agendas', desc: '', args: []);
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Goals`
  String get goals {
    return Intl.message('Goals', name: 'goals', desc: '', args: []);
  }

  /// `tasks`
  String get tasks {
    return Intl.message('tasks', name: 'tasks', desc: '', args: []);
  }

  /// `Published`
  String get published {
    return Intl.message('Published', name: 'published', desc: '', args: []);
  }

  /// `UnPublished`
  String get unpublished {
    return Intl.message('UnPublished', name: 'unpublished', desc: '', args: []);
  }

  /// `Statement`
  String get statement {
    return Intl.message('Statement', name: 'statement', desc: '', args: []);
  }

  /// `Documents`
  String get documents {
    return Intl.message('Documents', name: 'documents', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Build`
  String get build {
    return Intl.message('Build', name: 'build', desc: '', args: []);
  }

  /// `Discussions`
  String get discussions {
    return Intl.message('Discussions', name: 'discussions', desc: '', args: []);
  }

  /// `Powered by CORETECH`
  String get poweredByCoretech {
    return Intl.message(
      'Powered by CORETECH',
      name: 'poweredByCoretech',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message('Connect', name: 'connect', desc: '', args: []);
  }

  /// `Your connection has been suspended by the admin, but you are still connected. Please wait until you are allowed to resume.`
  String get yourConnectionHasBeenSuspendedByTheAdminButYou {
    return Intl.message(
      'Your connection has been suspended by the admin, but you are still connected. Please wait until you are allowed to resume.',
      name: 'yourConnectionHasBeenSuspendedByTheAdminButYou',
      desc: '',
      args: [],
    );
  }

  /// `I am not currently a member of any committees.`
  String get iAmNotCurrentlyAMemberOfAnyCommittees {
    return Intl.message(
      'I am not currently a member of any committees.',
      name: 'iAmNotCurrentlyAMemberOfAnyCommittees',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `My comment`
  String get myComment {
    return Intl.message('My comment', name: 'myComment', desc: '', args: []);
  }

  /// `Open`
  String get statusOpen {
    return Intl.message('Open', name: 'statusOpen', desc: '', args: []);
  }

  /// `Closed`
  String get statusClosed {
    return Intl.message('Closed', name: 'statusClosed', desc: '', args: []);
  }

  /// `Pending`
  String get statusPending {
    return Intl.message('Pending', name: 'statusPending', desc: '', args: []);
  }

  /// `Enter your account details to access your committees and meetings.`
  String get loginSubtitle {
    return Intl.message(
      'Enter your account details to access your committees and meetings.',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Recover your password`
  String get forgetPasswordTitle {
    return Intl.message(
      'Recover your password',
      name: 'forgetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the phone number registered to your account.`
  String get forgetPasswordSubtitle {
    return Intl.message(
      'Enter the phone number registered to your account.',
      name: 'forgetPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPasswordTitle {
    return Intl.message(
      'New password',
      name: 'newPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get backToLogin {
    return Intl.message(
      'Back to login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get resendCode {
    return Intl.message('Resend code', name: 'resendCode', desc: '', args: []);
  }

  /// `Show`
  String get showPassword {
    return Intl.message('Show', name: 'showPassword', desc: '', args: []);
  }

  /// `Hide`
  String get hidePassword {
    return Intl.message('Hide', name: 'hidePassword', desc: '', args: []);
  }

  /// `We sent the code by SMS to`
  String get otpSentTo {
    return Intl.message(
      'We sent the code by SMS to',
      name: 'otpSentTo',
      desc: '',
      args: [],
    );
  }

  /// `My committees`
  String get navCommittees {
    return Intl.message(
      'My committees',
      name: 'navCommittees',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get navCalendar {
    return Intl.message('Calendar', name: 'navCalendar', desc: '', args: []);
  }

  /// `Settings`
  String get navSettings {
    return Intl.message('Settings', name: 'navSettings', desc: '', args: []);
  }

  /// `{count, plural, =0{No committees} =1{1 committee} other{{count} committees}}`
  String committeesCount(num count) {
    return Intl.plural(
      count,
      zero: 'No committees',
      one: '1 committee',
      other: '$count committees',
      name: 'committeesCount',
      desc: '',
      args: [count],
    );
  }

  /// `Your committees will appear here once you are added. Pull down to refresh.`
  String get noCommitteesDescription {
    return Intl.message(
      'Your committees will appear here once you are added. Pull down to refresh.',
      name: 'noCommitteesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `{count, plural, =0{No meetings} =1{1 meeting} other{{count} meetings}}`
  String meetingsCount(num count) {
    return Intl.plural(
      count,
      zero: 'No meetings',
      one: '1 meeting',
      other: '$count meetings',
      name: 'meetingsCount',
      desc: '',
      args: [count],
    );
  }

  /// `No meetings on this day`
  String get noMeetingsThisDay {
    return Intl.message(
      'No meetings on this day',
      name: 'noMeetingsThisDay',
      desc: '',
      args: [],
    );
  }

  /// `Days with meetings are marked with a purple dot.`
  String get noMeetingsThisDayHint {
    return Intl.message(
      'Days with meetings are marked with a purple dot.',
      name: 'noMeetingsThisDayHint',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `View profile`
  String get viewProfile {
    return Intl.message(
      'View profile',
      name: 'viewProfile',
      desc: '',
      args: [],
    );
  }

  /// `Log out?`
  String get logoutQuestion {
    return Intl.message('Log out?', name: 'logoutQuestion', desc: '', args: []);
  }

  /// `You will need to enter your details again to sign in.`
  String get logoutDescription {
    return Intl.message(
      'You will need to enter your details again to sign in.',
      name: 'logoutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get members {
    return Intl.message('Members', name: 'members', desc: '', args: []);
  }

  /// `Meetings`
  String get meetings {
    return Intl.message('Meetings', name: 'meetings', desc: '', args: []);
  }

  /// `Your membership`
  String get yourMembership {
    return Intl.message(
      'Your membership',
      name: 'yourMembership',
      desc: '',
      args: [],
    );
  }

  /// `Formation date`
  String get formationDate {
    return Intl.message(
      'Formation date',
      name: 'formationDate',
      desc: '',
      args: [],
    );
  }

  /// `Committee meetings`
  String get committeeMeetings {
    return Intl.message(
      'Committee meetings',
      name: 'committeeMeetings',
      desc: '',
      args: [],
    );
  }

  /// `Committee calendar`
  String get committeeCalendar {
    return Intl.message(
      'Committee calendar',
      name: 'committeeCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Committee description`
  String get committeeDescription {
    return Intl.message(
      'Committee description',
      name: 'committeeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Committee statement`
  String get committeeStatement {
    return Intl.message(
      'Committee statement',
      name: 'committeeStatement',
      desc: '',
      args: [],
    );
  }

  /// `No description is recorded for this committee.`
  String get noCommitteeDescription {
    return Intl.message(
      'No description is recorded for this committee.',
      name: 'noCommitteeDescription',
      desc: '',
      args: [],
    );
  }

  /// `No statement is recorded for this committee.`
  String get noCommitteeStatement {
    return Intl.message(
      'No statement is recorded for this committee.',
      name: 'noCommitteeStatement',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get showMore {
    return Intl.message('Show more', name: 'showMore', desc: '', args: []);
  }

  /// `Show less`
  String get showLess {
    return Intl.message('Show less', name: 'showLess', desc: '', args: []);
  }

  /// `{count, plural, =0{No documents} =1{1 document} other{{count} documents}}`
  String documentsCount(num count) {
    return Intl.plural(
      count,
      zero: 'No documents',
      one: '1 document',
      other: '$count documents',
      name: 'documentsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0{No goals} =1{1 goal} other{{count} goals}}`
  String goalsCount(num count) {
    return Intl.plural(
      count,
      zero: 'No goals',
      one: '1 goal',
      other: '$count goals',
      name: 'goalsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0{No tasks} =1{1 task} other{{count} tasks}}`
  String tasksCount(num count) {
    return Intl.plural(
      count,
      zero: 'No tasks',
      one: '1 task',
      other: '$count tasks',
      name: 'tasksCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0{No members} =1{1 member} other{{count} members}}`
  String membersCount(num count) {
    return Intl.plural(
      count,
      zero: 'No members',
      one: '1 member',
      other: '$count members',
      name: 'membersCount',
      desc: '',
      args: [count],
    );
  }

  /// `Start date`
  String get startDate {
    return Intl.message('Start date', name: 'startDate', desc: '', args: []);
  }

  /// `Due date`
  String get dueDate {
    return Intl.message('Due date', name: 'dueDate', desc: '', args: []);
  }

  /// `You`
  String get you {
    return Intl.message('You', name: 'you', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `No documents yet`
  String get noDocumentsYet {
    return Intl.message(
      'No documents yet',
      name: 'noDocumentsYet',
      desc: '',
      args: [],
    );
  }

  /// `Committee documents will appear here once added.`
  String get noDocumentsYetDescription {
    return Intl.message(
      'Committee documents will appear here once added.',
      name: 'noDocumentsYetDescription',
      desc: '',
      args: [],
    );
  }

  /// `No goals set yet`
  String get noGoalsYet {
    return Intl.message(
      'No goals set yet',
      name: 'noGoalsYet',
      desc: '',
      args: [],
    );
  }

  /// `Committee goals and tasks will appear here once added.`
  String get noGoalsYetDescription {
    return Intl.message(
      'Committee goals and tasks will appear here once added.',
      name: 'noGoalsYetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Attendees & guests`
  String get attendeesAndGuests {
    return Intl.message(
      'Attendees & guests',
      name: 'attendeesAndGuests',
      desc: '',
      args: [],
    );
  }

  /// `Attendees`
  String get attendees {
    return Intl.message('Attendees', name: 'attendees', desc: '', args: []);
  }

  /// `Guests`
  String get guests {
    return Intl.message('Guests', name: 'guests', desc: '', args: []);
  }

  /// `Suggested`
  String get suggested {
    return Intl.message('Suggested', name: 'suggested', desc: '', args: []);
  }

  /// `Add comment`
  String get addComment {
    return Intl.message('Add comment', name: 'addComment', desc: '', args: []);
  }

  /// `Your comment`
  String get yourComment {
    return Intl.message(
      'Your comment',
      name: 'yourComment',
      desc: '',
      args: [],
    );
  }

  /// `Write your comment here…`
  String get writeYourComment {
    return Intl.message(
      'Write your comment here…',
      name: 'writeYourComment',
      desc: '',
      args: [],
    );
  }

  /// `Agenda item`
  String get agendaItem {
    return Intl.message('Agenda item', name: 'agendaItem', desc: '', args: []);
  }

  /// `Discussion`
  String get discussion {
    return Intl.message('Discussion', name: 'discussion', desc: '', args: []);
  }

  /// `One comment per item, and it can't be edited after sending.`
  String get commentHint {
    return Intl.message(
      'One comment per item, and it can\'t be edited after sending.',
      name: 'commentHint',
      desc: '',
      args: [],
    );
  }

  /// `Show sub-items ({count})`
  String showSubItems(Object count) {
    return Intl.message(
      'Show sub-items ($count)',
      name: 'showSubItems',
      desc: '',
      args: [count],
    );
  }

  /// `Hide sub-items ({count})`
  String hideSubItems(Object count) {
    return Intl.message(
      'Hide sub-items ($count)',
      name: 'hideSubItems',
      desc: '',
      args: [count],
    );
  }

  /// `{count} awaiting your vote`
  String votesPending(Object count) {
    return Intl.message(
      '$count awaiting your vote',
      name: 'votesPending',
      desc: '',
      args: [count],
    );
  }

  /// `No votes awaiting you`
  String get noVotesPending {
    return Intl.message(
      'No votes awaiting you',
      name: 'noVotesPending',
      desc: '',
      args: [],
    );
  }

  /// `The agenda hasn't been added yet`
  String get noAgendaYet {
    return Intl.message(
      'The agenda hasn\'t been added yet',
      name: 'noAgendaYet',
      desc: '',
      args: [],
    );
  }

  /// `Items will appear here once added, and you can comment on each one.`
  String get noAgendaYetDescription {
    return Intl.message(
      'Items will appear here once added, and you can comment on each one.',
      name: 'noAgendaYetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Suggested guest for`
  String get suggestedFor {
    return Intl.message(
      'Suggested guest for',
      name: 'suggestedFor',
      desc: '',
      args: [],
    );
  }

  /// `Attendance recorded`
  String get attendanceRecorded {
    return Intl.message(
      'Attendance recorded',
      name: 'attendanceRecorded',
      desc: '',
      args: [],
    );
  }

  /// `Attendance not recorded`
  String get attendanceNotRecorded {
    return Intl.message(
      'Attendance not recorded',
      name: 'attendanceNotRecorded',
      desc: '',
      args: [],
    );
  }

  /// `Send suggestion`
  String get sendSuggestion {
    return Intl.message(
      'Send suggestion',
      name: 'sendSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required. The guest appears under "Suggested guests" after sending.`
  String get addGuestHint {
    return Intl.message(
      'All fields are required. The guest appears under "Suggested guests" after sending.',
      name: 'addGuestHint',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get fromLabel {
    return Intl.message('From', name: 'fromLabel', desc: '', args: []);
  }

  /// `To`
  String get toLabel {
    return Intl.message('To', name: 'toLabel', desc: '', args: []);
  }

  /// `{count, plural, =0{No items} =1{1 item} other{{count} items}}`
  String itemsCount(num count) {
    return Intl.plural(
      count,
      zero: 'No items',
      one: '1 item',
      other: '$count items',
      name: 'itemsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0{No discussions} =1{1 discussion} other{{count} discussions}}`
  String discussionsCount(num count) {
    return Intl.plural(
      count,
      zero: 'No discussions',
      one: '1 discussion',
      other: '$count discussions',
      name: 'discussionsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Votes`
  String get votesTitle {
    return Intl.message('Votes', name: 'votesTitle', desc: '', args: []);
  }

  /// `Polls`
  String get polls {
    return Intl.message('Polls', name: 'polls', desc: '', args: []);
  }

  /// `Published results`
  String get publishedResults {
    return Intl.message(
      'Published results',
      name: 'publishedResults',
      desc: '',
      args: [],
    );
  }

  /// `Your vote`
  String get yourVote {
    return Intl.message('Your vote', name: 'yourVote', desc: '', args: []);
  }

  /// `Your vote is recorded`
  String get voteRecorded {
    return Intl.message(
      'Your vote is recorded',
      name: 'voteRecorded',
      desc: '',
      args: [],
    );
  }

  /// `Voting ended`
  String get votingEnded {
    return Intl.message(
      'Voting ended',
      name: 'votingEnded',
      desc: '',
      args: [],
    );
  }

  /// `No votes for this meeting`
  String get noVotesForMeeting {
    return Intl.message(
      'No votes for this meeting',
      name: 'noVotesForMeeting',
      desc: '',
      args: [],
    );
  }

  /// `Polls will appear here when opened, and their results once published.`
  String get noVotesForMeetingDescription {
    return Intl.message(
      'Polls will appear here when opened, and their results once published.',
      name: 'noVotesForMeetingDescription',
      desc: '',
      args: [],
    );
  }

  /// `votes`
  String get voteUnit {
    return Intl.message('votes', name: 'voteUnit', desc: '', args: []);
  }

  /// `Change profile photo`
  String get changePhoto {
    return Intl.message(
      'Change profile photo',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Basic information`
  String get basicInfo {
    return Intl.message(
      'Basic information',
      name: 'basicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Read only`
  String get readOnly {
    return Intl.message('Read only', name: 'readOnly', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `No notifications`
  String get noNotifications {
    return Intl.message(
      'No notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Notifications will appear here as they arrive. Pull down to refresh.`
  String get noNotificationsDescription {
    return Intl.message(
      'Notifications will appear here as they arrive. Pull down to refresh.',
      name: 'noNotificationsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Online meeting`
  String get onlineMeeting {
    return Intl.message(
      'Online meeting',
      name: 'onlineMeeting',
      desc: '',
      args: [],
    );
  }

  /// `The meeting is live now`
  String get meetingRunningNow {
    return Intl.message(
      'The meeting is live now',
      name: 'meetingRunningNow',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message('Join', name: 'join', desc: '', args: []);
  }

  /// `Connected`
  String get connected {
    return Intl.message('Connected', name: 'connected', desc: '', args: []);
  }

  /// `Not connected`
  String get notConnected {
    return Intl.message(
      'Not connected',
      name: 'notConnected',
      desc: '',
      args: [],
    );
  }

  /// `Listen only`
  String get listenOnly {
    return Intl.message('Listen only', name: 'listenOnly', desc: '', args: []);
  }

  /// `Suspended`
  String get suspended {
    return Intl.message('Suspended', name: 'suspended', desc: '', args: []);
  }

  /// `Request to speak`
  String get requestToSpeak {
    return Intl.message(
      'Request to speak',
      name: 'requestToSpeak',
      desc: '',
      args: [],
    );
  }

  /// `Request sent to the host`
  String get requestSent {
    return Intl.message(
      'Request sent to the host',
      name: 'requestSent',
      desc: '',
      args: [],
    );
  }

  /// `End call`
  String get endCall {
    return Intl.message('End call', name: 'endCall', desc: '', args: []);
  }

  /// `End the call?`
  String get endCallConfirm {
    return Intl.message(
      'End the call?',
      name: 'endCallConfirm',
      desc: '',
      args: [],
    );
  }

  /// `You will leave the online meeting and stay on the meeting page.`
  String get endCallConfirmDescription {
    return Intl.message(
      'You will leave the online meeting and stay on the meeting page.',
      name: 'endCallConfirmDescription',
      desc: '',
      args: [],
    );
  }

  /// `Started at`
  String get startedAt {
    return Intl.message('Started at', name: 'startedAt', desc: '', args: []);
  }

  /// `Join with audio and video here while the meeting page stays in front of you.`
  String get joinOnlineHint {
    return Intl.message(
      'Join with audio and video here while the meeting page stays in front of you.',
      name: 'joinOnlineHint',
      desc: '',
      args: [],
    );
  }

  /// `Your connection is paused`
  String get connectionSuspendedTitle {
    return Intl.message(
      'Your connection is paused',
      name: 'connectionSuspendedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Collapse`
  String get collapse {
    return Intl.message('Collapse', name: 'collapse', desc: '', args: []);
  }

  /// `Mute microphone`
  String get muteMic {
    return Intl.message('Mute microphone', name: 'muteMic', desc: '', args: []);
  }

  /// `Unmute microphone`
  String get unmuteMic {
    return Intl.message(
      'Unmute microphone',
      name: 'unmuteMic',
      desc: '',
      args: [],
    );
  }

  /// `Turn camera on`
  String get cameraOn {
    return Intl.message('Turn camera on', name: 'cameraOn', desc: '', args: []);
  }

  /// `Turn camera off`
  String get cameraOff {
    return Intl.message(
      'Turn camera off',
      name: 'cameraOff',
      desc: '',
      args: [],
    );
  }

  /// `Share screen`
  String get shareScreen {
    return Intl.message(
      'Share screen',
      name: 'shareScreen',
      desc: '',
      args: [],
    );
  }

  /// `Stop sharing`
  String get stopShare {
    return Intl.message('Stop sharing', name: 'stopShare', desc: '', args: []);
  }

  /// `Full screen`
  String get fullscreen {
    return Intl.message('Full screen', name: 'fullscreen', desc: '', args: []);
  }

  /// `Quick message to the host`
  String get quickMessage {
    return Intl.message(
      'Quick message to the host',
      name: 'quickMessage',
      desc: '',
      args: [],
    );
  }

  /// `You are not signed in`
  String get notLoggedIn {
    return Intl.message(
      'You are not signed in',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get serverError {
    return Intl.message(
      'Server error',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Screen sharing`
  String get screenSharingTitle {
    return Intl.message(
      'Screen sharing',
      name: 'screenSharingTitle',
      desc: '',
      args: [],
    );
  }

  /// `MMS is sharing the screen.`
  String get screenSharingText {
    return Intl.message(
      'MMS is sharing the screen.',
      name: 'screenSharingText',
      desc: '',
      args: [],
    );
  }

  /// `Screen sharing isn't supported on mobile web`
  String get screenShareNotSupported {
    return Intl.message(
      'Screen sharing isn\'t supported on mobile web',
      name: 'screenShareNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `I can't hear`
  String get noteCannotHear {
    return Intl.message(
      'I can\'t hear',
      name: 'noteCannotHear',
      desc: '',
      args: [],
    );
  }

  /// `I can't see the screen`
  String get noteCannotSee {
    return Intl.message(
      'I can\'t see the screen',
      name: 'noteCannotSee',
      desc: '',
      args: [],
    );
  }

  /// `I need help`
  String get noteNeedHelp {
    return Intl.message(
      'I need help',
      name: 'noteNeedHelp',
      desc: '',
      args: [],
    );
  }

  /// `Live`
  String get liveConnected {
    return Intl.message('Live', name: 'liveConnected', desc: '', args: []);
  }

  /// `Connecting…`
  String get liveConnecting {
    return Intl.message(
      'Connecting…',
      name: 'liveConnecting',
      desc: '',
      args: [],
    );
  }

  /// `Reconnecting…`
  String get liveReconnecting {
    return Intl.message(
      'Reconnecting…',
      name: 'liveReconnecting',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get liveDisconnected {
    return Intl.message(
      'Offline',
      name: 'liveDisconnected',
      desc: '',
      args: [],
    );
  }

  /// `Live updates are off. Tap to reconnect.`
  String get liveTapToRetry {
    return Intl.message(
      'Live updates are off. Tap to reconnect.',
      name: 'liveTapToRetry',
      desc: '',
      args: [],
    );
  }

  /// `Live updates`
  String get liveUpdates {
    return Intl.message(
      'Live updates',
      name: 'liveUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Agenda updated`
  String get hubAgendaUpdated {
    return Intl.message(
      'Agenda updated',
      name: 'hubAgendaUpdated',
      desc: '',
      args: [],
    );
  }

  /// `“{title}”: {status}`
  String hubAgendaUpdatedBody(Object title, Object status) {
    return Intl.message(
      '“$title”: $status',
      name: 'hubAgendaUpdatedBody',
      desc: '',
      args: [title, status],
    );
  }

  /// `Pending`
  String get agendaStatusPending {
    return Intl.message(
      'Pending',
      name: 'agendaStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get agendaStatusActive {
    return Intl.message(
      'In progress',
      name: 'agendaStatusActive',
      desc: '',
      args: [],
    );
  }

  /// `Concluded`
  String get agendaStatusConcluded {
    return Intl.message(
      'Concluded',
      name: 'agendaStatusConcluded',
      desc: '',
      args: [],
    );
  }

  /// `Delayed`
  String get agendaStatusDelayed {
    return Intl.message(
      'Delayed',
      name: 'agendaStatusDelayed',
      desc: '',
      args: [],
    );
  }

  /// `A vote was opened`
  String get hubPollOpened {
    return Intl.message(
      'A vote was opened',
      name: 'hubPollOpened',
      desc: '',
      args: [],
    );
  }

  /// `A vote was closed`
  String get hubPollClosed {
    return Intl.message(
      'A vote was closed',
      name: 'hubPollClosed',
      desc: '',
      args: [],
    );
  }

  /// `A vote was updated`
  String get hubPollUpdated {
    return Intl.message(
      'A vote was updated',
      name: 'hubPollUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Vote results published`
  String get hubPollPublished {
    return Intl.message(
      'Vote results published',
      name: 'hubPollPublished',
      desc: '',
      args: [],
    );
  }

  /// `A decision was published`
  String get hubDecisionPublished {
    return Intl.message(
      'A decision was published',
      name: 'hubDecisionPublished',
      desc: '',
      args: [],
    );
  }

  /// `A discussion was opened`
  String get hubDiscussionOpened {
    return Intl.message(
      'A discussion was opened',
      name: 'hubDiscussionOpened',
      desc: '',
      args: [],
    );
  }

  /// `A discussion was closed`
  String get hubDiscussionClosed {
    return Intl.message(
      'A discussion was closed',
      name: 'hubDiscussionClosed',
      desc: '',
      args: [],
    );
  }

  /// `A discussion was updated`
  String get hubDiscussionUpdated {
    return Intl.message(
      'A discussion was updated',
      name: 'hubDiscussionUpdated',
      desc: '',
      args: [],
    );
  }

  /// `This committee already has a chair.`
  String get errCommitteeAlreadyHasAChair {
    return Intl.message(
      'This committee already has a chair.',
      name: 'errCommitteeAlreadyHasAChair',
      desc: '',
      args: [],
    );
  }

  /// `This committee already has a secretary.`
  String get errCommitteeAlreadyHasASecretary {
    return Intl.message(
      'This committee already has a secretary.',
      name: 'errCommitteeAlreadyHasASecretary',
      desc: '',
      args: [],
    );
  }

  /// `The vote type can't be changed once votes have been cast.`
  String get errYouCanNotChangePollTypeAfterVoting {
    return Intl.message(
      'The vote type can\'t be changed once votes have been cast.',
      name: 'errYouCanNotChangePollTypeAfterVoting',
      desc: '',
      args: [],
    );
  }

  /// `Voting is only possible while the poll is open.`
  String get errPollIsNotOpen {
    return Intl.message(
      'Voting is only possible while the poll is open.',
      name: 'errPollIsNotOpen',
      desc: '',
      args: [],
    );
  }

  /// `This option doesn't belong to this poll.`
  String get errOptionIsNotInPoll {
    return Intl.message(
      'This option doesn\'t belong to this poll.',
      name: 'errOptionIsNotInPoll',
      desc: '',
      args: [],
    );
  }

  /// `A vote has already been recorded for this person on this poll.`
  String get errAlreadyVoted {
    return Intl.message(
      'A vote has already been recorded for this person on this poll.',
      name: 'errAlreadyVoted',
      desc: '',
      args: [],
    );
  }

  /// `The meeting can't move from its current status to that one.`
  String get errMeetingStatusChangeNotAllowed {
    return Intl.message(
      'The meeting can\'t move from its current status to that one.',
      name: 'errMeetingStatusChangeNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `The hall is booked for another meeting at that time.`
  String get errHallIsBooked {
    return Intl.message(
      'The hall is booked for another meeting at that time.',
      name: 'errHallIsBooked',
      desc: '',
      args: [],
    );
  }

  /// `The hall can't seat all the committee's members.`
  String get errHallCapacityExceeded {
    return Intl.message(
      'The hall can\'t seat all the committee\'s members.',
      name: 'errHallCapacityExceeded',
      desc: '',
      args: [],
    );
  }

  /// `A meeting can't be held on a weekend day.`
  String get errMeetingOnWeekend {
    return Intl.message(
      'A meeting can\'t be held on a weekend day.',
      name: 'errMeetingOnWeekend',
      desc: '',
      args: [],
    );
  }

  /// `A meeting can't be held during a holiday.`
  String get errMeetingOnHoliday {
    return Intl.message(
      'A meeting can\'t be held during a holiday.',
      name: 'errMeetingOnHoliday',
      desc: '',
      args: [],
    );
  }

  /// `The committee is inactive, so it takes no new meetings.`
  String get errCommitteeIsInactive {
    return Intl.message(
      'The committee is inactive, so it takes no new meetings.',
      name: 'errCommitteeIsInactive',
      desc: '',
      args: [],
    );
  }

  /// `Choose Arabic or English for your notifications.`
  String get errNoticeLanguageNotSupported {
    return Intl.message(
      'Choose Arabic or English for your notifications.',
      name: 'errNoticeLanguageNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `Unknown kind of notification.`
  String get errNoticeGroupUnknown {
    return Intl.message(
      'Unknown kind of notification.',
      name: 'errNoticeGroupUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Proposals are closed: the agenda is published or the meeting has started.`
  String get errAgendaRequestsClosed {
    return Intl.message(
      'Proposals are closed: the agenda is published or the meeting has started.',
      name: 'errAgendaRequestsClosed',
      desc: '',
      args: [],
    );
  }

  /// `This proposal has already been answered.`
  String get errAgendaRequestNotPending {
    return Intl.message(
      'This proposal has already been answered.',
      name: 'errAgendaRequestNotPending',
      desc: '',
      args: [],
    );
  }

  /// `Enter a title for the proposal.`
  String get errAgendaRequestTitleRequired {
    return Intl.message(
      'Enter a title for the proposal.',
      name: 'errAgendaRequestTitleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a reason.`
  String get errReasonRequired {
    return Intl.message(
      'Enter a reason.',
      name: 'errReasonRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a number of at least 1 (a percentage up to 100).`
  String get errQuorumRuleInvalid {
    return Intl.message(
      'Enter a number of at least 1 (a percentage up to 100).',
      name: 'errQuorumRuleInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Choose a valid majority.`
  String get errVotingRuleInvalid {
    return Intl.message(
      'Choose a valid majority.',
      name: 'errVotingRuleInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Give a reason for objecting or abstaining.`
  String get errVoteReasonRequired {
    return Intl.message(
      'Give a reason for objecting or abstaining.',
      name: 'errVoteReasonRequired',
      desc: '',
      args: [],
    );
  }

  /// `The reason is too long (500 characters at most).`
  String get errVoteReasonTooLong {
    return Intl.message(
      'The reason is too long (500 characters at most).',
      name: 'errVoteReasonTooLong',
      desc: '',
      args: [],
    );
  }

  /// `This voter declared an interest in the item and can't vote on it.`
  String get errInterestDeclared {
    return Intl.message(
      'This voter declared an interest in the item and can\'t vote on it.',
      name: 'errInterestDeclared',
      desc: '',
      args: [],
    );
  }

  /// `An interest in this item is already declared.`
  String get errInterestAlreadyDeclared {
    return Intl.message(
      'An interest in this item is already declared.',
      name: 'errInterestAlreadyDeclared',
      desc: '',
      args: [],
    );
  }

  /// `The note is too long (500 characters at most).`
  String get errInterestNoteTooLong {
    return Intl.message(
      'The note is too long (500 characters at most).',
      name: 'errInterestNoteTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Check-in is open only while the meeting is scheduled or running.`
  String get errCheckInClosed {
    return Intl.message(
      'Check-in is open only while the meeting is scheduled or running.',
      name: 'errCheckInClosed',
      desc: '',
      args: [],
    );
  }

  /// `The code is wrong or has expired. Scan it again.`
  String get errCheckInCodeInvalid {
    return Intl.message(
      'The code is wrong or has expired. Scan it again.',
      name: 'errCheckInCodeInvalid',
      desc: '',
      args: [],
    );
  }

  /// `You aren't invited to this meeting.`
  String get errCheckInNotInvited {
    return Intl.message(
      'You aren\'t invited to this meeting.',
      name: 'errCheckInNotInvited',
      desc: '',
      args: [],
    );
  }

  /// `Too many wrong codes. Try again in a few minutes.`
  String get errCheckInTooManyTries {
    return Intl.message(
      'Too many wrong codes. Try again in a few minutes.',
      name: 'errCheckInTooManyTries',
      desc: '',
      args: [],
    );
  }

  /// `This meeting has no online room.`
  String get errMeetingNotOnline {
    return Intl.message(
      'This meeting has no online room.',
      name: 'errMeetingNotOnline',
      desc: '',
      args: [],
    );
  }

  /// `The earlier decision must be a published decision of the same committee.`
  String get errDecisionLinkInvalid {
    return Intl.message(
      'The earlier decision must be a published decision of the same committee.',
      name: 'errDecisionLinkInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Give a reason for the reservation.`
  String get errReservationReasonRequired {
    return Intl.message(
      'Give a reason for the reservation.',
      name: 'errReservationReasonRequired',
      desc: '',
      args: [],
    );
  }

  /// `The reason can be at most 500 characters.`
  String get errReservationReasonTooLong {
    return Intl.message(
      'The reason can be at most 500 characters.',
      name: 'errReservationReasonTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Give a reason for rejecting the minutes.`
  String get errMinuteRejectionReasonRequired {
    return Intl.message(
      'Give a reason for rejecting the minutes.',
      name: 'errMinuteRejectionReasonRequired',
      desc: '',
      args: [],
    );
  }

  /// `The reason can be at most 500 characters.`
  String get errMinuteReasonTooLong {
    return Intl.message(
      'The reason can be at most 500 characters.',
      name: 'errMinuteReasonTooLong',
      desc: '',
      args: [],
    );
  }

  /// `The deadline for answering has passed.`
  String get errMinuteApprovalClosed {
    return Intl.message(
      'The deadline for answering has passed.',
      name: 'errMinuteApprovalClosed',
      desc: '',
      args: [],
    );
  }

  /// `The chair approves after the other members.`
  String get errMinuteChairApprovesLast {
    return Intl.message(
      'The chair approves after the other members.',
      name: 'errMinuteChairApprovesLast',
      desc: '',
      args: [],
    );
  }

  /// `The minutes can't be confirmed until the approval path is complete.`
  String get errMinuteApprovalsPending {
    return Intl.message(
      'The minutes can\'t be confirmed until the approval path is complete.',
      name: 'errMinuteApprovalsPending',
      desc: '',
      args: [],
    );
  }

  /// `The minutes are already confirmed.`
  String get errMinuteAlreadyFinal {
    return Intl.message(
      'The minutes are already confirmed.',
      name: 'errMinuteAlreadyFinal',
      desc: '',
      args: [],
    );
  }

  /// `Enter a title.`
  String get errCirculationTitleRequired {
    return Intl.message(
      'Enter a title.',
      name: 'errCirculationTitleRequired',
      desc: '',
      args: [],
    );
  }

  /// `The title can be at most 300 characters.`
  String get errCirculationTitleTooLong {
    return Intl.message(
      'The title can be at most 300 characters.',
      name: 'errCirculationTitleTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Enter the decision text.`
  String get errCirculationStatementRequired {
    return Intl.message(
      'Enter the decision text.',
      name: 'errCirculationStatementRequired',
      desc: '',
      args: [],
    );
  }

  /// `The deadline must be in the future.`
  String get errCirculationDeadlinePast {
    return Intl.message(
      'The deadline must be in the future.',
      name: 'errCirculationDeadlinePast',
      desc: '',
      args: [],
    );
  }

  /// `Only a draft can be changed, deleted or sent for votes.`
  String get errCirculationNotDraft {
    return Intl.message(
      'Only a draft can be changed, deleted or sent for votes.',
      name: 'errCirculationNotDraft',
      desc: '',
      args: [],
    );
  }

  /// `Voting on this decision is closed.`
  String get errCirculationNotOpen {
    return Intl.message(
      'Voting on this decision is closed.',
      name: 'errCirculationNotOpen',
      desc: '',
      args: [],
    );
  }

  /// `The committee has no members to vote.`
  String get errCirculationNoVoters {
    return Intl.message(
      'The committee has no members to vote.',
      name: 'errCirculationNoVoters',
      desc: '',
      args: [],
    );
  }

  /// `Choose approve, reject or abstain.`
  String get errCirculationChoiceInvalid {
    return Intl.message(
      'Choose approve, reject or abstain.',
      name: 'errCirculationChoiceInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The reason can be at most 500 characters.`
  String get errCirculationReasonTooLong {
    return Intl.message(
      'The reason can be at most 500 characters.',
      name: 'errCirculationReasonTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Each limit must be a whole number from 1 (warning from 0).`
  String get errComplianceRuleInvalid {
    return Intl.message(
      'Each limit must be a whole number from 1 (warning from 0).',
      name: 'errComplianceRuleInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The decision must belong to the same committee as the task.`
  String get errTaskDecisionInvalid {
    return Intl.message(
      'The decision must belong to the same committee as the task.',
      name: 'errTaskDecisionInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Pick tasks assigned to this member, and another member of the committee to move them to.`
  String get errTaskReassignInvalid {
    return Intl.message(
      'Pick tasks assigned to this member, and another member of the committee to move them to.',
      name: 'errTaskReassignInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The year must be between 1900 and 3000.`
  String get errReportYearInvalid {
    return Intl.message(
      'The year must be between 1900 and 3000.',
      name: 'errReportYearInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This account is deactivated. Contact the system administrator.`
  String get errUserSuspended {
    return Intl.message(
      'This account is deactivated. Contact the system administrator.',
      name: 'errUserSuspended',
      desc: '',
      args: [],
    );
  }

  /// `This person can't be deactivated or reactivated now (it may be your own account, or already in that state).`
  String get errPartySuspendInvalid {
    return Intl.message(
      'This person can\'t be deactivated or reactivated now (it may be your own account, or already in that state).',
      name: 'errPartySuspendInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Check the dates: a term can't end before it starts, and a temporary committee needs an end date.`
  String get errLifecycleInvalid {
    return Intl.message(
      'Check the dates: a term can\'t end before it starts, and a temporary committee needs an end date.',
      name: 'errLifecycleInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This delegation isn't possible: check the role, the member, the dates (up to a year, ending in the future), the scopes, and that it doesn't overlap another.`
  String get errDelegationInvalid {
    return Intl.message(
      'This delegation isn\'t possible: check the role, the member, the dates (up to a year, ending in the future), the scopes, and that it doesn\'t overlap another.',
      name: 'errDelegationInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This committee can't be placed there: it would be under itself, or the structure would be deeper than 5 levels.`
  String get errSubcommitteeInvalid {
    return Intl.message(
      'This committee can\'t be placed there: it would be under itself, or the structure would be deeper than 5 levels.',
      name: 'errSubcommitteeInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The recommendation can't be saved: the committee has no parent or is inactive, the text is missing or too long, or it was already answered.`
  String get errRecommendationInvalid {
    return Intl.message(
      'The recommendation can\'t be saved: the committee has no parent or is inactive, the text is missing or too long, or it was already answered.',
      name: 'errRecommendationInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The template can't be saved: 1 to 12 meetings ahead, at most 30 items, each with a title up to 500 characters and up to 600 minutes.`
  String get errPeriodicTemplateInvalid {
    return Intl.message(
      'The template can\'t be saved: 1 to 12 meetings ahead, at most 30 items, each with a title up to 500 characters and up to 600 minutes.',
      name: 'errPeriodicTemplateInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The request can't be saved: the meeting has no hall or is over, the equipment or quantity is wrong, details are missing or too long, or the request is already closed.`
  String get errHallServiceInvalid {
    return Intl.message(
      'The request can\'t be saved: the meeting has no hall or is over, the equipment or quantity is wrong, details are missing or too long, or the request is already closed.',
      name: 'errHallServiceInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This can't be done now: the meeting isn't in progress, the item belongs to another meeting, or the length is outside 1 second to 8 hours.`
  String get errLiveInvalid {
    return Intl.message(
      'This can\'t be done now: the meeting isn\'t in progress, the item belongs to another meeting, or the length is outside 1 second to 8 hours.',
      name: 'errLiveInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This step on the speaker queue doesn't apply now (the meeting isn't in progress, you have already asked, nobody is waiting, or the limit is over an hour).`
  String get errSpeakerInvalid {
    return Intl.message(
      'This step on the speaker queue doesn\'t apply now (the meeting isn\'t in progress, you have already asked, nobody is waiting, or the limit is over an hour).',
      name: 'errSpeakerInvalid',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to do this.`
  String get errYouDoNotHavePermission {
    return Intl.message(
      'You don\'t have permission to do this.',
      name: 'errYouDoNotHavePermission',
      desc: '',
      args: [],
    );
  }

  /// `You aren't authorized to do this.`
  String get errUnauthorizedUser {
    return Intl.message(
      'You aren\'t authorized to do this.',
      name: 'errUnauthorizedUser',
      desc: '',
      args: [],
    );
  }

  /// `The item wasn't found.`
  String get errNotFound {
    return Intl.message(
      'The item wasn\'t found.',
      name: 'errNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Some of the data isn't valid.`
  String get errValidationError {
    return Intl.message(
      'Some of the data isn\'t valid.',
      name: 'errValidationError',
      desc: '',
      args: [],
    );
  }

  /// `In person`
  String get meetingModeInPerson {
    return Intl.message(
      'In person',
      name: 'meetingModeInPerson',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get meetingModeOnline {
    return Intl.message(
      'Online',
      name: 'meetingModeOnline',
      desc: '',
      args: [],
    );
  }

  /// `Hybrid (in person and online)`
  String get meetingModeHybrid {
    return Intl.message(
      'Hybrid (in person and online)',
      name: 'meetingModeHybrid',
      desc: '',
      args: [],
    );
  }

  /// `Hijri`
  String get hijriDate {
    return Intl.message('Hijri', name: 'hijriDate', desc: '', args: []);
  }

  /// `Reason`
  String get voteReason {
    return Intl.message('Reason', name: 'voteReason', desc: '', args: []);
  }

  /// `Why do you object or abstain?`
  String get voteReasonHint {
    return Intl.message(
      'Why do you object or abstain?',
      name: 'voteReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `Passed`
  String get pollOutcomePassed {
    return Intl.message(
      'Passed',
      name: 'pollOutcomePassed',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get pollOutcomeRejected {
    return Intl.message(
      'Rejected',
      name: 'pollOutcomeRejected',
      desc: '',
      args: [],
    );
  }

  /// `Tied`
  String get pollOutcomeTied {
    return Intl.message('Tied', name: 'pollOutcomeTied', desc: '', args: []);
  }

  /// `decided by the chair`
  String get decidedByChair {
    return Intl.message(
      'decided by the chair',
      name: 'decidedByChair',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message('Withdraw', name: 'withdraw', desc: '', args: []);
  }

  /// `Withdraw this guest suggestion?`
  String get withdrawSuggestionConfirm {
    return Intl.message(
      'Withdraw this guest suggestion?',
      name: 'withdrawSuggestionConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Live now`
  String get liveNow {
    return Intl.message('Live now', name: 'liveNow', desc: '', args: []);
  }

  /// `Quorum met: {present} of {required}`
  String quorumMet(Object present, Object required) {
    return Intl.message(
      'Quorum met: $present of $required',
      name: 'quorumMet',
      desc: '',
      args: [present, required],
    );
  }

  /// `No quorum: {present} of {required}`
  String quorumNotMet(Object present, Object required) {
    return Intl.message(
      'No quorum: $present of $required',
      name: 'quorumNotMet',
      desc: '',
      args: [present, required],
    );
  }

  /// `No agenda item on screen`
  String get liveNoItem {
    return Intl.message(
      'No agenda item on screen',
      name: 'liveNoItem',
      desc: '',
      args: [],
    );
  }

  /// `On screen`
  String get liveCurrentItem {
    return Intl.message(
      'On screen',
      name: 'liveCurrentItem',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get livePaused {
    return Intl.message('Paused', name: 'livePaused', desc: '', args: []);
  }

  /// `Nobody has the floor`
  String get liveNobodySpeaking {
    return Intl.message(
      'Nobody has the floor',
      name: 'liveNobodySpeaking',
      desc: '',
      args: [],
    );
  }

  /// `Speaking`
  String get liveSpeaking {
    return Intl.message('Speaking', name: 'liveSpeaking', desc: '', args: []);
  }

  /// `Waiting ({count})`
  String liveQueue(Object count) {
    return Intl.message(
      'Waiting ($count)',
      name: 'liveQueue',
      desc: '',
      args: [count],
    );
  }

  /// `Point of order`
  String get pointOfOrder {
    return Intl.message(
      'Point of order',
      name: 'pointOfOrder',
      desc: '',
      args: [],
    );
  }

  /// `You have the floor`
  String get liveYourTurn {
    return Intl.message(
      'You have the floor',
      name: 'liveYourTurn',
      desc: '',
      args: [],
    );
  }

  /// `You are number {place} in the queue`
  String liveYourPlace(Object place) {
    return Intl.message(
      'You are number $place in the queue',
      name: 'liveYourPlace',
      desc: '',
      args: [place],
    );
  }

  /// `Your request was sent`
  String get liveRequestSent {
    return Intl.message(
      'Your request was sent',
      name: 'liveRequestSent',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get liveWithdraw {
    return Intl.message('Withdraw', name: 'liveWithdraw', desc: '', args: []);
  }

  /// `Ask to speak`
  String get liveAskToSpeak {
    return Intl.message(
      'Ask to speak',
      name: 'liveAskToSpeak',
      desc: '',
      args: [],
    );
  }

  /// `Check in`
  String get checkIn {
    return Intl.message('Check in', name: 'checkIn', desc: '', args: []);
  }

  /// `Point the camera at the QR code at the hall door.`
  String get checkInScanHint {
    return Intl.message(
      'Point the camera at the QR code at the hall door.',
      name: 'checkInScanHint',
      desc: '',
      args: [],
    );
  }

  /// `Type the six-digit code shown under the QR`
  String get checkInTypeCode {
    return Intl.message(
      'Type the six-digit code shown under the QR',
      name: 'checkInTypeCode',
      desc: '',
      args: [],
    );
  }

  /// `This code is for another meeting.`
  String get checkInOtherMeeting {
    return Intl.message(
      'This code is for another meeting.',
      name: 'checkInOtherMeeting',
      desc: '',
      args: [],
    );
  }

  /// `Allow camera access in the settings to scan, or type the code below.`
  String get cameraPermissionDenied {
    return Intl.message(
      'Allow camera access in the settings to scan, or type the code below.',
      name: 'cameraPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `The camera isn't available. Type the code below.`
  String get cameraUnavailable {
    return Intl.message(
      'The camera isn\'t available. Type the code below.',
      name: 'cameraUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `You're checked in`
  String get checkInDone {
    return Intl.message(
      'You\'re checked in',
      name: 'checkInDone',
      desc: '',
      args: [],
    );
  }

  /// `You were already checked in`
  String get checkInAlready {
    return Intl.message(
      'You were already checked in',
      name: 'checkInAlready',
      desc: '',
      args: [],
    );
  }

  /// `at`
  String get checkInAt {
    return Intl.message('at', name: 'checkInAt', desc: '', args: []);
  }

  /// `in the hall`
  String get checkInInHall {
    return Intl.message(
      'in the hall',
      name: 'checkInInHall',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get checkInOnline {
    return Intl.message('online', name: 'checkInOnline', desc: '', args: []);
  }

  /// `Record your arrival with the QR code at the hall door.`
  String get checkInCardHint {
    return Intl.message(
      'Record your arrival with the QR code at the hall door.',
      name: 'checkInCardHint',
      desc: '',
      args: [],
    );
  }

  /// `Checked in at`
  String get checkedInAt {
    return Intl.message(
      'Checked in at',
      name: 'checkedInAt',
      desc: '',
      args: [],
    );
  }

  /// `Hall check-in`
  String get checkInCardTitle {
    return Intl.message(
      'Hall check-in',
      name: 'checkInCardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan the code`
  String get checkInScanButton {
    return Intl.message(
      'Scan the code',
      name: 'checkInScanButton',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Declare an interest`
  String get declareInterest {
    return Intl.message(
      'Declare an interest',
      name: 'declareInterest',
      desc: '',
      args: [],
    );
  }

  /// `Declare`
  String get declare {
    return Intl.message('Declare', name: 'declare', desc: '', args: []);
  }

  /// `You will be left out of this item's quorum and majority, and you may not be able to vote on its polls.`
  String get declareInterestHint {
    return Intl.message(
      'You will be left out of this item\'s quorum and majority, and you may not be able to vote on its polls.',
      name: 'declareInterestHint',
      desc: '',
      args: [],
    );
  }

  /// `Note (optional)`
  String get interestNoteOptional {
    return Intl.message(
      'Note (optional)',
      name: 'interestNoteOptional',
      desc: '',
      args: [],
    );
  }

  /// `Briefly describe the interest`
  String get interestNoteHint {
    return Intl.message(
      'Briefly describe the interest',
      name: 'interestNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `You declared an interest in this item`
  String get interestDeclared {
    return Intl.message(
      'You declared an interest in this item',
      name: 'interestDeclared',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw disclosure`
  String get withdrawInterest {
    return Intl.message(
      'Withdraw disclosure',
      name: 'withdrawInterest',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw your disclosure?`
  String get withdrawInterestTitle {
    return Intl.message(
      'Withdraw your disclosure?',
      name: 'withdrawInterestTitle',
      desc: '',
      args: [],
    );
  }

  /// `You will count again in this item's quorum and voting.`
  String get withdrawInterestDescription {
    return Intl.message(
      'You will count again in this item\'s quorum and voting.',
      name: 'withdrawInterestDescription',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get agendaRequestPending {
    return Intl.message(
      'Pending',
      name: 'agendaRequestPending',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get agendaRequestAccepted {
    return Intl.message(
      'Accepted',
      name: 'agendaRequestAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get agendaRequestRejected {
    return Intl.message(
      'Rejected',
      name: 'agendaRequestRejected',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get agendaRequestClosed {
    return Intl.message(
      'Closed',
      name: 'agendaRequestClosed',
      desc: '',
      args: [],
    );
  }

  /// `Agenda proposals`
  String get agendaProposals {
    return Intl.message(
      'Agenda proposals',
      name: 'agendaProposals',
      desc: '',
      args: [],
    );
  }

  /// `Suggest an item before the agenda is published.`
  String get agendaProposalsHint {
    return Intl.message(
      'Suggest an item before the agenda is published.',
      name: 'agendaProposalsHint',
      desc: '',
      args: [],
    );
  }

  /// `Proposals are closed for this meeting.`
  String get agendaProposalsClosed {
    return Intl.message(
      'Proposals are closed for this meeting.',
      name: 'agendaProposalsClosed',
      desc: '',
      args: [],
    );
  }

  /// `Propose an item`
  String get proposeItem {
    return Intl.message(
      'Propose an item',
      name: 'proposeItem',
      desc: '',
      args: [],
    );
  }

  /// `The secretary reviews it and may add it to the agenda.`
  String get proposeItemHint {
    return Intl.message(
      'The secretary reviews it and may add it to the agenda.',
      name: 'proposeItemHint',
      desc: '',
      args: [],
    );
  }

  /// `My proposals ({count})`
  String myProposals(Object count) {
    return Intl.message(
      'My proposals ($count)',
      name: 'myProposals',
      desc: '',
      args: [count],
    );
  }

  /// `Withdraw`
  String get withdrawProposal {
    return Intl.message(
      'Withdraw',
      name: 'withdrawProposal',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw this proposal?`
  String get withdrawProposalTitle {
    return Intl.message(
      'Withdraw this proposal?',
      name: 'withdrawProposalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get rejectionReason {
    return Intl.message('Reason', name: 'rejectionReason', desc: '', args: []);
  }

  /// `Item title`
  String get proposalTitle {
    return Intl.message(
      'Item title',
      name: 'proposalTitle',
      desc: '',
      args: [],
    );
  }

  /// `What should be discussed?`
  String get proposalTitleHint {
    return Intl.message(
      'What should be discussed?',
      name: 'proposalTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Details (optional)`
  String get proposalNoteOptional {
    return Intl.message(
      'Details (optional)',
      name: 'proposalNoteOptional',
      desc: '',
      args: [],
    );
  }

  /// `Background, why it matters…`
  String get proposalNoteHint {
    return Intl.message(
      'Background, why it matters…',
      name: 'proposalNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Attach a file (optional)`
  String get attachFileOptional {
    return Intl.message(
      'Attach a file (optional)',
      name: 'attachFileOptional',
      desc: '',
      args: [],
    );
  }

  /// `Up to 10 MB`
  String get attachmentLimit {
    return Intl.message(
      'Up to 10 MB',
      name: 'attachmentLimit',
      desc: '',
      args: [],
    );
  }

  /// `The file is larger than 10 MB.`
  String get attachmentTooLarge {
    return Intl.message(
      'The file is larger than 10 MB.',
      name: 'attachmentTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `Remove the file`
  String get removeAttachment {
    return Intl.message(
      'Remove the file',
      name: 'removeAttachment',
      desc: '',
      args: [],
    );
  }

  /// `Send proposal`
  String get sendProposal {
    return Intl.message(
      'Send proposal',
      name: 'sendProposal',
      desc: '',
      args: [],
    );
  }

  /// `Your proposal was sent`
  String get proposalSent {
    return Intl.message(
      'Your proposal was sent',
      name: 'proposalSent',
      desc: '',
      args: [],
    );
  }

  /// `Draft`
  String get circulationDraft {
    return Intl.message('Draft', name: 'circulationDraft', desc: '', args: []);
  }

  /// `Open`
  String get circulationOpen {
    return Intl.message('Open', name: 'circulationOpen', desc: '', args: []);
  }

  /// `Closed`
  String get circulationClosed {
    return Intl.message(
      'Closed',
      name: 'circulationClosed',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawn`
  String get circulationWithdrawn {
    return Intl.message(
      'Withdrawn',
      name: 'circulationWithdrawn',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get circulationApprove {
    return Intl.message(
      'Approve',
      name: 'circulationApprove',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get circulationReject {
    return Intl.message(
      'Reject',
      name: 'circulationReject',
      desc: '',
      args: [],
    );
  }

  /// `Abstain`
  String get circulationAbstain {
    return Intl.message(
      'Abstain',
      name: 'circulationAbstain',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get circulationApproved {
    return Intl.message(
      'Approved',
      name: 'circulationApproved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get circulationRejected {
    return Intl.message(
      'Rejected',
      name: 'circulationRejected',
      desc: '',
      args: [],
    );
  }

  /// `Decisions by circulation`
  String get circulations {
    return Intl.message(
      'Decisions by circulation',
      name: 'circulations',
      desc: '',
      args: [],
    );
  }

  /// `Vote on decisions without a meeting`
  String get circulationsSubtitle {
    return Intl.message(
      'Vote on decisions without a meeting',
      name: 'circulationsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} awaiting your vote`
  String circulationsAwaiting(Object count) {
    return Intl.message(
      '$count awaiting your vote',
      name: 'circulationsAwaiting',
      desc: '',
      args: [count],
    );
  }

  /// `Decision by circulation`
  String get circulation {
    return Intl.message(
      'Decision by circulation',
      name: 'circulation',
      desc: '',
      args: [],
    );
  }

  /// `No decisions by circulation`
  String get noCirculations {
    return Intl.message(
      'No decisions by circulation',
      name: 'noCirculations',
      desc: '',
      args: [],
    );
  }

  /// `Decisions the secretary sends for votes will appear here.`
  String get noCirculationsDescription {
    return Intl.message(
      'Decisions the secretary sends for votes will appear here.',
      name: 'noCirculationsDescription',
      desc: '',
      args: [],
    );
  }

  /// `This decision couldn't be loaded`
  String get circulationNotFound {
    return Intl.message(
      'This decision couldn\'t be loaded',
      name: 'circulationNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Closes in {days}d {hours}h`
  String closesInDaysHours(Object days, Object hours) {
    return Intl.message(
      'Closes in ${days}d ${hours}h',
      name: 'closesInDaysHours',
      desc: '',
      args: [days, hours],
    );
  }

  /// `Closes in {hours}h {minutes}m`
  String closesInHoursMinutes(Object hours, Object minutes) {
    return Intl.message(
      'Closes in ${hours}h ${minutes}m',
      name: 'closesInHoursMinutes',
      desc: '',
      args: [hours, minutes],
    );
  }

  /// `Closes in {minutes}m`
  String closesInMinutes(Object minutes) {
    return Intl.message(
      'Closes in ${minutes}m',
      name: 'closesInMinutes',
      desc: '',
      args: [minutes],
    );
  }

  /// `Deadline passed`
  String get deadlinePassed {
    return Intl.message(
      'Deadline passed',
      name: 'deadlinePassed',
      desc: '',
      args: [],
    );
  }

  /// `No deadline`
  String get noDeadline {
    return Intl.message('No deadline', name: 'noDeadline', desc: '', args: []);
  }

  /// `Deadline`
  String get deadline {
    return Intl.message('Deadline', name: 'deadline', desc: '', args: []);
  }

  /// `Closed`
  String get closedAt {
    return Intl.message('Closed', name: 'closedAt', desc: '', args: []);
  }

  /// `{voted} of {total} voted`
  String votesCount(Object voted, Object total) {
    return Intl.message(
      '$voted of $total voted',
      name: 'votesCount',
      desc: '',
      args: [voted, total],
    );
  }

  /// `Awaiting your vote`
  String get awaitingYourVote {
    return Intl.message(
      'Awaiting your vote',
      name: 'awaitingYourVote',
      desc: '',
      args: [],
    );
  }

  /// `Your vote: {choice}`
  String yourVoteIs(Object choice) {
    return Intl.message(
      'Your vote: $choice',
      name: 'yourVoteIs',
      desc: '',
      args: [choice],
    );
  }

  /// `Approval`
  String get approvalWeight {
    return Intl.message('Approval', name: 'approvalWeight', desc: '', args: []);
  }

  /// `Approved when approvals pass half of all voters' weight. Abstaining and not voting count against.`
  String get approvalNeedsHalf {
    return Intl.message(
      'Approved when approvals pass half of all voters\' weight. Abstaining and not voting count against.',
      name: 'approvalNeedsHalf',
      desc: '',
      args: [],
    );
  }

  /// `Not voted`
  String get notVotedYet {
    return Intl.message('Not voted', name: 'notVotedYet', desc: '', args: []);
  }

  /// `Not voted yet ({count})`
  String notVotedYetCount(Object count) {
    return Intl.message(
      'Not voted yet ($count)',
      name: 'notVotedYetCount',
      desc: '',
      args: [count],
    );
  }

  /// `Result`
  String get circulationResult {
    return Intl.message(
      'Result',
      name: 'circulationResult',
      desc: '',
      args: [],
    );
  }

  /// `Tally so far`
  String get tallySoFar {
    return Intl.message('Tally so far', name: 'tallySoFar', desc: '', args: []);
  }

  /// `Decision text`
  String get decisionText {
    return Intl.message(
      'Decision text',
      name: 'decisionText',
      desc: '',
      args: [],
    );
  }

  /// `Attachment`
  String get attachment {
    return Intl.message('Attachment', name: 'attachment', desc: '', args: []);
  }

  /// `You voted {choice}. You can change it until it closes.`
  String youVotedCanChange(Object choice) {
    return Intl.message(
      'You voted $choice. You can change it until it closes.',
      name: 'youVotedCanChange',
      desc: '',
      args: [choice],
    );
  }

  /// `Reason (optional)`
  String get reasonOptional {
    return Intl.message(
      'Reason (optional)',
      name: 'reasonOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add a short reason for your vote`
  String get circulationReasonHint {
    return Intl.message(
      'Add a short reason for your vote',
      name: 'circulationReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `Submit vote`
  String get submitVote {
    return Intl.message('Submit vote', name: 'submitVote', desc: '', args: []);
  }

  /// `Change vote`
  String get changeVote {
    return Intl.message('Change vote', name: 'changeVote', desc: '', args: []);
  }

  /// `Your vote was saved`
  String get circulationVoteSaved {
    return Intl.message(
      'Your vote was saved',
      name: 'circulationVoteSaved',
      desc: '',
      args: [],
    );
  }

  /// `You are not a voter on this decision.`
  String get notACirculationVoter {
    return Intl.message(
      'You are not a voter on this decision.',
      name: 'notACirculationVoter',
      desc: '',
      args: [],
    );
  }

  /// `The deadline has passed; voting is closed.`
  String get circulationVotingClosed {
    return Intl.message(
      'The deadline has passed; voting is closed.',
      name: 'circulationVotingClosed',
      desc: '',
      args: [],
    );
  }

  /// `Votes ({count})`
  String circulationVotes(Object count) {
    return Intl.message(
      'Votes ($count)',
      name: 'circulationVotes',
      desc: '',
      args: [count],
    );
  }

  /// `Try again`
  String get retry {
    return Intl.message('Try again', name: 'retry', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Quorum`
  String get quorumTitle {
    return Intl.message('Quorum', name: 'quorumTitle', desc: '', args: []);
  }

  /// `Met`
  String get quorumStatusMet {
    return Intl.message('Met', name: 'quorumStatusMet', desc: '', args: []);
  }

  /// `Not met`
  String get quorumStatusNotMet {
    return Intl.message(
      'Not met',
      name: 'quorumStatusNotMet',
      desc: '',
      args: [],
    );
  }

  /// `{present} present of {required} required`
  String quorumPresentOfRequired(Object present, Object required) {
    return Intl.message(
      '$present present of $required required',
      name: 'quorumPresentOfRequired',
      desc: '',
      args: [present, required],
    );
  }

  /// `{hall} in the hall · {remote} remote`
  String quorumSplit(Object hall, Object remote) {
    return Intl.message(
      '$hall in the hall · $remote remote',
      name: 'quorumSplit',
      desc: '',
      args: [hall, remote],
    );
  }

  /// `Includes {count} by proxy`
  String quorumProxies(Object count) {
    return Intl.message(
      'Includes $count by proxy',
      name: 'quorumProxies',
      desc: '',
      args: [count],
    );
  }

  /// `The chair has to attend for the quorum to count.`
  String get quorumChairRequired {
    return Intl.message(
      'The chair has to attend for the quorum to count.',
      name: 'quorumChairRequired',
      desc: '',
      args: [],
    );
  }

  /// `Recorded when the meeting started, at {time}`
  String quorumRecordedAt(Object time) {
    return Intl.message(
      'Recorded when the meeting started, at $time',
      name: 'quorumRecordedAt',
      desc: '',
      args: [time],
    );
  }

  /// `Needs {value} members`
  String quorumRuleCount(Object value) {
    return Intl.message(
      'Needs $value members',
      name: 'quorumRuleCount',
      desc: '',
      args: [value],
    );
  }

  /// `Needs {value}% of {base} members`
  String quorumRulePercent(Object value, Object base) {
    return Intl.message(
      'Needs $value% of $base members',
      name: 'quorumRulePercent',
      desc: '',
      args: [value, base],
    );
  }

  /// `Controls`
  String get liveControls {
    return Intl.message('Controls', name: 'liveControls', desc: '', args: []);
  }

  /// `Start`
  String get liveStart {
    return Intl.message('Start', name: 'liveStart', desc: '', args: []);
  }

  /// `Pause`
  String get livePause {
    return Intl.message('Pause', name: 'livePause', desc: '', args: []);
  }

  /// `Reset`
  String get liveReset {
    return Intl.message('Reset', name: 'liveReset', desc: '', args: []);
  }

  /// `Reset this item's timer?`
  String get liveResetTitle {
    return Intl.message(
      'Reset this item\'s timer?',
      name: 'liveResetTitle',
      desc: '',
      args: [],
    );
  }

  /// `The time spent so far will be cleared.`
  String get liveResetDescription {
    return Intl.message(
      'The time spent so far will be cleared.',
      name: 'liveResetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Take off a minute`
  String get liveMinusMinute {
    return Intl.message(
      'Take off a minute',
      name: 'liveMinusMinute',
      desc: '',
      args: [],
    );
  }

  /// `Add a minute`
  String get livePlusMinute {
    return Intl.message(
      'Add a minute',
      name: 'livePlusMinute',
      desc: '',
      args: [],
    );
  }

  /// `Change item`
  String get liveChangeItem {
    return Intl.message(
      'Change item',
      name: 'liveChangeItem',
      desc: '',
      args: [],
    );
  }

  /// `Put an item on screen`
  String get livePickItem {
    return Intl.message(
      'Put an item on screen',
      name: 'livePickItem',
      desc: '',
      args: [],
    );
  }

  /// `Item on screen`
  String get livePickItemTitle {
    return Intl.message(
      'Item on screen',
      name: 'livePickItemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Clear the screen`
  String get liveClearScreen {
    return Intl.message(
      'Clear the screen',
      name: 'liveClearScreen',
      desc: '',
      args: [],
    );
  }

  /// `Next speaker`
  String get liveNextSpeaker {
    return Intl.message(
      'Next speaker',
      name: 'liveNextSpeaker',
      desc: '',
      args: [],
    );
  }

  /// `End turn`
  String get liveEndSpeaker {
    return Intl.message('End turn', name: 'liveEndSpeaker', desc: '', args: []);
  }

  /// `Give the floor`
  String get liveGiveFloor {
    return Intl.message(
      'Give the floor',
      name: 'liveGiveFloor',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get liveSkip {
    return Intl.message('Skip', name: 'liveSkip', desc: '', args: []);
  }

  /// `Time per speaker: {time}`
  String liveSpeakerLimit(Object time) {
    return Intl.message(
      'Time per speaker: $time',
      name: 'liveSpeakerLimit',
      desc: '',
      args: [time],
    );
  }

  /// `Time per speaker`
  String get liveSpeakerLimitTitle {
    return Intl.message(
      'Time per speaker',
      name: 'liveSpeakerLimitTitle',
      desc: '',
      args: [],
    );
  }

  /// `Applies to the next speakers.`
  String get liveSpeakerLimitHint {
    return Intl.message(
      'Applies to the next speakers.',
      name: 'liveSpeakerLimitHint',
      desc: '',
      args: [],
    );
  }

  /// `No limit`
  String get liveNoLimit {
    return Intl.message('No limit', name: 'liveNoLimit', desc: '', args: []);
  }

  /// `{count} min`
  String liveMinutes(Object count) {
    return Intl.message(
      '$count min',
      name: 'liveMinutes',
      desc: '',
      args: [count],
    );
  }

  /// `Hall QR`
  String get checkInCodeTitle {
    return Intl.message(
      'Hall QR',
      name: 'checkInCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Attendees scan this code with the app to check in.`
  String get checkInCodeHint {
    return Intl.message(
      'Attendees scan this code with the app to check in.',
      name: 'checkInCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `New code in {seconds} s`
  String checkInCodeNext(Object seconds) {
    return Intl.message(
      'New code in $seconds s',
      name: 'checkInCodeNext',
      desc: '',
      args: [seconds],
    );
  }

  /// `The code isn't available`
  String get checkInCodeUnavailable {
    return Intl.message(
      'The code isn\'t available',
      name: 'checkInCodeUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Show the hall QR`
  String get checkInCodeShow {
    return Intl.message(
      'Show the hall QR',
      name: 'checkInCodeShow',
      desc: '',
      args: [],
    );
  }

  /// `Display it on a tablet at the door for check-in.`
  String get checkInCodeShowHint {
    return Intl.message(
      'Display it on a tablet at the door for check-in.',
      name: 'checkInCodeShowHint',
      desc: '',
      args: [],
    );
  }

  /// `Delegations`
  String get delegations {
    return Intl.message('Delegations', name: 'delegations', desc: '', args: []);
  }

  /// `No delegations`
  String get noDelegations {
    return Intl.message(
      'No delegations',
      name: 'noDelegations',
      desc: '',
      args: [],
    );
  }

  /// `Hand your role to another member for a period, for example before travelling.`
  String get noDelegationsDescription {
    return Intl.message(
      'Hand your role to another member for a period, for example before travelling.',
      name: 'noDelegationsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add delegation`
  String get addDelegation {
    return Intl.message(
      'Add delegation',
      name: 'addDelegation',
      desc: '',
      args: [],
    );
  }

  /// `You keep your role meanwhile. The member acts for you only in the areas you choose.`
  String get addDelegationHint {
    return Intl.message(
      'You keep your role meanwhile. The member acts for you only in the areas you choose.',
      name: 'addDelegationHint',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get delegationRole {
    return Intl.message('Role', name: 'delegationRole', desc: '', args: []);
  }

  /// `Delegate to`
  String get delegateTo {
    return Intl.message('Delegate to', name: 'delegateTo', desc: '', args: []);
  }

  /// `There are no other members in this committee.`
  String get noDelegationCandidates {
    return Intl.message(
      'There are no other members in this committee.',
      name: 'noDelegationCandidates',
      desc: '',
      args: [],
    );
  }

  /// `Areas`
  String get delegationScopes {
    return Intl.message('Areas', name: 'delegationScopes', desc: '', args: []);
  }

  /// `Select all`
  String get selectAll {
    return Intl.message('Select all', name: 'selectAll', desc: '', args: []);
  }

  /// `Clear all`
  String get clearAll {
    return Intl.message('Clear all', name: 'clearAll', desc: '', args: []);
  }

  /// `Period`
  String get delegationPeriod {
    return Intl.message('Period', name: 'delegationPeriod', desc: '', args: []);
  }

  /// `Starts`
  String get delegationStarts {
    return Intl.message('Starts', name: 'delegationStarts', desc: '', args: []);
  }

  /// `Ends`
  String get delegationEnds {
    return Intl.message('Ends', name: 'delegationEnds', desc: '', args: []);
  }

  /// `Up to a year. It ends at the end of the last day.`
  String get delegationPeriodHint {
    return Intl.message(
      'Up to a year. It ends at the end of the last day.',
      name: 'delegationPeriodHint',
      desc: '',
      args: [],
    );
  }

  /// `Reason (optional)`
  String get delegationReasonOptional {
    return Intl.message(
      'Reason (optional)',
      name: 'delegationReasonOptional',
      desc: '',
      args: [],
    );
  }

  /// `For example: travelling for a conference`
  String get delegationReasonHint {
    return Intl.message(
      'For example: travelling for a conference',
      name: 'delegationReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `Delegate`
  String get delegateAction {
    return Intl.message('Delegate', name: 'delegateAction', desc: '', args: []);
  }

  /// `The delegation was added`
  String get delegationAdded {
    return Intl.message(
      'The delegation was added',
      name: 'delegationAdded',
      desc: '',
      args: [],
    );
  }

  /// `From {from} to {to}`
  String delegationFromTo(Object from, Object to) {
    return Intl.message(
      'From $from to $to',
      name: 'delegationFromTo',
      desc: '',
      args: [from, to],
    );
  }

  /// `All areas`
  String get delegationAllScopes {
    return Intl.message(
      'All areas',
      name: 'delegationAllScopes',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get delegationUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'delegationUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get delegationActive {
    return Intl.message('Active', name: 'delegationActive', desc: '', args: []);
  }

  /// `Ended`
  String get delegationEnded {
    return Intl.message('Ended', name: 'delegationEnded', desc: '', args: []);
  }

  /// `Revoked`
  String get delegationRevokedState {
    return Intl.message(
      'Revoked',
      name: 'delegationRevokedState',
      desc: '',
      args: [],
    );
  }

  /// `Revoke`
  String get revokeDelegation {
    return Intl.message('Revoke', name: 'revokeDelegation', desc: '', args: []);
  }

  /// `Revoke this delegation?`
  String get revokeDelegationTitle {
    return Intl.message(
      'Revoke this delegation?',
      name: 'revokeDelegationTitle',
      desc: '',
      args: [],
    );
  }

  /// `{name} will stop acting for you right away.`
  String revokeDelegationFromMe(Object name) {
    return Intl.message(
      '$name will stop acting for you right away.',
      name: 'revokeDelegationFromMe',
      desc: '',
      args: [name],
    );
  }

  /// `You will stop acting in this role right away.`
  String get revokeDelegationToMe {
    return Intl.message(
      'You will stop acting in this role right away.',
      name: 'revokeDelegationToMe',
      desc: '',
      args: [],
    );
  }

  /// `The delegation was revoked`
  String get delegationRevoked {
    return Intl.message(
      'The delegation was revoked',
      name: 'delegationRevoked',
      desc: '',
      args: [],
    );
  }

  /// `You are acting as {role}`
  String actingAs(Object role) {
    return Intl.message(
      'You are acting as $role',
      name: 'actingAs',
      desc: '',
      args: [role],
    );
  }

  /// `You are acting as {role} until {date}`
  String actingAsUntil(Object role, Object date) {
    return Intl.message(
      'You are acting as $role until $date',
      name: 'actingAsUntil',
      desc: '',
      args: [role, date],
    );
  }

  /// `Delegated by {name}`
  String delegatedBy(Object name) {
    return Intl.message(
      'Delegated by $name',
      name: 'delegatedBy',
      desc: '',
      args: [name],
    );
  }

  /// `Meetings`
  String get scopeMeetings {
    return Intl.message('Meetings', name: 'scopeMeetings', desc: '', args: []);
  }

  /// `Minutes`
  String get scopeMinutes {
    return Intl.message('Minutes', name: 'scopeMinutes', desc: '', args: []);
  }

  /// `Decisions`
  String get scopeDecisions {
    return Intl.message(
      'Decisions',
      name: 'scopeDecisions',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get scopeMembers {
    return Intl.message('Members', name: 'scopeMembers', desc: '', args: []);
  }

  /// `Tasks`
  String get scopeTasks {
    return Intl.message('Tasks', name: 'scopeTasks', desc: '', args: []);
  }

  /// `Rules`
  String get scopeRules {
    return Intl.message('Rules', name: 'scopeRules', desc: '', args: []);
  }

  /// `Reports`
  String get scopeReports {
    return Intl.message('Reports', name: 'scopeReports', desc: '', args: []);
  }

  /// `Members' proposals`
  String get reviewProposals {
    return Intl.message(
      'Members\' proposals',
      name: 'reviewProposals',
      desc: '',
      args: [],
    );
  }

  /// `Reject with a reason, or accept once the item is on the agenda.`
  String get reviewProposalsHint {
    return Intl.message(
      'Reject with a reason, or accept once the item is on the agenda.',
      name: 'reviewProposalsHint',
      desc: '',
      args: [],
    );
  }

  /// `{count} pending`
  String pendingCount(Object count) {
    return Intl.message(
      '$count pending',
      name: 'pendingCount',
      desc: '',
      args: [count],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Reject this proposal?`
  String get rejectProposalTitle {
    return Intl.message(
      'Reject this proposal?',
      name: 'rejectProposalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tell the member why`
  String get rejectProposalHint {
    return Intl.message(
      'Tell the member why',
      name: 'rejectProposalHint',
      desc: '',
      args: [],
    );
  }

  /// `The proposal was rejected`
  String get proposalRejected {
    return Intl.message(
      'The proposal was rejected',
      name: 'proposalRejected',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get acceptProposal {
    return Intl.message('Accept', name: 'acceptProposal', desc: '', args: []);
  }

  /// `Add the item to the agenda on the web first, then accept the proposal here.`
  String get acceptNeedsAgendaItem {
    return Intl.message(
      'Add the item to the agenda on the web first, then accept the proposal here.',
      name: 'acceptNeedsAgendaItem',
      desc: '',
      args: [],
    );
  }

  /// `The proposal was accepted`
  String get proposalAccepted {
    return Intl.message(
      'The proposal was accepted',
      name: 'proposalAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Which agenda item is it?`
  String get acceptProposalTitle {
    return Intl.message(
      'Which agenda item is it?',
      name: 'acceptProposalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose the item you added for this proposal.`
  String get acceptProposalHint {
    return Intl.message(
      'Choose the item you added for this proposal.',
      name: 'acceptProposalHint',
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
