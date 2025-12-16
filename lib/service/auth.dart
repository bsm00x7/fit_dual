import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foot_duel/service/store.dart';

import '../generated/l10n.dart';
import '../utilti/error/custom_error_widget.dart';
import '../utilti/exception/exception.dart';

class Auth {
  static final _instance = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _instance.authStateChanges();

  // Current user
  static User? get currentUser => _instance.currentUser;

  static Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try {
      await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      // REMOVED: User creation should NOT happen on login
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseAuthExceptionHandler.getErrorMessage(
          context, e.code);
      CustomErrorWidgetNew.showErrorDialog(context, 'Error', errorMessage);
      return;
    } catch (e) {
      if (context.mounted) {
        final l10n = S.of(context);
        CustomErrorWidgetNew.showErrorDialog(
            context, 'Error', l10n.retryInAnthorTime);
      }
    }
  }

  static Future<void> createAccountWithEmailAndPasswordAndName({
    required String email,
    required String password,
    required BuildContext context,
    required String name
  }) async {
    try {
      UserCredential userCredential = await _instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        user = _instance.currentUser;

        // Create user document in Firestore
        await FireStore.addUser(id: user!.uid, level: 1, xp: 0, name: name);
      }
    } on FirebaseAuthException catch(e) {
      String errorMessage = FirebaseAuthExceptionHandler.getErrorMessage(
          context, e.code);
      CustomErrorWidgetNew.showErrorDialog(context, 'Error', errorMessage);
      return;
    } catch (e) {
      if (context.mounted) {
        final l10n = S.of(context);
        CustomErrorWidgetNew.showErrorDialog(
            context, 'Error', l10n.retryInAnthorTime);
      }
    }
  }
}