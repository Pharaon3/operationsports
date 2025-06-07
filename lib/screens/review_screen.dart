import 'package:flutter/material.dart';
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/providers/category_provider.dart';
import 'package:operationsports/screens/article_menu_template.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final articleProvider = Provider.of<CategoryProvider>(context, listen: false);
      articleProvider.fetchCategoryPost(4849);
    });
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<CategoryProvider>(context);
    List<ArticleModel> trendArticles =
        articleProvider.articles.length >= 4
            ? articleProvider.articles.sublist(1, 4)
            : [];
    List<ArticleModel> articles =
        articleProvider.articles.length >= 5
            ? articleProvider.articles.sublist(4)
            : [];
    return ArticleMenuTemplate(
      fetchArticles: () async {
        await articleProvider.fetchCategoryPost(4849);
      },
      isLoading: articleProvider.isLoading,
      hasError: articleProvider.hasError,
      errorMessage: articleProvider.errorMessage,
      articles: articles,
      featuredArticles: articleProvider.articles,
      trendArticles: trendArticles,
      selectedMenu: 3,
    );
  }
}
