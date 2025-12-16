import 'package:flutter/cupertino.dart';
import 'package:foot_duel/service/auth.dart';

import '../model/user_model.dart';
import '../service/store.dart';

class HomeControllers extends ChangeNotifier {
  String username = "player";
  UserModel? user;
  bool isLoading = true;
  String? errorMessage;

  HomeControllers() {
    init();
  }

  Future<void> init() async {
    try {
      isLoading = true;
      notifyListeners();

      username = Auth.currentUser?.displayName ?? "player";

      if (Auth.currentUser != null) {
        user = await loadUserData(Auth.currentUser!.uid);
      }

      errorMessage = null;
    } catch (e) {
      errorMessage = "Failed to load user data: $e";
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UserModel?> loadUserData(String userId) async {
    try {
      UserModel? user = await FireStore.getUser(userId);
      return user;
    } catch (e) {
      print("Error loading user data: $e");
      rethrow;
    }
  }

  // Method to refresh data
  Future<void> refresh() async {
    await init();
  }
}