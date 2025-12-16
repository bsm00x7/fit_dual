import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../../controllers/home_controllers.dart';
import '../../generated/l10n.dart';
import '../../service/game_service.dart';
import '../../widgets/CustomWhitContainer.dart';

// Constants
class AppConstants {
  static const double notificationIconSize = 50.0;
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

  // Helper for SnackBars that is safe from context errors
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
      ),
    );
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
                return const Center(child: CircularProgressIndicator());
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
                          _buildQuickPlayCard(l10n),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildGameModeCard(
                                  title: l10n.dailyQuestions,
                                  subtitle: l10n.newPrizes,
                                  icon: Icons.calendar_today,
                                  color: AppColors.dailyQuestionsColor,
                                  onTap: () => _showSnackBar("Coming soon!"),
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
                                  onTap: () => _showGameOptions(provider, l10n),
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

  // --- GAME LOGIC (FIXED) ---

  void _showGameOptions(HomeControllers provider, S l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          height: AppConstants.bottomSheetHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              Text(l10n.startPlaying, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.add_circle, color: Colors.blue),
                title: Text(l10n.createRoom),
                onTap: () {
                  Navigator.pop(sheetContext); // Close BottomSheet
                  _handleCreateRoom(provider, l10n);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login, color: Colors.green),
                title: Text(l10n.joinRoom),
                onTap: () {
                  Navigator.pop(sheetContext); // Close BottomSheet
                  _showJoinDialog(provider, l10n);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleCreateRoom(HomeControllers provider, S l10n) async {
    // 1. Show Loading Manually using Main Context
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 2. Async Firebase Call
      final roomId = await GameMethods.createRoom(provider.username);
      debugPrint("Room Created: $roomId");

      // 3. CLOSE LOADING
      if (mounted) Navigator.of(context, rootNavigator: true).pop();

      // Small delay to allow navigation stack to clear
      await Future.delayed(const Duration(milliseconds: 200));

      if (roomId.isNotEmpty && mounted) {
        _showRoomCodeDialog(roomId, l10n);
        _listenForPlayerJoin(roomId);
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        _showSnackBar("Error: $e", isError: true);
      }
    }
  }

  void _listenForPlayerJoin(String roomId) {
    _roomListener?.cancel();
    _roomListener = FirebaseFirestore.instance.collection('rooms').doc(roomId).snapshots().listen(
          (snapshot) {
        if (!mounted || !snapshot.exists) return;
        final data = snapshot.data();

        if (data != null && data['gameState'] == 'playing') {
          _roomListener?.cancel();
          // Close Code Dialog
          Navigator.of(context, rootNavigator: true).pop();
          // Go to Game
          Navigator.pushNamed(context, '/game', arguments: roomId);
          _showSnackBar("Player Joined! Starting...");
        }
      },
      onError: (e) => _showSnackBar("Sync Error", isError: true),
    );
  }

  void _showRoomCodeDialog(String roomId, S l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          _roomListener?.cancel();
          Navigator.of(dialogContext).pop();
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(l10n.roomCreated),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.shareCode, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.blue.shade200, width: 2)),
                child: Text(roomId, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 8, color: Colors.blue)),
              ),
              const SizedBox(height: 20),
              const LinearProgressIndicator(),
              const SizedBox(height: 10),
              const Text("Waiting for friend...", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _roomListener?.cancel();
                Navigator.of(dialogContext).pop();
              },
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void _showJoinDialog(HomeControllers provider, S l10n) {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Join Room"),
        content: TextField(
          controller: codeController,
          keyboardType: TextInputType.number,
          maxLength: 5,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 5),
          decoration: const InputDecoration(hintText: "00000", counterText: ""),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final code = codeController.text.trim();
              if (code.length != 5) return;
              Navigator.pop(dialogContext); // Close Input Dialog
              // Show Loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );

              try {
                bool success = await GameMethods.joinRoom(code, provider.username);
                if (mounted) Navigator.of(context, rootNavigator: true).pop(); // Close Loading

                if (success && mounted) {
                  Navigator.pushNamed(context, '/game', arguments: code);
                } else if (mounted) {
                  _showSnackBar("Invalid Code", isError: true);
                }
              } catch (e) {
                if (mounted) Navigator.of(context, rootNavigator: true).pop();
                _showSnackBar("Join Error", isError: true);
              }
            },
            child: const Text("Join"),
          ),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---
  // (Header, cards, and leaderboard items)

  Widget _buildHeader(HomeControllers provider, S l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.grey[700]),
            onPressed: () => _showSnackBar("No notifications"),
          ),
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
                  CustomWhitecontainer(data: '${provider.user?.xp ?? "0"} pts', icon: Icons.star, color: Colors.orange),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(radius: 25, backgroundColor: Colors.blue[100], child: Icon(Icons.person, color: Colors.blue[700])),
      ],
    );
  }

  Widget _buildQuickPlayCard(S l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.quickPlayGradientStart, AppColors.quickPlayGradientEnd]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Text('⚡', style: TextStyle(fontSize: 40)),
          Text(l10n.quickPlay, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => _showSnackBar("Quick Play coming soon"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.blue),
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
        height: 180,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconText != null) Text(iconText, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)) else Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardSection(S l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.topPlayers, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 10),
        _buildLeaderboardItem(rank: 1, name: "Champion", xp: "10 Wins", color: Colors.amber),
        _buildLeaderboardItem(rank: 2, name: "Pro Player", xp: "8 Wins", color: Colors.grey),
      ],
    );
  }

  Widget _buildLeaderboardItem({required int rank, required String name, required String xp, required Color color}) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color, child: Text("#$rank", style: const TextStyle(color: Colors.white))),
      title: Text(name),
      subtitle: Text(xp),
    );
  }
}