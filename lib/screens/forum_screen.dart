import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/services/forum_service.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import '../widgets/app_footer.dart';
import '../widgets/forum_menu.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  late Future<List<ForumSection>> _futureForumSections;

  @override
  void initState() {
    super.initState();
    _futureForumSections = ForumService.fetchForumSections();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureForumSections = ForumService.fetchForumSections();
          });
        },
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
              child: FutureBuilder<List<ForumSection>>(
                future: _futureForumSections,
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
                  return Column(
                    children:
                        sections.map((section) {
                          return ForumMenu(
                            title: section.title,
                            subItems: section.subItems,
                          );
                        }).toList(),
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
