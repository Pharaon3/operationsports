import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ArticleService {
  static const String baseUrl = 'https://operationsports.com/wp-json/wp/v2';

  /// Fetch list of recent posts
  static Future<List<ArticleModel>> fetchArticles() async {
    final url = Uri.parse(
      '$baseUrl/posts?per_page=100&tags_exclude=52981&_fields=id,date_gmt,modified_gmt,title,content,excerpt,link,_links,_embedded,yoast_head_json,twitter_image&_embed=author,wp:term,wp:featured_media',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  /// Fetch list of recent posts
  static Future<List<ArticleModel>> fetchFeaturedArticles() async {
    final url = Uri.parse(
      '$baseUrl/posts?per_page=1&tags=60&_fields=id,date_gmt,modified_gmt,title,content,excerpt,link,_links,_embedded,yoast_head_json,twitter_image&_embed=author,wp:term,wp:featured_media',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  /// Fetch single article by ID
  static Future<ArticleModel> fetchArticleById(String id) async {
    final url = Uri.parse('$baseUrl/posts/$id?_embed');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ArticleModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load article with id $id');
    }
  }
}
