class ForumSection {
  final String title;
  final List<String> subItems;

  ForumSection({required this.title, required this.subItems});

  factory ForumSection.fromMapEntry(MapEntry<String, dynamic> entry) {
    final data = entry.value as Map<String, dynamic>;
    final subChannels = data['subchannels'] as Map<String, dynamic>? ?? {};

    return ForumSection(
      title: data['title'] ?? 'Untitled',
      subItems: subChannels.values
          .map<String>((sub) => sub['title'] ?? 'Unnamed Subforum')
          .toList(),
    );
  }
}
