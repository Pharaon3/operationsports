import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/screens/forum_detail_screen.dart';
import 'package:operationsports/screens/forum_list.dart';

class ForumSubMenu extends StatefulWidget {
  final String title;
  final List<ForumSectionMenu> subItems;

  const ForumSubMenu({super.key, required this.title, required this.subItems});

  @override
  State<ForumSubMenu> createState() => _ForumSubMenuState();
}

class _ForumSubMenuState extends State<ForumSubMenu> {
  bool isExpanded = false;

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
        if (isExpanded || widget.title == "")
          Column(
            children:
                widget.subItems.map((item) {
                  int timestampInt = int.parse(item.publishdate);
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                    timestampInt * 1000,
                  );
                  String formattedDate = DateFormat(
                    'MM-dd-yyyy, hh:mm a',
                  ).format(dateTime);
                  String authorname =
                      item.authorname != ''
                          ? 'by ${item.authorname}'
                          : 'by ${item.lastcontentauthor}';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  item.userid == '1'
                                      ? ForumList(parentId: item.id)
                                      : ForumDetail(
                                        parentId: item.id,
                                        content: item.content,
                                        title: item.title,
                                        authorname: item.authorname,
                                        publishdate: item.publishdate,
                                        joinedDate: item.joinedDate,
                                        posts: item.posts,
                                        useravatar: item.useravatar,
                                        userrank: item.userrank,
                                      ),
                        ),
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
                                    item.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Row(
                                    children: [
                                      Image.network(
                                        'https://forums.operationsports.com/forums/core/${item.useravatar}',
                                        height: 44,
                                      ),
                                      SizedBox(width: 9),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   "Arcade Sports Games Need a Revival",
                                            //   style: TextStyle(
                                            //     color: Colors.white,
                                            //     fontSize: 11,
                                            //   ),
                                            //   overflow: TextOverflow.ellipsis,
                                            // ),
                                            Text(
                                              "$authorname\n$formattedDate",
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
                                    children: List.generate(
                                      5,
                                      (index) => Container(
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x20000000),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              offset: Offset(0, 2.51),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.star,
                                          color:
                                              index < item.userrank
                                                  ? AppColors.accentColor
                                                  : AppColors.lightGrey,
                                          size: 22,
                                        ),
                                      ),
                                    ),
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
