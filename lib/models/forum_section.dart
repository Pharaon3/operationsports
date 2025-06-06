class ForumSubItem {
  final String title;
  final String parentId;

  ForumSubItem({required this.title, required this.parentId});
}

class ForumSection {
  final String title;
  final List<ForumSubItem> subItems;

  ForumSection({required this.title, required this.subItems});

  factory ForumSection.fromMapEntry(MapEntry<String, dynamic> entry) {
    final data = entry.value as Map<String, dynamic>;
    final subChannels = data['subchannels'] as Map<String, dynamic>? ?? {};

    return ForumSection(
      title: data['title'] ?? 'Untitled',
      subItems:
          subChannels.entries.map<ForumSubItem>((subEntry) {
            final subData = subEntry.value as Map<String, dynamic>;
            return ForumSubItem(
              title: subData['title'] ?? 'Unnamed Subforum',
              parentId: subEntry.key,
            );
          }).toList(),
    );
  }
}

class ForumSectionMenu {
  final String id;
  final String title;
  final String authorname;
  final String lastcontentauthor;
  final String publishdate;
  final String userid;
  final String content;
  final String joinedDate;
  final String posts;
  final String useravatar;
  final int userrank;

  ForumSectionMenu({
    required this.id,
    required this.title,
    required this.authorname,
    required this.lastcontentauthor,
    required this.publishdate,
    required this.userid,
    required this.content,
    required this.joinedDate,
    required this.posts,
    required this.useravatar,
    required this.userrank,
  });

  factory ForumSectionMenu.fromMapEntry(MapEntry<String, dynamic> entry) {
    final data = entry.value as Map<String, dynamic>;
    final rankHtml = data['content']?['userinfo']?['rank'] ?? '';
    final iTagCount = RegExp(r'<i\b[^>]*>').allMatches(rankHtml).length;

    return ForumSectionMenu(
      id: entry.key,
      title: data['title'] ?? 'Untitled',
      authorname: data['authorname'] ?? '',
      lastcontentauthor: data['lastcontentauthor'] ?? '',
      publishdate: data['publishdate'] ?? '',
      userid: data['userid'] ?? '',
      content: data['content']?['rawtext'] ?? '',
      joinedDate: data['content']?['userinfo']?['joindate'] ?? '',
      posts: data['content']?['userinfo']?['posts'] ?? '',
      useravatar: data['content']?['avatar']?['avatarpath'] ?? '',
      userrank: iTagCount,
    );
  }
}
