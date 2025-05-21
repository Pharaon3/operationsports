import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';

class TopicGrid extends StatefulWidget {
  final List<String> menuItems;
  final List<String> selectedItems;

  const TopicGrid({
    super.key,
    required this.menuItems,
    required this.selectedItems,
  });

  @override
  _TopicGridState createState() => _TopicGridState();
}

class _TopicGridState extends State<TopicGrid> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.menuItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = widget.menuItems[index];
          final isHighlighted = widget.selectedItems.contains(item);

          if (isHighlighted) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (!isHighlighted) {
                    widget.selectedItems.add(item);
                  } else {
                    widget.selectedItems.remove(item);
                  }
                  print(
                    "Text tapped! Current selection: ${widget.selectedItems}",
                  );
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item,
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (!isHighlighted) {
                    widget.selectedItems.add(item);
                  } else {
                    widget.selectedItems.remove(item);
                  }
                  print(
                    "Text tapped! Current selection: ${widget.selectedItems}",
                  );
                });
              },
              child: Text(
                item,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
