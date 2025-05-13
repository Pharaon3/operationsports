import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';

class ArticleProvider with ChangeNotifier {
  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

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
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
