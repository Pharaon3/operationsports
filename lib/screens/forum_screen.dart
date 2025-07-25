import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/providers/forum_provider.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:provider/provider.dart';
// import 'package:operationsports/widgets/menu_grid.dart';
import '../widgets/app_footer.dart';
import '../widgets/forum_menu.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize forum data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final forumProvider = Provider.of<ForumProvider>(context, listen: false);
      forumProvider.fetchForumSections();
    });
  }

  @override
  Widget build(BuildContext context) {
    final forumProvider = Provider.of<ForumProvider>(context);
    
    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: () async {
          await forumProvider.refreshForumSections();
        },
        child: ListView(
          children: [
            const Header(selectedMenu: 2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(
                builder: (context) {
                  if (forumProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (forumProvider.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${forumProvider.errorMessage}',
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              forumProvider.refreshForumSections();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else if (forumProvider.forumSections.isEmpty) {
                    return const Center(
                      child: Text(
                        'No forum data available.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final sections = forumProvider.forumSections;
                  return Column(
                    children: sections.map((section) {
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
