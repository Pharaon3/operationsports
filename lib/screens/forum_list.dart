import 'package:flutter/material.dart';
import 'package:operationsports/screens/new_topic.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/topic_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/forum_submenu.dart';

class ForumList extends StatelessWidget {
  const ForumList({super.key});

  @override
  Widget build(BuildContext context) {
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

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ForumSubMenu(
                        title: 'All Pro Football 2K',
                        subItems: ['APF 2K Rosters'],
                      ),
                      ForumSubMenu(
                        title: 'ESPN NFL 2K5 Football',
                        subItems: [
                          'ESPN NFL 2K5 Rosters',
                          'ESPN NFL 2K5 Sliders',
                          'ESPN NFL 2K5 Online',
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: TopicGrid(
                    menuItems: [
                      'Topics',
                      'Latest Activity',
                      'My Subscriptions',
                    ],
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
                    buttonLabel: "New Topic    +",
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ForumSubMenu(
                        title: '',
                        subItems: [
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                        ],
                      ),
                    ],
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
