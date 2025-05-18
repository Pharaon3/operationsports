import 'package:flutter/material.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = [
      'FORUMS',
      'BLOGS',
      'ARTICLES',
      'TODAY\'S POSTS',
      'MEMBER LIST',
      'CALENDAR',
      'NEWS',
      'REVIEWS',
    ];

    final Set<String> highlightedItems = {'FORUMS', 'TODAY\'S POSTS'};

    return SizedBox(
      height: 45, // Reduced button height
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          final isHighlighted = highlightedItems.contains(item);

          return ElevatedButton(
            onPressed: () {
              // TODO: Add onPressed behavior
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A2A2A),
              foregroundColor: isHighlighted ? Colors.red : Colors.white54,
              elevation: 2,
              minimumSize: const Size(100, 40), // size of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(item),
          );
        },
      ),
    );
  }
}
