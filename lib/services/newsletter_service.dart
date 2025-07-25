import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:operationsports/models/article_model.dart';
import 'cache_service.dart';

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

  final subscribeApi = dotenv.env['NEWS_API'] ?? '';
  final publication = dotenv.env['NEWS_PUBLICATION'] ?? '';

  /// Fetch list of recent posts
  static Future<List<ArticleModel>> fetchNewsletters() async {
    print('Fetching newsletters...'); // Debug log
    
    // Check cache first
    final cachedData = await CacheService.getCachedNewsletters();
    if (cachedData != null) {
      print('Using cached newsletters: ${cachedData.length}'); // Debug log
      return cachedData.map((json) => ArticleModel.fromNewsletter(json)).toList();
    }

    print('No cached data, fetching from API...'); // Debug log
    
    // Fetch from API if not cached - try without proxy first
    final url = Uri.parse('$baseUrl/archive?page=4&_data=routes%2Farchive');
    print('Fetching from URL: $url'); // Debug log
    
    try {
      // Try with regular HTTP client first
      final response = await http.get(url);
      print('Response status: ${response.statusCode}'); // Debug log

      if (response.statusCode == 200) {
        final List jsonList =
            json.decode(response.body)['paginatedPosts']['posts'];
        final newsletters = jsonList.map((json) => ArticleModel.fromNewsletter(json)).toList();
        
        print('Successfully fetched ${newsletters.length} newsletters'); // Debug log
        
        // Cache the response
        await CacheService.cacheNewsletters(jsonList);
        
        return newsletters;
      } else {
        print('Failed to fetch newsletters, status: ${response.statusCode}'); // Debug log
        return [];
      }
    } catch (e) {
      print('Error with regular HTTP client: $e'); // Debug log
      
      // Try with proxy client as fallback
      try {
        final client = createProxiedHttpClient();
        final response = await client.get(url);
        print('Proxy response status: ${response.statusCode}'); // Debug log

        if (response.statusCode == 200) {
          final List jsonList =
              json.decode(response.body)['paginatedPosts']['posts'];
          final newsletters = jsonList.map((json) => ArticleModel.fromNewsletter(json)).toList();
          
          print('Successfully fetched ${newsletters.length} newsletters via proxy'); // Debug log
          
          // Cache the response
          await CacheService.cacheNewsletters(jsonList);
          
          return newsletters;
        } else {
          print('Failed to fetch newsletters via proxy, status: ${response.statusCode}'); // Debug log
          return [];
        }
      } catch (proxyError) {
        print('Error with proxy client: $proxyError'); // Debug log
        return [];
      }
    }
  }

  /// Fetch single newsletter by PAGE
  static dynamic fetchNewsletterByPage(String page) async {
    print('Fetching newsletter page $page...'); // Debug log
    
    // Check cache first
    final cachedData = await CacheService.getCachedNewsletterByPage(page);
    if (cachedData != null) {
      print('Using cached newsletter page $page'); // Debug log
      return {
        "posts": cachedData['posts'].map((json) => ArticleModel.fromNewsletter(json)).toList(),
        "totalpages": cachedData['totalpages'],
      };
    }

    print('No cached data for page $page, fetching from API...'); // Debug log
    
    // Fetch from API if not cached - try without proxy first
    final url = Uri.parse('$baseUrl/archive?page=$page&_data=routes%2Farchive');
    print('Fetching from URL: $url'); // Debug log
    
    try {
      // Try with regular HTTP client first
      final response = await http.get(url);
      print('Response status: ${response.statusCode}'); // Debug log

      if (response.statusCode == 200) {
        final List jsonList =
            json.decode(response.body)['paginatedPosts']['posts'];
        final totalPages =
            json.decode(
              response.body,
            )['paginatedPosts']['pagination']['total_pages'];
        
        final result = {
          "posts": jsonList.map((json) => ArticleModel.fromNewsletter(json)).toList(),
          "totalpages": totalPages,
        };

        print('Successfully fetched newsletter page $page with ${result['posts'].length} posts'); // Debug log

        // Cache the response
        await CacheService.cacheNewsletterByPage(page, {
          "posts": jsonList,
          "totalpages": totalPages,
        });

        return result;
      } else {
        print('Failed to fetch newsletter page $page, status: ${response.statusCode}'); // Debug log
        throw Exception('Failed to load newsletter with page $page');
      }
    } catch (e) {
      print('Error with regular HTTP client for page $page: $e'); // Debug log
      
      // Try with proxy client as fallback
      try {
        final client = createProxiedHttpClient();
        final response = await client.get(url);
        print('Proxy response status: ${response.statusCode}'); // Debug log

        if (response.statusCode == 200) {
          final List jsonList =
              json.decode(response.body)['paginatedPosts']['posts'];
          final totalPages =
              json.decode(
                response.body,
              )['paginatedPosts']['pagination']['total_pages'];
          
          final result = {
            "posts": jsonList.map((json) => ArticleModel.fromNewsletter(json)).toList(),
            "totalpages": totalPages,
          };

          print('Successfully fetched newsletter page $page via proxy with ${result['posts'].length} posts'); // Debug log

          // Cache the response
          await CacheService.cacheNewsletterByPage(page, {
            "posts": jsonList,
            "totalpages": totalPages,
          });

          return result;
        } else {
          print('Failed to fetch newsletter page $page via proxy, status: ${response.statusCode}'); // Debug log
          throw Exception('Failed to load newsletter with page $page');
        }
      } catch (proxyError) {
        print('Error with proxy client for page $page: $proxyError'); // Debug log
        throw Exception('Failed to load newsletter with page $page');
      }
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

  Future<bool> checkSubscribe(String email) async {
    var headers = {'Authorization': 'Bearer $subscribeApi'};
    var request = http.Request(
      'GET',
      Uri.parse(
        'https://api.beehiiv.com/v2/publications/$publication/subscriptions/by_email/$email',
      ),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
