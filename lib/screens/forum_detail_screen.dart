import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_model.dart';
import 'package:operationsports/screens/new_topic.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/paginated_forum.dart';
import 'package:operationsports/widgets/post_input_box.dart';
import 'package:operationsports/test_data/test_forum_data.dart';

class ForumDetail extends StatelessWidget {
  const ForumDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: () async => {},
        child: Builder(
          builder: (context) {
            List<ForumModel> forumList = getTestForumList();
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

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '2k never getting the NFL sim license!!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
                  child: PaginatedForumList(
                    forums: [
                      ...forumList,
                      ...forumList,
                      ...forumList,
                      ...forumList,
                      ...forumList,
                    ],
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
