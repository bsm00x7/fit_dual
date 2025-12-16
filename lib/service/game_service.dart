import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class GameMethods {
 static final FirebaseFirestore _firestore = FirebaseFirestore.instance;


 static String generateRoomId() {
    // Generates a random 5-digit number string
    var rng = Random();
    return (10000 + rng.nextInt(90000)).toString();
  }

  // 2. CREATE ROOM
 static Future<String> createRoom(String playerName) async {
    String roomId = generateRoomId();

    try {
      await _firestore.collection('rooms').doc(roomId).set({
        'id': roomId,
        'player1': playerName, // or FirebaseAuth UID
        'player2': '',
        'gameState': 'waiting',
      });
      return roomId;
    } catch (e) {
      print("Error creating room: $e");
      return "";
    }
  }

  // 3. JOIN ROOM
 static Future<bool> joinRoom(String roomId, String playerName) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('rooms').doc(roomId).get();

      if (doc.exists) {
        // Check if the game is actually waiting
        if (doc['gameState'] == 'waiting') {
          await _firestore.collection('rooms').doc(roomId).update({
            'player2': playerName,
            'gameState': 'playing',
          });
          return true; // Success
        } else {
          print("Room is full or already playing");
          return false;
        }
      } else {
        print("Room does not exist");
        return false;
      }
    } catch (e) {
      print("Error joining room: $e");
      return false;
    }
  }
}