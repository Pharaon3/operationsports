import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';

class ForumCard extends StatelessWidget {
  final String forumName;
  final String postText;
  final String imageUrl;
  final String date;
  final int stars;
  final String joinDate;
  final int postCount;

  const ForumCard({
    super.key,
    required this.forumName,
    required this.postText,
    this.imageUrl = "",
    required this.date,
    this.stars = 4,
    this.joinDate = 'Jul 2002',
    this.postCount = 33300,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF707070),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              forumName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
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
                                        index < stars
                                            ? AppColors.accentColor
                                            : AppColors.lightGrey,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Join Date: $joinDate",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                        Text(
                          "Posts: $postCount",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // POST CONTENT CARD
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(color: Colors.grey, fontSize: 7),
                      ),

                      const SizedBox(height: 12),
                      Text(
                        postText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                if (imageUrl != "")
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(imageUrl),
                    ),
                  ),
                const SizedBox(height: 12),

                // Action buttons
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.bookmark_border_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
