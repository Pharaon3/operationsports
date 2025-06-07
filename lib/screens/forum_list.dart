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
  List<ForumSectionMenu> _forumSections = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _selectedTab = 'Topics';

  @override
  void initState() {
    super.initState();
    _loadMoreForumSections(); // Initial load
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _forumSections.clear();
      _currentPage = 1;
      _hasMore = true;
    });
    await _loadMoreForumSections();
  }

  Future<void> _loadMoreForumSections() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newSections = await ForumService.fetchForumSectionMenu(
        widget.parentId,
        _currentPage,
      );

      setState(() {
        _forumSections.addAll(newSections);
        if (newSections.isEmpty) {
          _hasMore = false;
        } else {
          _currentPage++;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasMore = false;
      });
      debugPrint('Error loading forum sections: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final subForumTitles =
        _forumSections.where((s) => s.userid == "1").toList();
    final topicTitles = _forumSections.where((s) => s.userid != "1").toList();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subForumTitles.isNotEmpty)
                    ForumSubMenu(title: 'Sub Forums', subItems: subForumTitles),

                  const SizedBox(height: 20),

                  TopicGrid(
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

                  const SizedBox(height: 20),

                  if (_selectedTab == 'Topics') ...[
                    DefaultButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateTopicPage(),
                          ),
                        );
                      },
                      buttonLabel: "New Topic    +",
                    ),
                    const SizedBox(height: 20),
                    if (topicTitles.isNotEmpty)
                      ForumSubMenu(title: '', subItems: topicTitles),
                    if (_hasMore && !_isLoading)
                      Center(
                        child: TextButton(
                          onPressed: _loadMoreForumSections,
                          child: const Text('Load More'),
                        ),
                      ),
                    if (_isLoading)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
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
                          return const Center(
                            child: Text('Failed to load latest activity.'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No recent activity.'),
                          );
                        }

                        return ForumActivityList(activities: snapshot.data!);
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
                                backgroundImage: NetworkImage(item.avatarUrl),
                              ),
                              title: Text(item.threadTitle),
                              subtitle: Text(
                                '${item.username} · ${item.forumTitle}',
                              ),
                              onTap: () {
                                // Use url_launcher to open item.postUrl if needed
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
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
