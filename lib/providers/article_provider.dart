import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';
import '../services/cache_service.dart';

class ArticleProvider with ChangeNotifier {
  List<ArticleModel> _articles = [];
  List<ArticleModel> _featuredArticles = [];
  List<ArticleModel> _filteredArticles = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  String _searchQuery = '';

  List<ArticleModel> get articles => _searchQuery.isEmpty ? _articles : _filteredArticles;
  List<ArticleModel> get featuredArticles => _featuredArticles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get isSearchMode => _searchQuery.isNotEmpty;

  ArticleProvider() {
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      _articles = await ArticleService.fetchArticles();
      _featuredArticles = await ArticleService.fetchFeaturedArticles();
      _filteredArticles = List.from(_articles);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshArticles() async {
    // Clear cache and fetch fresh data
    await CacheService.clearArticlesCache();
    await fetchArticles();
  }

  void searchArticles(String query) {
    _searchQuery = query.toLowerCase().trim();
    
    if (_searchQuery.isEmpty) {
      _filteredArticles = List.from(_articles);
    } else {
      _filteredArticles = _articles.where((article) {
        return article.title.toLowerCase().contains(_searchQuery) ||
               article.excerpt.toLowerCase().contains(_searchQuery) ||
               article.content.toLowerCase().contains(_searchQuery) ||
               article.author.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredArticles = List.from(_articles);
    notifyListeners();
  }
}
