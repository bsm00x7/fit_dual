import 'package:flutter/material.dart';

class CustomWhitecontainer extends StatelessWidget {
  final String data;
  final IconData icon;
  final Color color;

  const CustomWhitecontainer({super.key, required this.data, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9),
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data),
            Icon(icon, size: 18, color: color),
          ],
        ),
      ),
    );
  }
}
