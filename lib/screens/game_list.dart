import 'package:flutter/material.dart';
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/providers/category_provider.dart';
import 'package:operationsports/screens/article_menu_template.dart';
import 'package:provider/provider.dart';

class GameList extends StatefulWidget {
  final int categoryId;
  const GameList({super.key, required this.categoryId});

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  @override
  void initState() {
    super.initState();
    // Fetch data after build context is available
    Future.microtask(() {
      final provider = Provider.of<CategoryProvider>(context, listen: false);
      provider.fetchCategoryPost(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.hasError) {
          return Center(child: Text('Error: ${provider.errorMessage}'));
        }

        final List<ArticleModel> articles = provider.articles;

        return ArticleMenuTemplate(
          fetchArticles: () async {
            await provider.fetchCategoryPost(widget.categoryId);
          },
          isLoading: provider.isLoading,
          hasError: provider.hasError,
          errorMessage: provider.errorMessage,
          articles: articles,
          featuredArticles: articles,
          trendArticles: articles,
          selectedMenu: 4,
        );
      },
    );
  }
}
