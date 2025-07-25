import 'package:flutter/material.dart';
import '../models/forum_section.dart';
import '../models/forum_activity_item.dart';
import '../services/forum_service.dart';
import '../services/cache_service.dart';

class ForumProvider with ChangeNotifier {
  List<ForumSection> _forumSections = [];
  List<ForumActivityItem> _latestActivity = [];
  List<ForumActivityItem> _mySubscriptions = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  List<ForumSection> get forumSections => _forumSections;
  List<ForumActivityItem> get latestActivity => _latestActivity;
  List<ForumActivityItem> get mySubscriptions => _mySubscriptions;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  ForumProvider() {
    fetchForumSections();
  }

  Future<void> fetchForumSections() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      print('ForumProvider: Fetching forum sections...'); // Debug log
      _forumSections = await ForumService.fetchForumSections();
      print('ForumProvider: Successfully fetched ${_forumSections.length} forum sections'); // Debug log
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      print('ForumProvider: Error fetching forum sections: $e'); // Debug log
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLatestActivity() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      _latestActivity = await ForumService.fetchLatestActivity();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMySubscriptions() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    try {
      _mySubscriptions = await ForumService.fetchMySubscriptions();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshForumSections() async {
    await CacheService.clearForumCache();
    await fetchForumSections();
  }

  Future<void> refreshLatestActivity() async {
    await CacheService.clearForumCache();
    await fetchLatestActivity();
  }

  Future<void> refreshMySubscriptions() async {
    await CacheService.clearForumCache();
    await fetchMySubscriptions();
  }
} 