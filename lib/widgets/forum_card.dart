import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/widgets/bbcode_parser.dart';

class ForumCard extends StatelessWidget {
  final bool isMainForum;
  final String forumName;
  final String postText;
  final String imageUrl;
  final String date;
  final String authorname;
  final String joinedDate;
  final String postCount;
  final String useravatar;
  final int userrank;
  final Future<void> Function(String) quoteReply;

  const ForumCard({
    super.key,
    required this.isMainForum,
    required this.forumName,
    required this.postText,
    required this.authorname,
    required this.joinedDate,
    this.imageUrl = "",
    required this.date,
    required this.postCount,
    required this.useravatar,
    required this.userrank,
    required this.quoteReply,
  });

  void quotereply() {
    String quote = '[QUOTE=$authorname;n$date]$postText[/QUOTE]';
    quoteReply(quote);
  }

  @override
  Widget build(BuildContext context) {
    int timestampInt = int.parse(date);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestampInt * 1000,
    );
    String formattedDate = DateFormat('MM-dd-yyyy, hh:mm a').format(dateTime);

    int joinedDatetimestampInt = int.parse(joinedDate);
    DateTime joinedDatedateTime = DateTime.fromMillisecondsSinceEpoch(
      joinedDatetimestampInt * 1000,
    );
    String joinedDateformattedDate = DateFormat(
      'MM-dd-yyyy',
    ).format(joinedDatedateTime);

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
                        Image.network(
                          'https://forums.operationsports.com/forums/core/$useravatar',
                          height: 30,
                          width: 35,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              forumName.length > 23
                                  ? '${forumName.substring(0, 23)}...'
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
                                        index < userrank
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
                          "Join Date: $joinedDateformattedDate",
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
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [BBCodeParser.buildHtmlWidget(postText)],
                        ),
                      ),

                      // Text(postText),
                      // if (isMainForum)
                      //   HtmlWidget(
                      //     postText.replaceAll('***', ""),
                      //     textStyle: const TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 15,
                      //       height: 1.6,
                      //     ),
                      //     onTapUrl: (url) async {
                      //       if (await canLaunchUrl(Uri.parse(url))) {
                      //         launchUrl(
                      //           Uri.parse(url),
                      //           mode: LaunchMode.externalApplication,
                      //         );
                      //       }
                      //       return true;
                      //     },
                      //   )
                      // else
                      //   Text.rich(
                      //     buildStyledPostText(postText),
                      //     style: const TextStyle(fontSize: 12),
                      //   ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          quotereply();
                        },
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                          size: 24,
                        ),
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
