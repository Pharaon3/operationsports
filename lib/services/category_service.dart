import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/models/category_model.dart';
import 'cache_service.dart';

class CategoryService {
  static const String baseUrl = 'https://www.operationsports.com/wp-json/wp/v2';

  static Future<List<CategoryModel>> fetchCategories() async {
    final url = Uri.parse('$baseUrl/categories?per_page=100');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      // print("jsonList $jsonList");
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories.');
    }
  }

  // fetch game categories by page number
  static Future<CategoryModel> fetchCategoryByPage(int page) async {
    final url = Uri.parse('$baseUrl/categories?per_page=100&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return CategoryModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load categories with id $page');
    }
  }

  static Future<Map<String, dynamic>> fetchCategoriesPaginated(int page) async {
    final url = Uri.parse('$baseUrl/categories?per_page=20&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      final totalPages =
          int.tryParse(response.headers['x-wp-totalpages'] ?? '1') ?? 1;
      return {
        'categories':
            jsonList.map((json) => CategoryModel.fromJson(json)).toList(),
        'totalPages': totalPages,
      };
    } else {
      throw Exception('Failed to load categories for page $page');
    }
  }

  static Future<List<ArticleModel>> fetchCategoriesPost(int categoryId) async {
    // For reviews (category 4849), check cache first
    if (categoryId == 4849) {
      final cachedData = await CacheService.getCachedReviews();
      if (cachedData != null) {
        return cachedData.map((json) => ArticleModel.fromJson(json)).toList();
      }
    }

    final url = Uri.parse('$baseUrl/posts?categories=$categoryId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      final articles = jsonList.map((json) => ArticleModel.fromJson(json)).toList();
      
      // Cache reviews if this is the reviews category
      if (categoryId == 4849) {
        await CacheService.cacheReviews(jsonList);
      }
      
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
