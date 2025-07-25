import 'package:flutter/material.dart';
import 'package:operationsports/screens/article_menu_template.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return ArticleMenuTemplate(
      fetchArticles: articleProvider.refreshArticles, // Use refresh to clear cache
      isLoading: articleProvider.isLoading,
      hasError: articleProvider.hasError,
      errorMessage: articleProvider.errorMessage,
      articles: articleProvider.articles,
      featuredArticles: articleProvider.featuredArticles,
      trendArticles: articleProvider.articles,
      selectedMenu: 0,
      latestArticles: articleProvider.articles,
      popularArticles: articleProvider.articles,
      onSearch: articleProvider.searchArticles,
      isSearchMode: articleProvider.isSearchMode,
    );
  }
}
