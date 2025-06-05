import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/screens/new_topic.dart';
import 'package:operationsports/services/forum_service.dart';
import 'package:operationsports/widgets/forum_card.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/paginated_forum.dart';
import 'package:operationsports/widgets/post_input_box.dart';

class ForumDetail extends StatefulWidget {
  final String parentId;
  final String content;
  final String title;
  final String authorname;
  final String publishdate;
  final String joinedDate;
  final String posts;
  const ForumDetail({
    super.key,
    required this.parentId,
    required this.content,
    required this.title,
    required this.authorname,
    required this.publishdate,
    required this.joinedDate,
    required this.posts,
  });

  @override
  State<ForumDetail> createState() => _ForumDetailState();
}

class _ForumDetailState extends State<ForumDetail> {
  late Future<List<ForumSectionMenu>> _futureForumDetail;

  @override
  void initState() {
    super.initState();
    _loadForumSectionMenu();
  }

  void _loadForumSectionMenu() {
    _futureForumDetail = ForumService.fetchForumSectionMenu(widget.parentId);
  }

  @override
  Widget build(BuildContext context) {
    String parseBBCodeToHtml(String bbcode) {
      return bbcode
          .replaceAll('[B]', '<b>')
          .replaceAll('[/B]', '</b>')
          .replaceAll('[I]', '<i>')
          .replaceAll('[/I]', '</i>')
          .replaceAll('[COLOR="Red"]', '<span style="color:red;">')
          .replaceAll('[COLOR="Blue"]', '<span style="color:blue;">')
          .replaceAll('[/COLOR]', '</span>')
          .replaceAllMapped(
            RegExp(r'\[URL="(.+?)"\](.+?)\[/URL\]', dotAll: true),
            (match) => '<a href="${match[1]}">${match[2]}</a>',
          );
    }

    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: () async => {},
        child: Builder(
          builder: (context) {
            return ListView(
              children: [
                const Header(selectedMenu: 2),

                Column(
                  children: [
                    MenuGrid(
                      menuItems: ['FORUMS', 'BLOGS', 'ARTICLES', 'GROUPS'],
                      highlightedItems: {'FORUMS'},
                    ),
                    MenuGrid(
                      menuItems: [
                        'Today\'s posts',
                        'Member list',
                        'Calendar',
                        'News',
                        'Reviews',
                      ],
                      highlightedItems: {'Today\'s posts'},
                    ),
                  ],
                ),

                ForumCard(
                  isMainForum: true,
                  authorname: widget.authorname,
                  forumName: widget.title,
                  postText: parseBBCodeToHtml(widget.content),
                  date: widget.publishdate,
                  imageUrl: '',
                  joinedDate: widget.joinedDate,
                  postCount: widget.posts,
                ),

                SizedBox(height: 12),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateTopicPage(),
                        ),
                      );
                    },
                    buttonLabel: "Post Reply    +",
                  ),
                ),

                SizedBox(height: 25),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder<List<ForumSectionMenu>>(
                    future: _futureForumDetail,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No forum data available.'),
                        );
                      }

                      final sections = snapshot.data!;
                      return PaginatedForumList(forums: sections);
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: PostInputBox(
                    controller: TextEditingController(),
                    onLinkPressed: () => print("Link tapped"),
                    onImagePressed: () => print("Image tapped"),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateTopicPage(),
                        ),
                      );
                    },
                    buttonLabel: "Advanced Options    +",
                  ),
                ),

                const AppFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
