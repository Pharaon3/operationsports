import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:operationsports/models/forum_activity_item.dart';
import 'package:operationsports/utils/shared_prefs.dart';
import '../models/forum_section.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cache_service.dart';

Future<void> saveUserInfo(
  String email,
  String username,
  String userid,
  String joindate,
  String posts,
  String avatarid,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  await prefs.setString('username', username);
  await prefs.setString('userid', userid);
  await prefs.setString('joindate', joindate);
  await prefs.setString('posts', posts);
  await prefs.setString('avatarid', avatarid);
}

class ForumService {
  static final String _baseUrl =
      'https://forums.operationsports.com/forums/api.php';
  static final String _apiKey = dotenv.env['API_KEY'] ?? '';

  static String? _apiAccessToken;
  static String? _apiClientId;
  static String? _secret;

  static Future<void> initializeApiSession() async {
    final uri = Uri.parse(
      '$_baseUrl?api_m=api.init&clientname=OpSportsApp&clientversion=1.0&platformname=iOS&platformversion=18.0&uniqueid=OpSportsApp',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _apiAccessToken = data['apiaccesstoken'];
      _apiClientId = data['apiclientid'].toString();
      _secret = data['secret'];
    } else {
      throw Exception('Failed to initialize API session');
    }
  }

  static Future<List<ForumSection>> fetchForumSections() async {
    // Check cache first
    final cachedData = await CacheService.getCachedForumSections();
    if (cachedData != null) {
      try {
        print('ForumService: Using cached forum sections: ${cachedData.length}'); // Debug log
        return cachedData.map((json) => ForumSection.fromJson(json)).toList();
      } catch (e) {
        print('ForumService: Error parsing cached forum sections: $e'); // Debug log
        // If cached data is corrupted, clear it and fetch fresh data
        await CacheService.clearForumCache();
      }
    }

    print('ForumService: Fetching fresh forum sections...'); // Debug log
    await _ensureInitialized();

    final signature = _generateSignature(
      base: 'api_m=node.fetchChannelNodeTree',
    );

    final uri = Uri.parse(
      '$_baseUrl?api_m=node.fetchChannelNodeTree&api_c=$_apiClientId&api_s=$_apiAccessToken&api_sig=$signature',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('ForumService: Response data keys: ${data.keys.toList()}'); // Debug log
      
      if (data['channels'] is Map<String, dynamic>) {
        final channels = data['channels'] as Map<String, dynamic>;
        final sections =
            channels.entries
                .map((entry) => ForumSection.fromMapEntry(entry))
                .where((section) => section.subItems.isNotEmpty)
                .toList();
        
        print('ForumService: Successfully parsed ${sections.length} forum sections'); // Debug log
        
        // Cache the response
        final sectionsJson = sections.map((section) => section.toJson()).toList();
        await CacheService.cacheForumSections(sectionsJson);
        
        return sections;
      } else {
        print('ForumService: channels is not Map<String, dynamic>, type: ${data['channels'].runtimeType}'); // Debug log
        return [];
      }
    } else {
      print('ForumService: HTTP error ${response.statusCode}'); // Debug log
      return [];
    }
  }

  static Future<List<ForumSectionMenu>> fetchForumSectionMenu(
    String parentId,
    int page,
  ) async {
    await _ensureInitialized();

    final baseString =
        'api_m=node.listNodeFullContent&depth=1&page=$page&parentid=$parentId&perpage=20';
    final signature = _generateSignature(base: baseString);

    final uri = Uri.parse(
      '$_baseUrl?api_m=node.listNodeFullContent&api_c=$_apiClientId&api_s=$_apiAccessToken&api_sig=$signature&depth=1&parentid=$parentId&page=$page&perpage=20',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic>) {
        final sections =
            data.entries
                .map((entry) => ForumSectionMenu.fromMapEntry(entry))
                .toList();
        return sections;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<List<ForumActivityItem>> fetchLatestActivity() async {
    // Check cache first
    final cachedData = await CacheService.getCachedForumActivity();
    if (cachedData != null) {
      try {
        print('ForumService: Using cached forum activity: ${cachedData.length}'); // Debug log
        return cachedData.map((item) => ForumActivityItem.fromJson(item)).toList();
      } catch (e) {
        print('ForumService: Error parsing cached forum activity: $e'); // Debug log
        // If cached data is corrupted, clear it and fetch fresh data
        await CacheService.clearForumCache();
      }
    }

    await _ensureInitialized();

    const baseCall = 'api_m=stream.get&perpage=10';
    final signature = _generateSignature(base: baseCall);

    final uri = Uri.parse(
      '$_baseUrl?api_m=stream.get&perpage=10'
      '&api_c=$_apiClientId&api_s=$_apiAccessToken&api_sig=$signature',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final rawItems = data['activity'] as List<dynamic>;
      final activityItems = rawItems.map((item) {
        return ForumActivityItem(
          username: item['authorname'] ?? '',
          threadTitle: item['title'] ?? '',
          forumTitle: item['forum_title'] ?? '',
          replySnippet: item['previewtext'] ?? '',
          date: DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(item['publishdate'].toString())! * 1000,
          ),
          avatarUrl: item['avatarurl'] ?? '',
          postUrl: item['url'] ?? '',
        );
      }).toList();

      // Cache the response
      final activityJson = activityItems.map((item) => item.toJson()).toList();
      await CacheService.cacheForumActivity(activityJson);

      return activityItems;
    } else {
      throw Exception('Failed to fetch latest activity.');
    }
  }

  static Future<List<ForumActivityItem>> fetchMySubscriptions() async {
    // Check cache first
    final cachedData = await CacheService.getCachedForumSubscriptions();
    if (cachedData != null) {
      try {
        print('ForumService: Using cached forum subscriptions: ${cachedData.length}'); // Debug log
        return cachedData.map((item) => ForumActivityItem.fromJson(item)).toList();
      } catch (e) {
        print('ForumService: Error parsing cached forum subscriptions: $e'); // Debug log
        // If cached data is corrupted, clear it and fetch fresh data
        await CacheService.clearForumCache();
      }
    }

    await _ensureInitialized();

    const baseCall = 'api_m=subscription.listSubscriptions';
    final signature = _generateSignature(base: baseCall);

    final uri = Uri.parse(
      '$_baseUrl?api_m=subscription.listSubscriptions'
      '&api_c=$_apiClientId&api_s=$_apiAccessToken&api_sig=$signature',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final subscriptions = data['subscriptions'] as List<dynamic>;
      final subscriptionItems = subscriptions.map((item) {
        return ForumActivityItem(
          username: item['lastposter'] ?? '',
          threadTitle: item['title'] ?? '',
          forumTitle: item['forumtitle'] ?? '',
          replySnippet: item['excerpt'] ?? '',
          date: DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(item['lastpost'])! * 1000,
          ),
          avatarUrl: item['avatarurl'] ?? '',
          postUrl: item['url'] ?? '',
        );
      }).toList();

      // Cache the response
      final subscriptionJson = subscriptionItems.map((item) => item.toJson()).toList();
      await CacheService.cacheForumSubscriptions(subscriptionJson);

      return subscriptionItems;
    } else {
      throw Exception('Failed to fetch subscriptions');
    }
  }

