class ForumActivityItem {
  final String username;
  final String threadTitle;
  final String forumTitle;
  final String replySnippet;
  final DateTime date;
  final String avatarUrl;
  final String postUrl;

  ForumActivityItem({
    required this.username,
    required this.threadTitle,
    required this.forumTitle,
    required this.replySnippet,
    required this.date,
    required this.avatarUrl,
    required this.postUrl,
  });
}
