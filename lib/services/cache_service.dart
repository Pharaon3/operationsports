import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

class CacheService {
  static const String _articlesBox = 'articles';
  static const String _featuredArticlesBox = 'featured_articles';
  static const String _forumSectionsBox = 'forum_sections';
  static const String _forumActivityBox = 'forum_activity';
  static const String _forumSubscriptionsBox = 'forum_subscriptions';
  static const String _newslettersBox = 'newsletters';
  static const String _reviewsBox = 'reviews';
  
  static const Duration _defaultExpiration = Duration(hours: 1);
  static const Duration _forumExpiration = Duration(minutes: 30);
  static const Duration _newsletterExpiration = Duration(hours: 2);

  static Future<void> initialize() async {
    await Hive.initFlutter();
    
    await Hive.openBox(_articlesBox);
    await Hive.openBox(_featuredArticlesBox);
    await Hive.openBox(_forumSectionsBox);
    await Hive.openBox(_forumActivityBox);
    await Hive.openBox(_forumSubscriptionsBox);
    await Hive.openBox(_newslettersBox);
    await Hive.openBox(_reviewsBox);
  }

  static Future<void> _storeData(String boxName, String key, dynamic data, Duration expiration) async {
    final box = Hive.box(boxName);
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiration': expiration.inMilliseconds,
    };
    await box.put(key, json.encode(cacheData));
  }

  static Future<dynamic> _getData(String boxName, String key) async {
    final box = Hive.box(boxName);
    final cachedData = box.get(key);
    
    if (cachedData == null) return null;
    
    final decoded = json.decode(cachedData);
    final timestamp = decoded['timestamp'] as int;
    final expiration = decoded['expiration'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    if (now - timestamp > expiration) {
      await box.delete(key);
      return null;
    }
    
    return decoded['data'];
  }

  // Articles cache methods
  static Future<void> cacheArticles(List<dynamic> articles) async {
    await _storeData(_articlesBox, 'articles', articles, _defaultExpiration);
  }

  static Future<List<dynamic>?> getCachedArticles() async {
    return await _getData(_articlesBox, 'articles');
  }

  static Future<void> cacheFeaturedArticles(List<dynamic> articles) async {
    await _storeData(_featuredArticlesBox, 'featured_articles', articles, _defaultExpiration);
  }

  static Future<List<dynamic>?> getCachedFeaturedArticles() async {
    return await _getData(_featuredArticlesBox, 'featured_articles');
  }

  // Forum cache methods
  static Future<void> cacheForumSections(List<dynamic> sections) async {
    await _storeData(_forumSectionsBox, 'forum_sections', sections, _forumExpiration);
  }

  static Future<List<dynamic>?> getCachedForumSections() async {
    return await _getData(_forumSectionsBox, 'forum_sections');
  }

  static Future<void> cacheForumActivity(List<dynamic> activity) async {
    await _storeData(_forumActivityBox, 'forum_activity', activity, _forumExpiration);
  }

  static Future<List<dynamic>?> getCachedForumActivity() async {
    return await _getData(_forumActivityBox, 'forum_activity');
  }

  static Future<void> cacheForumSubscriptions(List<dynamic> subscriptions) async {
    await _storeData(_forumSubscriptionsBox, 'forum_subscriptions', subscriptions, _forumExpiration);
  }

  static Future<List<dynamic>?> getCachedForumSubscriptions() async {
    return await _getData(_forumSubscriptionsBox, 'forum_subscriptions');
  }

  // Newsletter cache methods
  static Future<void> cacheNewsletters(List<dynamic> newsletters) async {
    await _storeData(_newslettersBox, 'newsletters', newsletters, _newsletterExpiration);
  }

  static Future<List<dynamic>?> getCachedNewsletters() async {
    return await _getData(_newslettersBox, 'newsletters');
  }

  static Future<void> cacheNewsletterByPage(String page, Map<String, dynamic> data) async {
    await _storeData(_newslettersBox, 'newsletter_page_$page', data, _newsletterExpiration);
  }

  static Future<Map<String, dynamic>?> getCachedNewsletterByPage(String page) async {
    return await _getData(_newslettersBox, 'newsletter_page_$page');
  }

  // Reviews cache methods
  static Future<void> cacheReviews(List<dynamic> reviews) async {
    await _storeData(_reviewsBox, 'reviews', reviews, _defaultExpiration);
  }

  static Future<List<dynamic>?> getCachedReviews() async {
    return await _getData(_reviewsBox, 'reviews');
  }

  // Clear cache methods
  static Future<void> clearAllCache() async {
    await Hive.box(_articlesBox).clear();
    await Hive.box(_featuredArticlesBox).clear();
    await Hive.box(_forumSectionsBox).clear();
    await Hive.box(_forumActivityBox).clear();
    await Hive.box(_forumSubscriptionsBox).clear();
    await Hive.box(_newslettersBox).clear();
    await Hive.box(_reviewsBox).clear();
  }

  static Future<void> clearArticlesCache() async {
    await Hive.box(_articlesBox).clear();
    await Hive.box(_featuredArticlesBox).clear();
  }

  static Future<void> clearForumCache() async {
    await Hive.box(_forumSectionsBox).clear();
    await Hive.box(_forumActivityBox).clear();
    await Hive.box(_forumSubscriptionsBox).clear();
  }

  static Future<void> clearNewsletterCache() async {
    await Hive.box(_newslettersBox).clear();
  }

  static Future<void> clearReviewsCache() async {
    await Hive.box(_reviewsBox).clear();
  }
} 