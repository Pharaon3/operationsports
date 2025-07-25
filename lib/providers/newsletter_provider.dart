import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/newsletter_service.dart';
import '../services/cache_service.dart';

class NewsletterProvider with ChangeNotifier {
  List<ArticleModel> _newsletters = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  List<ArticleModel> get newsletters => _newsletters;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  NewsletterProvider() {
    fetchNewsletters();
  }

  Future<void> fetchNewsletters() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      print('NewsletterProvider: Starting to fetch newsletters...'); // Debug log
      _newsletters = await NewsletterService.fetchNewsletters();
      print('NewsletterProvider: Newsletters fetched: ${_newsletters.length}'); // Debug log
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      print('NewsletterProvider: Error fetching newsletters: $e'); // Debug log
      
      // Add some test data if the API fails
      if (_newsletters.isEmpty) {
        print('NewsletterProvider: Adding test data...'); // Debug log
        _newsletters = [
          ArticleModel(
            id: 1,
            title: 'Test Newsletter',
            excerpt: 'This is a test newsletter',
            content: 'Test content',
            imageUrl: '',
            date: DateTime.now().toIso8601String(),
            author: 'Test Author',
            graph: [],
          ),
        ];
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> fetchNewsletterByPage(String page) async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      print('NewsletterProvider: Fetching newsletter page $page...'); // Debug log
      final result = await NewsletterService.fetchNewsletterByPage(page);
      print('NewsletterProvider: Successfully fetched page $page with ${result['posts'].length} posts'); // Debug log
      return result;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      print('NewsletterProvider: Error fetching page $page: $e'); // Debug log
      return {"posts": [], "totalpages": 0};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshNewsletters() async {
    await CacheService.clearNewsletterCache();
    await fetchNewsletters();
  }

  Future<void> refreshNewsletterByPage(String page) async {
    await CacheService.clearNewsletterCache();
    await fetchNewsletterByPage(page);
  }
} 