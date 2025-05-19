import 'package:flutter/material.dart';

class TopicGrid extends StatelessWidget {
  const TopicGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = [
      'Topics',
      'Latest Activity',
      'My Subscriptions',
    ];

    final Set<String> highlightedItems = {'Topics'};

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
              backgroundColor: const Color(0x00000000),
              foregroundColor: isHighlighted ? Colors.red : Colors.white54,
              elevation: 0,
              minimumSize: const Size(100, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              textStyle: const TextStyle(
                fontSize: 19,
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
