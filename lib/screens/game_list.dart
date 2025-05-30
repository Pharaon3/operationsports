import 'package:flutter/material.dart';
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/providers/category_provider.dart';
import 'package:operationsports/screens/article_menu_template.dart';
import 'package:provider/provider.dart';

class GameList extends StatelessWidget {
  final int categoryId;
  const GameList({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<CategoryProvider>(
      context,
      listen: false,
    );

    return FutureBuilder<List<ArticleModel>>(
      future: articleProvider.getCategoryPost(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final articles = snapshot.data ?? [];

        return Consumer<CategoryProvider>(
          builder: (context, provider, _) {
            return ArticleMenuTemplate(
              fetchArticles: provider.fetchCategories,
              isLoading: provider.isLoading,
              hasError: provider.hasError,
              errorMessage: provider.errorMessage,
              articles: articles,
              featuredArticles: articles,
              selectedMenu: 4,
            );
          },
        );
      },
    );
  }
}
