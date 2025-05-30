import 'package:flutter/material.dart';
import 'package:operationsports/screens/article_menu_template.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return ArticleMenuTemplate(
      fetchArticles: articleProvider.fetchArticles,
      isLoading: articleProvider.isLoading,
      hasError: articleProvider.hasError,
      errorMessage: articleProvider.errorMessage,
      articles: articleProvider.articles,
      selectedMenu: 3,
      featuredArticles: articleProvider.articles,
    );
  }
}
