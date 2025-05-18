import 'package:flutter/material.dart';

class ForumMenu extends StatefulWidget {
  final String title;
  final List<String> subItems;

  const ForumMenu({
    super.key,
    required this.title,
    required this.subItems,
  });

  @override
  State<ForumMenu> createState() => _ForumMenuState();
}

class _ForumMenuState extends State<ForumMenu> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Accordion Header
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(
                isExpanded ? Icons.remove_circle : Icons.add_circle,
                color: Colors.black54,
              ),
            ),
          ),
        ),

        // Sub-items
        if (isExpanded)
          Column(
            children: widget.subItems.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.redAccent,
                  ),
                  onTap: () {
                    // Handle submenu tap
                  },
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
