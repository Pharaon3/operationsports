import 'package:flutter/material.dart';
import 'package:operationsports/services/forum_service.dart';
import 'package:operationsports/models/forum_activity_item.dart';

class ForumMySubscriptions extends StatefulWidget {
  const ForumMySubscriptions({super.key});

  @override
  State<ForumMySubscriptions> createState() => _ForumMySubscriptionsState();
}

class _ForumMySubscriptionsState extends State<ForumMySubscriptions> {
  late Future<List<ForumActivityItem>> _subscriptions;

  @override
  void initState() {
    super.initState();
    _subscriptions = ForumService.fetchMySubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Subscriptions')),
      body: FutureBuilder<List<ForumActivityItem>>(
        future: _subscriptions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No subscriptions found.'));
          }

          final items = snapshot.data!;
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.avatarUrl),
                ),
                title: Text(item.threadTitle),
                subtitle: Text('${item.username} · ${item.forumTitle}'),
                onTap: () {
                  // Open postUrl
                },
              );
            },
          );
        },
      ),
    );
  }
}
