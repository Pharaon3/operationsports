import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/newsletter_model.dart';

class NewsletterService {
  static const String baseUrl = 'https://newsletter.operationsports.com/';

  /// Fetch list of recent posts
  static Future<List<NewsletterModel>> fetchNewsletters() async {
    final url = Uri.parse('$baseUrl/archive?page=4&_data=routes%2Farchive');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((json) => NewsletterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load newsletters');
    }
  }

  /// Fetch single newsletter by PAGE
  static Future<NewsletterModel> fetchNewsletterByPage(String page) async {
    final url = Uri.parse('$baseUrl/archive?page=$page&_data=routes%2Farchive');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return NewsletterModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load newsletter with page $page');
    }
  }
  /// Fetch single newsletter by ID
  static Future<NewsletterModel> fetchNewsletterById(String id) async {
    final url = Uri.parse('$baseUrl/posts/$id?_embed');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return NewsletterModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load newsletter with id $id');
    }
  }
}