  /// Create a new topic in a forum
  static Future<Map<String, dynamic>> createTopic({
    required String forumId,
    required String title,
    required String content,
  }) async {
    // Get the stored security token
    final securityToken = await SharedPrefs.getToken();
    if (securityToken == null) {
      throw Exception('No security token found. Please login first.');
    }

    final url = Uri.parse(
      'https://forums.operationsports.com/forums/create-content/text/',
    );

    final body = {
      'securitytoken': securityToken,
      'parentid': forumId,
      'title': title,
      'text':
          content, // Note: using 'text' not 'rawtext' as per your specification
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("data: $data");

      // Check if the response indicates success
      if (data['success'] == true || data['nodeid'] != null) {
        return {
          'success': true,
          'nodeid': data['nodeid'],
          'message': data['message'] ?? 'Topic created successfully',
        };
      } else {
        throw Exception(data['message'] ?? 'Failed to create topic');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}: Failed to create topic');
    }
  }

  /// Create a reply to a topic
  static Future<Map<String, dynamic>> createReply({
    required String topicId,
    required String content,
  }) async {
    final securityToken = await SharedPrefs.getToken();
    if (securityToken == null) {
      throw Exception('No security token found. Please login first.');
    }

    final url = Uri.parse(
      'https://forums.operationsports.com/forums/create-content/text/',
    );
    final body = {
      'securitytoken': securityToken,
      'parentid': topicId,
      'text': content,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("data: $data");
      if (data['success'] == true || data['nodeid'] != null) {
        return {
          'success': true,
          'nodeid': data['nodeid'],
          'message': data['message'] ?? 'Reply posted successfully',
        };
      } else {
        throw Exception(data['message'] ?? 'Failed to post reply');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}: Failed to post reply');
    }
  }

  /// Fetch current user info after login
  static Future<Map<String, dynamic>> fetchUserInfo(username, password) async {
    await _ensureInitialized();
    final signature = _generateSignature(
      base: 'api_m=user.login&password=$password&username=$username',
    );

    final uri = Uri.parse(
      '$_baseUrl?api_m=user.login&username=$username&password=$password&api_c=$_apiClientId&api_s=$_apiAccessToken&api_sig=$signature',
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final signature1 = _generateSignature(base: 'api_m=user.fetchUserInfo');
      final uri1 = Uri.parse(
        '$_baseUrl?api_m=user.fetchUserInfo&api_c=$_apiClientId&api_s=$_apiAccessToken&api_sig=$signature1',
      );
      print("uri1: $uri1");
      await Future.delayed(const Duration(seconds: 2));
      final response1 = await http.get(uri1);
      if (response1.statusCode == 200) {
        final data1 = json.decode(response1.body);
        String email = data1['email'] ?? '';
        String username = data1['username'] ?? '';
        String userid = data1['userid'] ?? '';
        String joindate = data1['joindate'] ?? '';
        String posts = data1['posts'] ?? '';
        String avatarid = data1['avatarid'] ?? '';
        saveUserInfo(email, username, userid, joindate, posts, avatarid);
        return data1;
      } else {
        throw Exception(
          'HTTP ${response1.statusCode}: Failed to fetch user info',
        );
      }
    } else {
      throw Exception('HTTP ${response.statusCode}: Failed to fetch user info');
    }
  }

  static String _generateSignature({required String base}) {
    final combined = '$base$_apiAccessToken$_apiClientId$_secret$_apiKey';
    return md5.convert(utf8.encode(combined)).toString();
  }

  static Future<void> _ensureInitialized() async {
    if (_apiAccessToken == null || _apiClientId == null || _secret == null) {
      await initializeApiSession();
    }
  }
}
