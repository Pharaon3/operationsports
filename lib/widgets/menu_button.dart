import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
// import 'package:operationsports/screens/game_screen.dart';
import 'package:operationsports/screens/review_screen.dart';
import '../screens/forum_screen.dart';
import '../screens/newsletter.dart';

class MenuButton extends StatelessWidget {
  final int selectedMenu; // 0 = FORUMS, 1 = NEWSLETTER, etc.

  const MenuButton({super.key, this.selectedMenu = 0});

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = ["FORUMS", "NEWSLETTER", "REVIEWS"];

    final List<Widget Function(BuildContext)> menuBuilder = [
      (context) => const ForumScreen(),
      (context) => const NewsLetter(),
      (context) => const ReviewScreen(),
      // (context) => const GameScreen(),
    ];

    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          final isHighlighted = index + 1 == selectedMenu;

          return _buildTopButton(
            iconPath: isHighlighted ? 'assets/${item.toLowerCase()}-selected-blue.png' : 'assets/${item.toLowerCase()}.png',
            label: item,
            isActive: isHighlighted,
            onPressed: () {
              if (!isHighlighted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: menuBuilder[index]),
                );
              }
            },
          );
        },
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                color:
                    isActive
                        ? AppColors.accentColor
                        : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
