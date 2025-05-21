import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/screens/forum_detail_screen.dart';

class ForumSubMenu extends StatefulWidget {
  final String title;
  final List<String> subItems;

  const ForumSubMenu({super.key, required this.title, required this.subItems});

  @override
  State<ForumSubMenu> createState() => _ForumSubMenuState();
}

class _ForumSubMenuState extends State<ForumSubMenu> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        if (widget.title != "")
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
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
                  color: const Color(0xFF222222),
                ),
              ),
            ),
          ),

        // Sub-items
        if (isExpanded)
          Column(
            children:
                widget.subItems.map((item) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForumDetail()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Main Info
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.white,
                                        size: 44,
                                      ),
                                      SizedBox(width: 9),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Arcade Sports Games Need a Revival",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "by Steve_OS\n04-08-2025, 03:25 PM",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    color: Color(0xFFFFFFFF),
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 16),
                                  // Star Rating
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.accentColor,
                                        size: 22,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.accentColor,
                                        size: 22,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.accentColor,
                                        size: 22,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: AppColors.accentColor,
                                        size: 22,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Color(0xFFD9D9D9),
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Right arrow button
                          Container(
                            height: 190,
                            width: 73,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x40000000),
                                  blurRadius: 4,
                                  spreadRadius: 6,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
      ],
    );
  }
}
