import 'package:flutter/material.dart';
import 'package:operationsports/providers/newsletter_provider.dart';
import 'package:operationsports/screens/article_menu_template.dart';
import 'package:provider/provider.dart';

class NewsLetter_ extends StatelessWidget {
  const NewsLetter_({super.key});

  @override
  Widget build(BuildContext context) {
    final newsletterProvider = Provider.of<NewsletterProvider>(context);

    return ArticleMenuTemplate(
      fetchArticles: newsletterProvider.refreshNewsletters,
      isLoading: newsletterProvider.isLoading,
      hasError: newsletterProvider.hasError,
      errorMessage: newsletterProvider.errorMessage,
      articles: newsletterProvider.newsletters,
      featuredArticles: newsletterProvider.newsletters,
      trendArticles: newsletterProvider.newsletters,
      selectedMenu: 1,
      latestArticles: newsletterProvider.newsletters,
      popularArticles: newsletterProvider.newsletters,
    );
  }
}
