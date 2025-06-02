import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:operationsports/core/constants.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class ForumCard extends StatelessWidget {
  final bool isMainForum;
  final String forumName;
  final String postText;
  final String imageUrl;
  final String date;
  final int stars;
  final String joinDate;
  final String authorname;
  final int postCount;

  const ForumCard({
    super.key,
    required this.isMainForum,
    required this.forumName,
    required this.postText,
    required this.authorname,
    this.imageUrl = "",
    required this.date,
    this.stars = 4,
    this.joinDate = 'Jul 2002',
    this.postCount = 33300,
  });

  @override
  Widget build(BuildContext context) {
    int timestampInt = int.parse(date);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestampInt * 1000,
    );
    String formattedDate = DateFormat('MM-dd-yyyy, hh:mm a').format(dateTime);

    TextSpan buildStyledPostText(String rawText) {
      final spans = <TextSpan>[];

      final quoteRegex = RegExp(
        r'\[QUOTE=[^\]]*\](.*?)\[/QUOTE\]',
        dotAll: true,
      );
      int lastEnd = 0;

      for (final match in quoteRegex.allMatches(rawText)) {
        if (match.start > lastEnd) {
          spans.add(
            TextSpan(
              text: rawText.substring(lastEnd, match.start),
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final quotedText = match.group(1)?.trim() ?? '';
        spans.add(
          TextSpan(
            text: '"$quotedText"\n',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white70,
            ),
          ),
        );

        lastEnd = match.end;
      }

      if (lastEnd < rawText.length) {
        spans.add(
          TextSpan(
            text: rawText.substring(lastEnd),
            style: const TextStyle(color: Colors.white),
          ),
        );
      }

      return TextSpan(children: spans);
    }

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
                              forumName.length > 25
                                  ? '${forumName.substring(0, 25)}...'
                                  : forumName,
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
                          "By: $authorname",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
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
                        formattedDate,
                        style: const TextStyle(color: Colors.grey, fontSize: 7),
                      ),

                      const SizedBox(height: 12),
                      if (isMainForum)
                        HtmlWidget(
                          postText.replaceAll('***', ""),
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.6,
                          ),
                          onTapUrl: (url) async {
                            if (await canLaunchUrl(Uri.parse(url))) {
                              launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                            return true;
                          },
                        )
                      else
                        Text.rich(
                          buildStyledPostText(postText),
                          style: const TextStyle(fontSize: 12),
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
