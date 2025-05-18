import 'package:flutter/material.dart';

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
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Sub-items
        if (isExpanded)
          Column(
            children:
                widget.subItems.map((item) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Main Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Arcade Sports Games Need a Revival",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "by Steve_OS\n04-08-2025, 03:25 PM",
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(
                                color: Colors.white30,
                                thickness: 1,
                              ),
                              const SizedBox(height: 6),
                              // Star Rating
                              Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.star_border,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Right arrow button
                        Container(
                          height: 100,
                          width: 40,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
      ],
    );
  }
}
