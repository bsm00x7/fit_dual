import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class FireStore {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';

  // Create user
  static Future<void> addUser({
    required String id,
    required int level,
    required int xp,
    String? name
  }) async {
    try {
      await _instance.collection(_usersCollection).doc(id).set({
        'id': id,
        'level': level,
        'xp': xp,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      rethrow;
    }
  }

  // Check if user exists
  static Future<bool> userExists(String id) async {
    try {
      final doc = await _instance.collection(_usersCollection).doc(id).get();
      return doc.exists;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

  // Get user by ID
  static Future<UserModel?> getUser(String id) async {
    try {
      final doc = await _instance.collection(_usersCollection).doc(id).get();

      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print("Error getting user: $e");
      rethrow;
    }
  }

  // Get user stream (real-time updates)
  static Stream<UserModel?> getUserStream(String id) {
    return _instance
        .collection(_usersCollection)
        .doc(id)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    });
  }

  // Update user data
  static Future<void> updateUser({
    required String id,
    String? name,
    int? level,
    int? xp,
  }) async {
    try {
      Map<String, dynamic> updateData = {};

      if (name != null) updateData['name'] = name;
      if (level != null) updateData['level'] = level;
      if (xp != null) updateData['xp'] = xp;

      if (updateData.isNotEmpty) {
        await _instance
            .collection(_usersCollection)
            .doc(id)
            .update(updateData);
      }
    } catch (error) {
      print("Error updating user: $error");
      rethrow;
    }
  }

  // Update user XP
  static Future<void> updateUserXp(String id, int xpToAdd) async {
    try {
      await _instance.collection(_usersCollection).doc(id).update({
        'xp': FieldValue.increment(xpToAdd),
      });
    } catch (error) {
      print("Error updating XP: $error");
      rethrow;
    }
  }

  // Update user level
  static Future<void> updateUserLevel(String id, int newLevel) async {
    try {
      await _instance.collection(_usersCollection).doc(id).update({
        'level': newLevel,
      });
    } catch (error) {
      print("Error updating level: $error");
      rethrow;
    }
  }

  // Delete user
  static Future<void> deleteUser(String id) async {
    try {
      await _instance.collection(_usersCollection).doc(id).delete();
    } catch (error) {
      print("Error deleting user: $error");
      rethrow;
    }
  }

  // Get all users (use with caution)
  static Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _instance.collection(_usersCollection).get();
      return querySnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
    } catch (error) {
      print("Error getting all users: $error");
      rethrow;
    }
  }

  // Get users by level
  static Future<List<UserModel>> getUsersByLevel(int level) async {
    try {
      final querySnapshot = await _instance
          .collection(_usersCollection)
          .where('level', isEqualTo: level)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
    } catch (error) {
      print("Error getting users by level: $error");
      rethrow;
    }
  }

  // Get top users by XP (leaderboard)
  static Future<List<UserModel>> getTopUsersByXp({int limit = 10}) async {
    try {
      final querySnapshot = await _instance
          .collection(_usersCollection)
          .orderBy('xp', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
    } catch (error) {
      print("Error getting top users: $error");
      rethrow;
    }
  }
}