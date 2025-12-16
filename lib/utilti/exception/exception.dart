

import 'package:flutter/cupertino.dart';

import '../../generated/l10n.dart';
class FirebaseAuthExceptionHandler {
  final String code;
  final String message;

  FirebaseAuthExceptionHandler({
    required this.code,
    required this.message,
  });

  /// Convert Firebase error code from kebab-case to camelCase
  static String _convertErrorCodeToKey(String errorCode) {
    // Remove 'auth/' prefix if present
    errorCode = errorCode.replaceAll('auth/', '');
    List<String> parts = errorCode.split('-');
    if (parts.isEmpty) return errorCode;
    String result = parts[0];
    for (int i = 1; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        result += parts[i][0].toUpperCase() + parts[i].substring(1);
      }
    }
    return result;
  }

  /// Get localized error message based on Firebase error code
  static String getErrorMessage(BuildContext context, String errorCode) {
    final l10n = S.of(context);

    // Convert error code format (kebab-case to camelCase)
    final key = _convertErrorCodeToKey(errorCode);

    switch (key) {
    // Login Exceptions
      case 'userNotFound':
        return l10n.userNotFound;
      case 'wrongPassword':
        return l10n.wrongPassword;
      case 'invalidEmail':
        return l10n.invalidEmail;
      case 'userDisabled':
        return l10n.userDisabled;
      case 'invalidCredential':
        return l10n.invalidCredential;
      case 'accountExistsWithDifferentCredential':
        return l10n.accountExistsWithDifferentCredential;

    // Signup Exceptions
      case 'emailAlreadyInUse':
        return l10n.emailAlreadyInUse;
      case 'weakPassword':
        return l10n.weakPassword;
      case 'operationNotAllowed':
        return l10n.operationNotAllowed;

    // Password Reset Exceptions
      case 'missingEmail':
        return l10n.missingEmail;
      case 'invalidActionCode':
        return l10n.invalidActionCode;
      case 'expiredActionCode':
        return l10n.expiredActionCode;

    // Network Exceptions
      case 'networkRequestFailed':
        return l10n.networkRequestFailed;
      case 'tooManyRequests':
        return l10n.tooManyRequests;

    // Token Exceptions
      case 'invalidVerificationCode':
        return l10n.invalidVerificationCode;
      case 'invalidVerificationId':
        return l10n.invalidVerificationId;
      case 'sessionExpired':
        return l10n.sessionExpired;

    // Phone Authentication Exceptions
      case 'invalidPhoneNumber':
        return l10n.invalidPhoneNumber;
      case 'missingPhoneNumber':
        return l10n.missingPhoneNumber;
      case 'quotaExceeded':
        return l10n.quotaExceeded;
      case 'captchaCheckFailed':
        return l10n.captchaCheckFailed;

    // Multi-factor Authentication Exceptions
      case 'multiFactorAuthRequired':
        return l10n.multiFactorAuthRequired;
      case 'maximumSecondFactorCountExceeded':
        return l10n.maximumSecondFactorCountExceeded;
      case 'unsupportedFirstFactor':
        return l10n.unsupportedFirstFactor;

    // Re-authentication Exceptions
      case 'requiresRecentLogin':
        return l10n.requiresRecentLogin;

    // Provider Exceptions
      case 'providerAlreadyLinked':
        return l10n.providerAlreadyLinked;
      case 'noSuchProvider':
        return l10n.noSuchProvider;
      case 'invalidProviderId':
        return l10n.invalidProviderId;

    // Custom Token Exceptions
      case 'invalidCustomToken':
        return l10n.invalidCustomToken;
      case 'customTokenMismatch':
        return l10n.customTokenMismatch;

    // App-related Exceptions
      case 'appDeleted':
        return l10n.appDeleted;
      case 'appNotAuthorized':
        return l10n.appNotAuthorized;
      case 'argumentError':
        return l10n.argumentError;

    // Credential Exceptions
      case 'credentialAlreadyInUse':
        return l10n.credentialAlreadyInUse;
      case 'invalidUserToken':
        return l10n.invalidUserToken;
      case 'userTokenExpired':
        return l10n.userTokenExpired;

    // General Exceptions
      case 'internalError':
        return l10n.internalError;
      case 'timeout':
        return l10n.timeout;
      case 'missingClientIdentifier':
        return l10n.missingClientIdentifier;
      case 'missingContinueUri':
        return l10n.missingContinueUri;
      case 'unauthorizedContinueUri':
        return l10n.unauthorizedContinueUri;

    // Email Link Exceptions
      case 'invalidContinueUri':
        return l10n.invalidContinueUri;
      case 'missingIosBundleId':
        return l10n.missingIosBundleId;
      case 'missingAndroidPkgName':
        return l10n.missingAndroidPkgName;

    // Admin Exceptions
      case 'adminRestrictedOperation':
        return l10n.adminRestrictedOperation;

    // Popup and Redirect Exceptions
      case 'popupBlocked':
        return l10n.popupBlocked;
      case 'popupClosedByUser':
        return l10n.popupClosedByUser;
      case 'unauthorizedDomain':
        return l10n.unauthorizedDomain;

    // Web Storage Exceptions
      case 'webStorageUnsupported':
        return l10n.webStorageUnsupported;

    // Additional Common Exceptions
      case 'cancelledPopupRequest':
        return l10n.cancelledPopupRequest;
      case 'keychainError':
        return l10n.keychainError;
      case 'missingIframeStart':
        return l10n.missingIframeStart;
      case 'invalidApiKey':
        return l10n.invalidApiKey;
      case 'appNotInstalled':
        return l10n.appNotInstalled;

    // Default case
      default:
        return '${l10n.unexpectedError} ${l10n.errorCode}: $errorCode';
    }
  }

  /// Check if error is related to network issues
  static bool isNetworkError(String errorCode) {
    final key = _convertErrorCodeToKey(errorCode);
    return key == 'networkRequestFailed' || key == 'timeout';
  }

  /// Check if error requires re-authentication
  static bool requiresReauth(String errorCode) {
    final key = _convertErrorCodeToKey(errorCode);
    return key == 'requiresRecentLogin' || key == 'userTokenExpired';
  }

  /// Check if error is related to invalid credentials
  static bool isInvalidCredentials(String errorCode) {
    final key = _convertErrorCodeToKey(errorCode);
    return key == 'userNotFound' ||
        key == 'wrongPassword' ||
        key == 'invalidCredential' ||
        key == 'invalidEmail';
  }

  /// Check if error is related to account issues
  static bool isAccountIssue(String errorCode) {
    final key = _convertErrorCodeToKey(errorCode);
    return key == 'userDisabled' ||
        key == 'emailAlreadyInUse' ||
        key == 'accountExistsWithDifferentCredential';
  }
}

/// Usage Example:
///
/// try {
///   await FirebaseAuth.instance.signInWithEmailAndPassword(
///     email: email,
///     password: password,
///   );
/// } on firebase_auth.FirebaseAuthException catch (e) {
///   String errorMessage = FirebaseAuthExceptionHandler.getErrorMessage(context, e.code);
///
///   // Show error message to user
///   ScaffoldMessenger.of(context).showSnackBar(
///     SnackBar(content: Text(errorMessage)),
///   );
///
///   // Check error type
///   if (FirebaseAuthExceptionHandler.isNetworkError(e.code)) {
///     // Handle network error
///   } else if (FirebaseAuthExceptionHandler.isInvalidCredentials(e.code)) {
///     // Handle invalid credentials
///   }
/// } catch (e) {
///   print('An unexpected error occurred: $e');
/// }
