import 'package:flutter/material.dart';

class MenuGrid extends StatelessWidget {
  final List<String> menuItems;
  final Set<String> highlightedItems;
  const MenuGrid({
    super.key,
    required this.menuItems,
    required this.highlightedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: SizedBox(
        height: 45,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: menuItems.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            final isHighlighted = highlightedItems.contains(item);

            return SizedBox(
              width: 115,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add onPressed behavior
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A2A2A),
                  foregroundColor: isHighlighted ? Colors.red : Colors.white54,
                  elevation: 2,
                  minimumSize: const Size(100, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(item),
              ),
            );
          },
        ),
      ),
    );
  }
}
