import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/app_footer.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';
import '../widgets/main_article_card.dart';
import '../widgets/paginated_article.dart';
import 'package:operationsports/screens/article_detail_screen.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return MainScaffold(
      child: Stack(
        children: [
          // Main content
          Container(
            color: const Color(0xFF171717),
            child: Column(
              children: [
                
                const Header(selectedMenu: 3,),
                
                // Article List
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
                          return const Center(
                            child: Text("No articles found."),
                          );
                        }

                        return ListView(
                          children: [
                            MainArticleCard(
                              article:
                                  articles
                                      .where(
                                        (article) =>
                                            article.imageUrl.isNotEmpty,
                                      )
                                      .first,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ArticleDetailScreen(
                                          articleId:
                                              articles.first.id.toString(),
                                        ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Trending',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 230,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      articles
                                          .skip(1)
                                          .where(
                                            (article) =>
                                                article.imageUrl.isNotEmpty,
                                          )
                                          .map((article) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 12,
                                              ),
                                              child: SizedBox(
                                                width: 280,
                                                child: ArticleCard(
                                                  article: article,
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => ArticleDetailScreen(
                                                              articleId:
                                                                  article.id
                                                                      .toString(),
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          })
                                          .toList(),
                                ),
                              ),
                            ),

                            // Button Row
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Latest Posts",
                                      style: const TextStyle(
                                        color: AppColors.accentColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Most Popular",
                                    style: const TextStyle(
                                      color: Color(0xFF434343),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "All",
                                    style: const TextStyle(
                                      color: Color(0xFF434343),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            PaginatedArticleList(articles: articles),

                            const AppFooter(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BottomIconButton(),
        ],
      ),
    );
  }
}
