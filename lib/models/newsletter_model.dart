import 'package:intl/intl.dart';
import 'package:html/parser.dart' show parse;
import 'package:operationsports/models/displayable_content.dart';

class NewsletterModel  implements DisplayableContent{
  @override
  final int id;
  @override
  final String title;
  @override
  final String excerpt;
  @override
  final String content;
  @override
  final String imageUrl;
  @override
  final String date;
  @override
  final String author;
  @override
  final List graph;

  NewsletterModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.date,
    required this.author,
    required this.graph,
  });

  factory NewsletterModel.fromJson(Map<String, dynamic> json) {
    print("json: $json");
    return NewsletterModel(
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
    for (var item in graph) {
      if (item['@type'] == 'WebSite') {
        return item['name'] ?? '';
      }
    }
      return '';
  }

  String get newsletterSection {
    for (var item in graph) {
      if (item['@type'] == 'NewsNewsletter') {
        return item['newsletterSection']?[0] ?? '';
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
  
  @override
  // TODO: implement articleSection
  String get articleSection => throw UnimplementedError();
}
