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

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'threadTitle': threadTitle,
      'forumTitle': forumTitle,
      'replySnippet': replySnippet,
      'date': date.millisecondsSinceEpoch,
      'avatarUrl': avatarUrl,
      'postUrl': postUrl,
    };
  }

  factory ForumActivityItem.fromJson(Map<String, dynamic> json) {
    return ForumActivityItem(
      username: json['username'] ?? '',
      threadTitle: json['threadTitle'] ?? '',
      forumTitle: json['forumTitle'] ?? '',
      replySnippet: json['replySnippet'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] ?? 0),
      avatarUrl: json['avatarUrl'] ?? '',
      postUrl: json['postUrl'] ?? '',
    );
  }
}
