import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';
import '../widgets/menu_button.dart';
import './article_detail_screen.dart';

class NewsLetter extends StatelessWidget {
  const NewsLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset('assets/logo.png', height: 26),
                  ),
                  const SizedBox(width: 4.0),
                  const Text(
                    'OPERATION SPORTS',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
              IconButton(
                icon: Image.asset('assets/menu.png', height: 40),
                onPressed: () {
                  // Menu action
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                // Optional search logic
              },
            ),
          ),

          // Button Row
          const MenuButton(),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () => articleProvider.fetchArticles(),
              child: Builder(
                builder: (context) {
                  if (articleProvider.isLoading) {
                    return const LoadingIndicator();
                  }

                  if (articleProvider.hasError) {
                    return AppErrorWidget(
                      message: articleProvider.errorMessage,
                    );
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
                              builder:
                                  (context) => ArticleDetailScreen(
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
