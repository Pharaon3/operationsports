class ArticleModel {
  final int id;
  final String title;
  final String excerpt;
  final String content;
  final String imageUrl;

  ArticleModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: _parseText(json['title']['rendered']),
      excerpt: _parseText(json['excerpt']['rendered']),
      content: json['content']['rendered'] ?? '',
      imageUrl: json['yoast_head_json']?['og_image']?[0]?['url'] ?? json['twitter_image'] ?? '',
    );
  }

  static String _parseText(String? raw) {
    if (raw == null) return '';
    return raw.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ').trim();
  }
}
