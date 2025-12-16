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

  /// `Foot Duel App`
  String get appTitle {
    return Intl.message('Foot Duel App', name: 'appTitle', desc: '', args: []);
  }

  /// `Test your knowledge, compete, and win`
  String get appSubtitle {
    return Intl.message(
      'Test your knowledge, compete, and win',
      name: 'appSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Home`
  String get homeTitle {
    return Intl.message('Home', name: 'homeTitle', desc: '', args: []);
  }

  /// `Welcome to the quiz app`
  String get welcome {
    return Intl.message(
      'Welcome to the quiz app',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Start your journey now!`
  String get startJourney {
    return Intl.message(
      'Start your journey now!',
      name: 'startJourney',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to enjoy the best quizzes`
  String get startJourneyWithSign {
    return Intl.message(
      'Sign in to enjoy the best quizzes',
      name: 'startJourneyWithSign',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Create account`
  String get register {
    return Intl.message('Create account', name: 'register', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Start playing now!`
  String get startGame {
    return Intl.message(
      'Start playing now!',
      name: 'startGame',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get enterEmail {
    return Intl.message(
      'Email address',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get PleaseEnterEmail {
    return Intl.message(
      'Please Enter Your Email',
      name: 'PleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get enterLogin {
    return Intl.message('Login', name: 'enterLogin', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `have an account?`
  String get HaveAccount {
    return Intl.message(
      'have an account?',
      name: 'HaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up for free`
  String get signUpFree {
    return Intl.message(
      'Sign up for free',
      name: 'signUpFree',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Error`
  String get firebaseAuthErrorTitle {
    return Intl.message(
      'Authentication Error',
      name: 'firebaseAuthErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `No user found with this email address.`
  String get userNotFound {
    return Intl.message(
      'No user found with this email address.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password. Please try again.`
  String get wrongPassword {
    return Intl.message(
      'Incorrect password. Please try again.',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid.`
  String get invalidEmail {
    return Intl.message(
      'The email address is not valid.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `This user account has been disabled.`
  String get userDisabled {
    return Intl.message(
      'This user account has been disabled.',
      name: 'userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email and password.`
  String get invalidCredential {
    return Intl.message(
      'Please check your email and password.',
      name: 'invalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists with the same email but different sign-in credentials.`
  String get accountExistsWithDifferentCredential {
    return Intl.message(
      'An account already exists with the same email but different sign-in credentials.',
      name: 'accountExistsWithDifferentCredential',
      desc: '',
      args: [],
    );
  }

  /// `This email address is already registered. Please use a different email or try logging in.`
  String get emailAlreadyInUse {
    return Intl.message(
      'This email address is already registered. Please use a different email or try logging in.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak. Please use a stronger password with at least 6 characters.`
  String get weakPassword {
    return Intl.message(
      'The password is too weak. Please use a stronger password with at least 6 characters.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `This operation is not allowed. Please contact support.`
  String get operationNotAllowed {
    return Intl.message(
      'This operation is not allowed. Please contact support.',
      name: 'operationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Please provide an email address.`
  String get missingEmail {
    return Intl.message(
      'Please provide an email address.',
      name: 'missingEmail',
      desc: '',
      args: [],
    );
  }

  /// `The password reset link is invalid or has expired. Please request a new one.`
  String get invalidActionCode {
    return Intl.message(
      'The password reset link is invalid or has expired. Please request a new one.',
      name: 'invalidActionCode',
      desc: '',
      args: [],
    );
  }

  /// `The password reset link has expired. Please request a new one.`
  String get expiredActionCode {
    return Intl.message(
      'The password reset link has expired. Please request a new one.',
      name: 'expiredActionCode',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your internet connection and try again.`
  String get networkRequestFailed {
    return Intl.message(
      'Network error. Please check your internet connection and try again.',
      name: 'networkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Too many unsuccessful attempts. Please try again later.`
  String get tooManyRequests {
    return Intl.message(
      'Too many unsuccessful attempts. Please try again later.',
      name: 'tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `The verification code is invalid. Please try again.`
  String get invalidVerificationCode {
    return Intl.message(
      'The verification code is invalid. Please try again.',
      name: 'invalidVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `The verification ID is invalid. Please try again.`
  String get invalidVerificationId {
    return Intl.message(
      'The verification ID is invalid. Please try again.',
      name: 'invalidVerificationId',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please try again.`
  String get sessionExpired {
    return Intl.message(
      'Your session has expired. Please try again.',
      name: 'sessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `The phone number format is invalid.`
  String get invalidPhoneNumber {
    return Intl.message(
      'The phone number format is invalid.',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a phone number.`
  String get missingPhoneNumber {
    return Intl.message(
      'Please provide a phone number.',
      name: 'missingPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `SMS quota exceeded. Please try again later.`
  String get quotaExceeded {
    return Intl.message(
      'SMS quota exceeded. Please try again later.',
      name: 'quotaExceeded',
      desc: '',
      args: [],
    );
  }

  /// `reCAPTCHA verification failed. Please try again.`
  String get captchaCheckFailed {
    return Intl.message(
      'reCAPTCHA verification failed. Please try again.',
      name: 'captchaCheckFailed',
      desc: '',
      args: [],
    );
  }

  /// `Multi-factor authentication is required to complete sign-in.`
  String get multiFactorAuthRequired {
    return Intl.message(
      'Multi-factor authentication is required to complete sign-in.',
      name: 'multiFactorAuthRequired',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of second factors exceeded.`
  String get maximumSecondFactorCountExceeded {
    return Intl.message(
      'Maximum number of second factors exceeded.',
      name: 'maximumSecondFactorCountExceeded',
      desc: '',
      args: [],
    );
  }

  /// `The first factor is not supported.`
  String get unsupportedFirstFactor {
    return Intl.message(
      'The first factor is not supported.',
      name: 'unsupportedFirstFactor',
      desc: '',
      args: [],
    );
  }

  /// `This operation requires recent authentication. Please log in again.`
  String get requiresRecentLogin {
    return Intl.message(
      'This operation requires recent authentication. Please log in again.',
      name: 'requiresRecentLogin',
      desc: '',
      args: [],
    );
  }

  /// `This provider is already linked to your account.`
  String get providerAlreadyLinked {
    return Intl.message(
      'This provider is already linked to your account.',
      name: 'providerAlreadyLinked',
      desc: '',
      args: [],
    );
  }

  /// `This provider is not linked to your account.`
  String get noSuchProvider {
    return Intl.message(
      'This provider is not linked to your account.',
      name: 'noSuchProvider',
      desc: '',
      args: [],
    );
  }

  /// `The provider ID is invalid.`
  String get invalidProviderId {
    return Intl.message(
      'The provider ID is invalid.',
      name: 'invalidProviderId',
      desc: '',
      args: [],
    );
  }

  /// `The custom token format is invalid.`
  String get invalidCustomToken {
    return Intl.message(
      'The custom token format is invalid.',
      name: 'invalidCustomToken',
      desc: '',
      args: [],
    );
  }

  /// `The custom token does not match the expected format.`
  String get customTokenMismatch {
    return Intl.message(
      'The custom token does not match the expected format.',
      name: 'customTokenMismatch',
      desc: '',
      args: [],
    );
  }

  /// `The Firebase app has been deleted.`
  String get appDeleted {
    return Intl.message(
      'The Firebase app has been deleted.',
      name: 'appDeleted',
      desc: '',
      args: [],
    );
  }

  /// `This app is not authorized to use Firebase Authentication.`
  String get appNotAuthorized {
    return Intl.message(
      'This app is not authorized to use Firebase Authentication.',
      name: 'appNotAuthorized',
      desc: '',
      args: [],
    );
  }

  /// `Invalid argument provided.`
  String get argumentError {
    return Intl.message(
      'Invalid argument provided.',
      name: 'argumentError',
      desc: '',
      args: [],
    );
  }

  /// `This credential is already associated with a different user account.`
  String get credentialAlreadyInUse {
    return Intl.message(
      'This credential is already associated with a different user account.',
      name: 'credentialAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `The user token is invalid. Please log in again.`
  String get invalidUserToken {
    return Intl.message(
      'The user token is invalid. Please log in again.',
      name: 'invalidUserToken',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please log in again.`
  String get userTokenExpired {
    return Intl.message(
      'Your session has expired. Please log in again.',
      name: 'userTokenExpired',
      desc: '',
      args: [],
    );
  }

  /// `An internal error occurred. Please try again.`
  String get internalError {
    return Intl.message(
      'An internal error occurred. Please try again.',
      name: 'internalError',
      desc: '',
      args: [],
    );
  }

  /// `The operation has timed out. Please try again.`
  String get timeout {
    return Intl.message(
      'The operation has timed out. Please try again.',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Missing client identifier.`
  String get missingClientIdentifier {
    return Intl.message(
      'Missing client identifier.',
      name: 'missingClientIdentifier',
      desc: '',
      args: [],
    );
  }

  /// `A continue URL must be provided.`
  String get missingContinueUri {
    return Intl.message(
      'A continue URL must be provided.',
      name: 'missingContinueUri',
      desc: '',
      args: [],
    );
  }

  /// `The continue URL is not authorized.`
  String get unauthorizedContinueUri {
    return Intl.message(
      'The continue URL is not authorized.',
      name: 'unauthorizedContinueUri',
      desc: '',
      args: [],
    );
  }

  /// `The continue URL provided is invalid.`
  String get invalidContinueUri {
    return Intl.message(
      'The continue URL provided is invalid.',
      name: 'invalidContinueUri',
      desc: '',
      args: [],
    );
  }

  /// `Missing iOS bundle ID.`
  String get missingIosBundleId {
    return Intl.message(
      'Missing iOS bundle ID.',
      name: 'missingIosBundleId',
      desc: '',
      args: [],
    );
  }

  /// `Missing Android package name.`
  String get missingAndroidPkgName {
    return Intl.message(
      'Missing Android package name.',
      name: 'missingAndroidPkgName',
      desc: '',
      args: [],
    );
  }

  /// `This operation is restricted to administrators only.`
  String get adminRestrictedOperation {
    return Intl.message(
      'This operation is restricted to administrators only.',
      name: 'adminRestrictedOperation',
      desc: '',
      args: [],
    );
  }

  /// `The popup was blocked by the browser. Please allow popups for this site.`
  String get popupBlocked {
    return Intl.message(
      'The popup was blocked by the browser. Please allow popups for this site.',
      name: 'popupBlocked',
      desc: '',
      args: [],
    );
  }

  /// `The popup was closed before completing the sign-in.`
  String get popupClosedByUser {
    return Intl.message(
      'The popup was closed before completing the sign-in.',
      name: 'popupClosedByUser',
      desc: '',
      args: [],
    );
  }

  /// `This domain is not authorized for OAuth operations.`
  String get unauthorizedDomain {
    return Intl.message(
      'This domain is not authorized for OAuth operations.',
      name: 'unauthorizedDomain',
      desc: '',
      args: [],
    );
  }

  /// `Web storage is not supported or disabled.`
  String get webStorageUnsupported {
    return Intl.message(
      'Web storage is not supported or disabled.',
      name: 'webStorageUnsupported',
      desc: '',
      args: [],
    );
  }

  /// `The popup request was cancelled.`
  String get cancelledPopupRequest {
    return Intl.message(
      'The popup request was cancelled.',
      name: 'cancelledPopupRequest',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred accessing the keychain.`
  String get keychainError {
    return Intl.message(
      'An error occurred accessing the keychain.',
      name: 'keychainError',
      desc: '',
      args: [],
    );
  }

  /// `An internal error occurred with the authentication process.`
  String get missingIframeStart {
    return Intl.message(
      'An internal error occurred with the authentication process.',
      name: 'missingIframeStart',
      desc: '',
      args: [],
    );
  }

  /// `Invalid API key provided.`
  String get invalidApiKey {
    return Intl.message(
      'Invalid API key provided.',
      name: 'invalidApiKey',
      desc: '',
      args: [],
    );
  }

  /// `The requested mobile application is not installed.`
  String get appNotInstalled {
    return Intl.message(
      'The requested mobile application is not installed.',
      name: 'appNotInstalled',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Error code`
  String get errorCode {
    return Intl.message('Error code', name: 'errorCode', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Try In Anthor time, and Thank You`
  String get retryInAnthorTime {
    return Intl.message(
      'Try In Anthor time, and Thank You',
      name: 'retryInAnthorTime',
      desc: '',
      args: [],
    );
  }

  /// `Create Account Now !`
  String get CreateAccount {
    return Intl.message(
      'Create Account Now !',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Join Us For Quiz App`
  String get JoinUs {
    return Intl.message(
      'Join Us For Quiz App',
      name: 'JoinUs',
      desc: '',
      args: [],
    );
  }

  /// `Name User `
  String get NameUser {
    return Intl.message('Name User ', name: 'NameUser', desc: '', args: []);
  }

  /// `Confrime Password`
  String get ConfirmePassword {
    return Intl.message(
      'Confrime Password',
      name: 'ConfirmePassword',
      desc: '',
      args: [],
    );
  }

  /// `Lead Board `
  String get LeadBoard {
    return Intl.message('Lead Board ', name: 'LeadBoard', desc: '', args: []);
  }

  /// `Quick Play`
  String get quickPlay {
    return Intl.message('Quick Play', name: 'quickPlay', desc: '', args: []);
  }

  /// `Test your knowledge in a random challenge`
  String get testKnowledge {
    return Intl.message(
      'Test your knowledge in a random challenge',
      name: 'testKnowledge',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get startNow {
    return Intl.message('Start Now', name: 'startNow', desc: '', args: []);
  }

  /// `Daily Questions`
  String get dailyQuestions {
    return Intl.message(
      'Daily Questions',
      name: 'dailyQuestions',
      desc: '',
      args: [],
    );
  }

  /// `New Prizes`
  String get newPrizes {
    return Intl.message('New Prizes', name: 'newPrizes', desc: '', args: []);
  }

  /// `Challenge Player`
  String get challengePlayer {
    return Intl.message(
      'Challenge Player',
      name: 'challengePlayer',
      desc: '',
      args: [],
    );
  }

  /// `Compete with your friends`
  String get competeWithFriends {
    return Intl.message(
      'Compete with your friends',
      name: 'competeWithFriends',
      desc: '',
      args: [],
    );
  }

  /// `Top Players`
  String get topPlayers {
    return Intl.message('Top Players', name: 'topPlayers', desc: '', args: []);
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Level`
  String get level {
    return Intl.message('Level', name: 'level', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `Hello`
  String get hello {
    return Intl.message('Hello', name: 'hello', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Guest`
  String get guest {
    return Intl.message('Guest', name: 'guest', desc: '', args: []);
  }

  /// `Start Playing`
  String get startPlaying {
    return Intl.message(
      'Start Playing',
      name: 'startPlaying',
      desc: '',
      args: [],
    );
  }

  /// `Create Room`
  String get createRoom {
    return Intl.message('Create Room', name: 'createRoom', desc: '', args: []);
  }

  /// `Generate a code to invite a friend`
  String get generateCode {
    return Intl.message(
      'Generate a code to invite a friend',
      name: 'generateCode',
      desc: '',
      args: [],
    );
  }

  /// `Join Room`
  String get joinRoom {
    return Intl.message('Join Room', name: 'joinRoom', desc: '', args: []);
  }

  /// `Enter a 5-digit code`
  String get enterCode {
    return Intl.message(
      'Enter a 5-digit code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Room Created!`
  String get roomCreated {
    return Intl.message(
      'Room Created!',
      name: 'roomCreated',
      desc: '',
      args: [],
    );
  }

  /// `Share this code with your friend:`
  String get shareCode {
    return Intl.message(
      'Share this code with your friend:',
      name: 'shareCode',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for player to join...`
  String get waitingForPlayer {
    return Intl.message(
      'Waiting for player to join...',
      name: 'waitingForPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Enter Room Code`
  String get enterRoomCode {
    return Intl.message(
      'Enter Room Code',
      name: 'enterRoomCode',
      desc: '',
      args: [],
    );
  }

  /// `Ask your friend for the Game ID.`
  String get askFriendCode {
    return Intl.message(
      'Ask your friend for the Game ID.',
      name: 'askFriendCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid 5-digit code`
  String get invalidCode {
    return Intl.message(
      'Please enter a valid 5-digit code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Successfully joined the room!`
  String get joinSuccess {
    return Intl.message(
      'Successfully joined the room!',
      name: 'joinSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Room not found or already full`
  String get roomNotFound {
    return Intl.message(
      'Room not found or already full',
      name: 'roomNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Error creating room`
  String get errorCreatingRoom {
    return Intl.message(
      'Error creating room',
      name: 'errorCreatingRoom',
      desc: '',
      args: [],
    );
  }

  /// `Error joining room`
  String get errorJoiningRoom {
    return Intl.message(
      'Error joining room',
      name: 'errorJoiningRoom',
      desc: '',
      args: [],
    );
  }

  /// `Join Game`
  String get joinGame {
    return Intl.message('Join Game', name: 'joinGame', desc: '', args: []);
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
