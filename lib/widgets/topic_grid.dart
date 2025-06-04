import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';

class TopicGrid extends StatelessWidget {
  final List<String> menuItems;
  final String selectedItem;
  final ValueChanged<String> onItemSelected;

  const TopicGrid({
    super.key,
    required this.menuItems,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          final isHighlighted = selectedItem == item;

          return GestureDetector(
            onTap: () => onItemSelected(item),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    color: isHighlighted
                        ? AppColors.accentColor
                        : AppColors.secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isHighlighted) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
