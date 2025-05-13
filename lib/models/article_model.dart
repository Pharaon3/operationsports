class ArticleModel {
  final int id;
  final String title;
  final String excerpt;
  final String content;

  ArticleModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: _parseText(json['title']['rendered']),
      excerpt: _parseText(json['excerpt']['rendered']),
      content: json['content']['rendered'] ?? '',
    );
  }

  static String _parseText(String? raw) {
    if (raw == null) return '';
    return raw.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ').trim();
  }
}
