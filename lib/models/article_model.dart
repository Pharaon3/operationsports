import 'package:intl/intl.dart';
import 'package:html/parser.dart' show parse;

class ArticleModel {
  final int id;
  final String title;
  final String excerpt;
  final String content;
  final String imageUrl;
  final String date;
  final String author;
  final List graph;

  ArticleModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.date,
    required this.author,
    required this.graph,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: convertHtmlEntities(_parseText(json['title']['rendered'])),
      excerpt: _parseText(json['excerpt']['rendered']),
      content: json['content']['rendered'] ?? '',
      imageUrl:
          json['yoast_head_json']?['og_image']?[0]?['url'] ??
          json['twitter_image'] ??
          '',
      date: json['date'] ?? '',
      author: json['yoast_head_json']?['author'] ?? '',
      graph: json['yoast_head_json']?['schema']?['@graph'] ?? [],
    );
  }

  String get websiteName {
    if (graph != null) {
      for (var item in graph) {
        if (item['@type'] == 'WebSite') {
          return item['name'] ?? '';
        }
      }
    }
    return '';
  }

  String get articleSection {
    if (graph != null) {
      for (var item in graph) {
        if (item['@type'] == 'NewsArticle') {
          return item['articleSection']?[0] ?? '';
        }
      }
    }
    return '';
  }

  static String _parseText(String? raw) {
    if (raw == null) return '';
    return raw
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  static String convertHtmlEntities(String input) {
    // Parse the input string to convert HTML entities
    var document = parse(input);
    return document.body?.text ?? '';
  }

  String get formattedDate {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('MMMM d, y').format(parsedDate).toUpperCase(); // e.g., May 12, 2025
    } catch (e) {
      return date; // fallback in case of error
    }
  }
}
