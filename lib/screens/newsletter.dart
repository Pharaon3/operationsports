import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';
import './article_detail_screen.dart';

class NewsLetter extends StatelessWidget {
  const NewsLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Letter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Newsletter button
                  },
                  child: const Text("Newsletter"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Forums button
                  },
                  child: const Text("Forums"), 
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Review button
                  },
                  child: const Text("Review"),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () => articleProvider.fetchArticles(),
              child: Builder(
                builder: (context) {
                  if (articleProvider.isLoading) {
                    return const LoadingIndicator();
                  }

                  if (articleProvider.hasError) {
                    return AppErrorWidget(message: articleProvider.errorMessage);
                  }

                  final articles = articleProvider.articles;

                  if (articles.isEmpty) {
                    return const Center(child: Text("No articles found."));
                  }

                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(
                        article: articles[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailScreen(
                                articleId: articles[index].id.toString(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
