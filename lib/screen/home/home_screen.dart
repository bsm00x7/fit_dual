import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this
import 'dart:async';

import '../../controllers/home_controllers.dart';
import '../../generated/l10n.dart';
import '../../service/game_service.dart';
import '../../utilti/loding_indicator.dart';
import '../../widgets/CustomWhitContainer.dart';

// Constants for better maintainability
class AppConstants {
  static const double notificationIconSize = 50.0;
  static const double profileAvatarSize = 60.0;
  static const double iconContainerSize = 70.0;
  static const double borderRadius = 25.0;
  static const double padding = 20.0;
  static const int roomCodeLength = 5;
  static const double bottomSheetHeight = 300.0;
}

class AppColors {
  static const dailyQuestionsColor = Color(0xFFB8E6D5);
  static const challengePlayerColor = Color(0xFFFFF4CC);
  static const quickPlayGradientStart = Color(0xFFADD8E6);
  static const quickPlayGradientEnd = Color(0xFF87CEEB);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? _roomListener;

  @override
  void dispose() {
    _roomListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeControllers(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white],
            ),
          ),
          child: Consumer<HomeControllers>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(l10n.loading),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: provider.refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _buildHeader(provider, l10n),
                          const SizedBox(height: 30),
                          _buildQuickPlayCard(context, l10n, provider),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildGameModeCard(
                                  title: l10n.dailyQuestions,
                                  subtitle: l10n.newPrizes,
                                  icon: Icons.calendar_today,
                                  color: AppColors.dailyQuestionsColor,
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: _buildGameModeCard(
                                  title: l10n.challengePlayer,
                                  subtitle: l10n.competeWithFriends,
                                  icon: Icons.person_outline,
                                  iconText: 'VS',
                                  color: AppColors.challengePlayerColor,
                                  onTap: () {
                                    _showGameOptions(context, provider, l10n);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          _buildLeaderboardSection(l10n),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Header, QuickPlayCard, GameModeCard, Leaderboard Section widgets remain same...
  // (Included below for completeness)

  Widget _buildHeader(HomeControllers provider, S l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: AppConstants.notificationIconSize,
          height: AppConstants.notificationIconSize,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(Icons.notifications_outlined, color: Colors.grey[700]),
        ),
        Expanded(
          child: Column(
            children: [
              Text('${l10n.hello} ${provider.username}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWhitecontainer(data: '${l10n.level} ${provider.user?.level ?? "0"}', icon: Icons.verified_rounded, color: Colors.deepPurpleAccent),
                  const SizedBox(width: 10),
                  CustomWhitecontainer(data: '${provider.user?.xp ?? "0"} ${l10n.points}', icon: Icons.star, color: Colors.orange),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(radius: 30, backgroundColor: Colors.blue[100], child: Icon(Icons.person, color: Colors.blue[700])),
      ],
    );
  }

  Widget _buildQuickPlayCard(BuildContext context, S l10n, HomeControllers provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.quickPlayGradientStart, AppColors.quickPlayGradientEnd]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Text('⚡', style: TextStyle(fontSize: 50)),
          const SizedBox(height: 10),
          Text(l10n.quickPlay, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: Text(l10n.startNow),
          ),
        ],
      ),
    );
  }

  Widget _buildGameModeCard({required String title, required String subtitle, IconData? icon, String? iconText, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconText != null) Text(iconText, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
            else Icon(icon, size: 40),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardSection(S l10n) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(l10n.viewAll), Text(l10n.topPlayers, style: const TextStyle(fontWeight: FontWeight.bold))],
        ),
        const SizedBox(height: 15),
        _buildLeaderboardItem(rank: 1, name: 'User', achievement: '3 Wins', avatarColor: Colors.blue),
      ],
    );
  }

  Widget _buildLeaderboardItem({required int rank, required String name, required String achievement, required Color avatarColor}) {
    return ListTile(
      leading: CircleAvatar(child: Text('#$rank')),
      title: Text(name),
      subtitle: Text(achievement),
    );
  }

  // --- START OF LOGIC FOR ROOMS ---

  void _showGameOptions(BuildContext context, HomeControllers provider, S l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: AppConstants.bottomSheetHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              Text(l10n.startPlaying, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                leading: const Icon(Icons.add_circle, color: Colors.blue),
                title: Text(l10n.createRoom),
                onTap: () {
                  Navigator.pop(context);
                  _handleCreateRoom(context, provider, l10n);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login, color: Colors.green),
                title: Text(l10n.joinRoom),
                onTap: () {
                  Navigator.pop(context);
                  _showJoinDialog(context, provider, l10n);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleCreateRoom(BuildContext context, HomeControllers provider, S l10n) async {


    try {
      // 2. Wait for Firebase
      LoadingIndicator.setLoading(context);
      final roomId = await GameMethods.createRoom(provider.username);

      LoadingIndicator.setLoading(context,false);


      if (roomId.isNotEmpty) {
        _showRoomCodeDialog(context, roomId, l10n);
        _listenForPlayerJoin(roomId, context);
      }
    } catch (e) {

      _showSnackBar(context, "Error: $e", isError: true);
    }
  }

  void _listenForPlayerJoin(String roomId, BuildContext context) {
    _roomListener?.cancel();
    _roomListener = FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists) return;

      final data = snapshot.data();

      // Check if player2 has joined (gameState is updated by the Joiner)
      if (data != null && data['gameState'] == 'playing') {
        _roomListener?.cancel(); // Stop listening to save resources

        // 1. Close the Room ID Dialog if it is open
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        // 2. Navigate to Game Screen
        if (context.mounted) {
          Navigator.pushNamed(context, '/game', arguments: roomId);

          _showSnackBar(context, "Match Found! Starting game...");
        }
      }
    });
  }

  void _showRoomCodeDialog(BuildContext context, String roomId, S l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.roomCreated),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.shareCode),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
              child: Text(roomId, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 5)),
            ),
            const SizedBox(height: 20),
            const LinearProgressIndicator(),
            const Text("Waiting for player...", style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _roomListener?.cancel();
              Navigator.pop(context);
            },
            child: Text(l10n.cancel),
          )
        ],
      ),
    );
  }
  void _showJoinDialog(BuildContext context, HomeControllers provider, S l10n) {
    TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Enter Room Code"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Ask your friend for the Game ID."),
              const SizedBox(height: 15),
              TextField(
                controller: codeController,
                keyboardType: TextInputType.number, // Only numbers keyboard
                maxLength: 5, // Limit to 5 digits
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 5, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "00000",
                  counterText: "", // Hides the "0/5" counter text
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                String code = codeController.text;
                if (code.length == 5) {
                  Navigator.pop(context); // Close dialog

                  // TODO: Call your Firebase join function here!
                  // joinRoom(code); 
                  print("Joining room: $code");
                } else {
                  // Show error if not 5 numbers
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid 5-digit code")),
                  );
                }
              },
              child: const Text("Join Game", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
 

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    // Always check if the widget is still in the tree before showing a SnackBar
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}