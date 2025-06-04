import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:operationsports/models/forum_activity_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ForumActivityList extends StatelessWidget {
  final List<ForumActivityItem> activities;

  const ForumActivityList({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(item.avatarUrl),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: '${item.username} ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: 'replied to '),
                          TextSpan(
                            text: item.threadTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '\nin ${item.forumTitle}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item.replySnippet,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    DateFormat('MM-dd-yyyy, hh:mm a').format(item.date),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Handle navigation
                      launchUrl(Uri.parse(item.postUrl));
                    },
                    child: const Text('GO TO POST'),
                  )
                ],
              ),
              const Divider(),
            ],
          ),
        );
      }).toList(),
    );
  }
}
