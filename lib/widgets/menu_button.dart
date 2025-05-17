import 'package:flutter/material.dart';

import '../screens/newsletter.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsLetter()),
              );
            },
          ),
          _buildTopButton(
            iconPath: 'assets/forums.png',
            label: 'FORUMS',
            onPressed: () {
              // Forums action
            },
          ),
          _buildTopButton(
            iconPath: 'assets/review.png',
            label: 'REVIEW',
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
              style: const TextStyle(color: Color(0xFF434343), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
