import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_activity_item.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/screens/new_topic.dart';
import 'package:operationsports/services/forum_service.dart';
import 'package:operationsports/widgets/forum_activity_list.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/topic_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/forum_submenu.dart';

class ForumList extends StatefulWidget {
  final String parentId;
  const ForumList({super.key, required this.parentId});

  @override
  State<ForumList> createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {
  late Future<List<ForumSectionMenu>> _futureForumSectionMenu;
  String _selectedTab = 'Topics';

  @override
  void initState() {
    super.initState();
    _loadForumSectionMenu();
  }

  void _loadForumSectionMenu() {
    _futureForumSectionMenu = ForumService.fetchForumSectionMenu(
      widget.parentId,
    );
  }

  Future<void> _handleRefresh() async {
    _loadForumSectionMenu();
    setState(() {}); // Trigger rebuild with new data
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder<List<ForumSectionMenu>>(
                future: _futureForumSectionMenu,
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
                  final subForumTitles =
                      sections.where((s) => s.userid == "1").toList();
                  final topicTitles =
                      sections.where((s) => s.userid != "1").toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subForumTitles.isNotEmpty)
                        ForumSubMenu(
                          title: 'Sub Forums',
                          subItems: subForumTitles,
                        ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TopicGrid(
                          menuItems: [
                            'Topics',
                            'Latest Activity',
                            'My Subscriptions',
                            'Photos',
                          ],
                          selectedItem: _selectedTab,
                          onItemSelected: (value) {
                            setState(() {
                              _selectedTab = value;
                            });
                          },
                        ),
                      ),
                      if (_selectedTab == 'Topics') ...[
                        DefaultButton(
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
                        const SizedBox(height: 20),
                        if (topicTitles.isNotEmpty)
                          ForumSubMenu(title: '', subItems: topicTitles),
                      ] else if (_selectedTab == 'Latest Activity') ...[
                        FutureBuilder<List<ForumActivityItem>>(
                          future: ForumService.fetchLatestActivity(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Failed to load latest activity'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('No recent activity.'),
                              );
                            }

                            return ForumActivityList(
                              activities: snapshot.data!,
                            );
                          },
                        ),
                      ] else if (_selectedTab == 'My Subscriptions') ...[
                        FutureBuilder<List<ForumActivityItem>>(
                          future: ForumService.fetchMySubscriptions(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('No subscriptions found.'),
                              );
                            }

                            final subscriptions = snapshot.data!;
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: subscriptions.length,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (context, index) {
                                final item = subscriptions[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      item.avatarUrl,
                                    ),
                                  ),
                                  title: Text(item.threadTitle),
                                  subtitle: Text(
                                    '${item.username} · ${item.forumTitle}',
                                  ),
                                  onTap: () {
                                    // You can use url_launcher to open item.postUrl in browser
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ] else if (_selectedTab == 'Photos') ...[
                        const Text('Show photo content here'),
                      ],
                    ],
                  );
                },
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
