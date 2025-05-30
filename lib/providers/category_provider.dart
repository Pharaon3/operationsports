import 'package:flutter/material.dart';
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/models/category_model.dart';
import 'package:operationsports/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  List<CategoryModel> get categories => _categories;
  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  CategoryProvider() {
    fetchCategories();
    fetchCategoryPost(1);
  }

  Future<List<ArticleModel>> getCategoryPost(int categoryId) async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
    _articles = await CategoryService.fetchCategoriesPost(categoryId);
    return _articles;
  }

  Future<void> fetchCategoryPost(int categoryId) async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      _articles = await CategoryService.fetchCategoriesPost(categoryId);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      _categories = await CategoryService.fetchCategories();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
