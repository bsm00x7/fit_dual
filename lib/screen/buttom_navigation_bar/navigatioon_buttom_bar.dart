import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../home/home_screen.dart';
import '../lead_bord/lead_bord.dart';
import '../profile/profile.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({super.key});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const LeadBord(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    final text = S.of(context);
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        selectedIconTheme: const IconThemeData(
            applyTextScaling: true
        ),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: _currentIndex == 0
                      ? Colors.blueAccent.shade100
                      : Colors.transparent,
                  shape: BoxShape.circle
              ),
              child: const Icon(Icons.home, color: Colors.black),
            ),
            label: text.homeTitle,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: _currentIndex == 1
                      ? Colors.blueAccent.shade100
                      : Colors.transparent,
                  shape: BoxShape.circle
              ),
              child: const Icon(Icons.leaderboard),
            ),
            label: text.LeadBoard,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: _currentIndex == 2
                      ? Colors.blueAccent.shade100
                      : Colors.transparent,
                  shape: BoxShape.circle
              ),
              child: const Icon(Icons.person),
            ),
            label: text.profile,
          ),
        ],
      ),
    );
  }
}