import 'package:flutter/material.dart';
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/services/newsletter_service.dart';

class NewsProvider with ChangeNotifier {
  List<ArticleModel> _newsletters = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  List<ArticleModel> get newsletters => _newsletters;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  NewsProvider() {
    fetchNewsLetter();
  }

  Future<void> fetchNewsLetter() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      _newsletters = await NewsletterService.fetchNewsletters();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
