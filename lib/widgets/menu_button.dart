import 'package:flutter/material.dart';

import '../screens/forum_screen.dart';
import '../screens/newsletter.dart';

class MenuButton extends StatelessWidget {
  final int selectedMenu;
  const MenuButton({super.key, this.selectedMenu = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTopButton(
            iconPath: 'assets/newsletter.png',
            label: 'NEWSLETTER',
            isActive: selectedMenu == 1,
            onPressed: () {
              if (selectedMenu != 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsLetter()),
                );
              }
            },
          ),
          _buildTopButton(
            iconPath: 'assets/forums.png',
            label: 'FORUMS',
            isActive: selectedMenu == 2,
            onPressed: () {
              if (selectedMenu != 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForumScreen()),
                );
              }
            },
          ),
          _buildTopButton(
            iconPath: 'assets/review.png',
            label: 'REVIEW',
            isActive: selectedMenu == 3,
            onPressed: () {
              // Review action
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton({
    required String iconPath,
    required String label,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey[300],
          backgroundColor: const Color(0xFF222222),
          elevation: 0,
          shadowColor: const Color(0xFF000000),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(iconPath, height: 23),
            ),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Color(0xFFFF5757) : Color(0xFF434343),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
