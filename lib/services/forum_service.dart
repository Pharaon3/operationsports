import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:operationsports/models/forum_activity_item.dart';
import '../models/forum_section.dart';

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
      final channels = data['channels'] as Map<String, dynamic>;
      final sections =
          channels.entries
              .map((entry) => ForumSection.fromMapEntry(entry))
              .where((section) => section.subItems.isNotEmpty)
              .toList();
      return sections;
    } else {
      throw Exception('Failed to fetch forum sections');
    }
  }

  static Future<List<ForumSectionMenu>> fetchForumSectionMenu(
    String parentId,
  ) async {
    await _ensureInitialized();

    final baseString =
        'api_m=node.listNodeFullContent&depth=1&page=1&parentid=$parentId&perpage=20';
    final signature = _generateSignature(base: baseString);

    final uri = Uri.parse(
      '$_baseUrl?api_m=node.listNodeFullContent&api_c=$_apiClientId&api_s=$_apiAccessToken&api_sig=$signature&depth=1&parentid=$parentId&page=1&perpage=20',
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
      return rawItems.map((item) {
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
    } else {
      throw Exception('Failed to fetch latest activity.');
    }
  }

  static Future<List<ForumActivityItem>> fetchMySubscriptions() async {
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
      return subscriptions.map((item) {
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
    } else {
      throw Exception('Failed to fetch subscriptions');
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
