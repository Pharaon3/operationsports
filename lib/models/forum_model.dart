import 'package:intl/intl.dart';

class ForumModel {
  final int id;
  final String forumName;
  final String postText;
  final String imageUrl;
  final String date;

  ForumModel({
    required this.id,
    required this.forumName,
    required this.postText,
    required this.imageUrl,
    required this.date,
  });

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      id: json['id'],
      forumName: (json['title']['rendered']),
      postText: _parseText(json['excerpt']['rendered']),
      imageUrl:
          json['yoast_head_json']?['og_image']?[0]?['url'] ??
          json['twitter_image'] ??
          '',
      date: json['date'] ?? '',
    );
  }
  static String _parseText(String? raw) {
    if (raw == null) return '';
    return raw
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  String get formattedDate {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat(
        'MMMM d, y',
      ).format(parsedDate).toUpperCase(); // e.g., May 12, 2025
    } catch (e) {
      return date; // fallback in case of error
    }
  }
}
