import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:operationsports/models/article_model.dart';

http.Client createProxiedHttpClient() {
  final proxyIp = dotenv.env['PROXYIP'] ?? '';
  final proxyPort = dotenv.env['PROXYPORT'] ?? '';
  final username = dotenv.env['PROXYUSERNAME'] ?? '';
  final password = dotenv.env['PROXYPASSWORD'] ?? '';

  final client =
      HttpClient()
        ..findProxy = (uri) {
          return "PROXY $proxyIp:$proxyPort";
        }
        ..addProxyCredentials(
          proxyIp,
          int.parse(proxyPort),
          '',
          HttpClientBasicCredentials(username, password),
        )
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true; // optional

  // Add proxy auth manually in headers (for some proxies)
  return IOClient(client);
}

class NewsletterService {
  static const String baseUrl = 'https://newsletter.operationsports.com/';

  /// Fetch list of recent posts
  static Future<List<ArticleModel>> fetchNewsletters() async {
    final client = createProxiedHttpClient();
    final url = Uri.parse('$baseUrl/archive?page=4&_data=routes%2Farchive');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List jsonList =
          json.decode(response.body)['paginatedPosts']['posts'];
      return jsonList.map((json) => ArticleModel.fromNewsletter(json)).toList();
    } else {
      return [];
    }
  }

  /// Fetch single newsletter by PAGE
  static dynamic fetchNewsletterByPage(String page) async {
    final client = createProxiedHttpClient();
    final url = Uri.parse('$baseUrl/archive?page=$page&_data=routes%2Farchive');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body)['paginatedPosts']['posts'];
      final totalPages =
          json.decode(
            response.body,
          )['paginatedPosts']['pagination']['total_pages'];
      return {
        "posts": jsonList.map((json) => ArticleModel.fromNewsletter(json)).toList(),
        "totalpages": totalPages,
      };
    } else {
      throw Exception('Failed to load newsletter with page $page');
    }
  }

  /// Fetch single newsletter by Slug
  static Future<String> fetchNewsletterBySlug(String slug) async {
    final client = createProxiedHttpClient();
    final url = Uri.parse('$baseUrl/p/$slug?_data=routes%2Fp%2F%24slug');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)['html'];
    } else {
      throw Exception('Failed to load newsletter with slug $slug');
    }
  }
}
