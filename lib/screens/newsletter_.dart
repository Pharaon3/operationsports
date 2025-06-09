import 'package:flutter/material.dart';
import 'package:operationsports/providers/news_provider.dart';
import 'package:operationsports/screens/article_menu_template.dart';
import 'package:provider/provider.dart';

class NewsLetter_ extends StatelessWidget {
  const NewsLetter_({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return ArticleMenuTemplate(
      fetchArticles: newsProvider.fetchNewsLetter,
      isLoading: newsProvider.isLoading,
      hasError: newsProvider.hasError,
      errorMessage: newsProvider.errorMessage,
      articles: newsProvider.newsletters,
      featuredArticles: newsProvider.newsletters,
      trendArticles: newsProvider.newsletters,
      selectedMenu: 1,
      latestArticles: newsProvider.newsletters,
      popularArticles: newsProvider.newsletters,
    );
  }
}
