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

  ForumSectionMenu({
    required this.id,
    required this.title,
    required this.authorname,
    required this.lastcontentauthor,
    required this.publishdate,
    required this.userid,
  });

  factory ForumSectionMenu.fromMapEntry(MapEntry<String, dynamic> entry) {
    final data = entry.value as Map<String, dynamic>;
    return ForumSectionMenu(
      id: entry.key,
      title: data['title'] ?? 'Untitled',
      authorname: data['authorname'] ?? '',
      lastcontentauthor: data['lastcontentauthor'] ?? '',
      publishdate: data['publishdate'] ?? '',
      userid: data['userid'] ?? '',
    );
  }
}
