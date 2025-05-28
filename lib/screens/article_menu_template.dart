import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import '../widgets/app_footer.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';
import '../widgets/main_article_card.dart';
import '../widgets/paginated_article.dart';
import './article_detail_screen.dart';

class ArticleMenuTemplate extends StatelessWidget {
  final Function fetchArticles;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final List<ArticleModel> articles;
  final int selectedMenu;

  const ArticleMenuTemplate({
    super.key,
    required this.fetchArticles,
    required this.isLoading,
    required this.hasError,
    required this.errorMessage,
    required this.articles,
    required this.selectedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Stack(
        children: [
          // Main content
          Container(
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Header(selectedMenu: selectedMenu),
                // Article List
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => fetchArticles,
                    child: Builder(
                      builder: (context) {
                        if (isLoading) {
                          return const LoadingIndicator();
                        }

                        if (hasError) {
                          return AppErrorWidget(
                            message: errorMessage,
                          );
                        }

                        if (articles.isEmpty) {
                          return const Center(
                            child: Text("No articles found."),
                          );
                        }

                        return ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 34,
                                right: 34,
                                top: 20,
                              ),
                              child: Text(
                                'Featured Story',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

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
                            const SizedBox(height: 18),

                            Container(
                              padding: EdgeInsets.only(left: 34),
                              child: Text(
                                'Trending',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            Container(
                              // height: 230,
                              color: const Color(0xFF232323),
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
                                              padding: const EdgeInsets.all(0),
                                              child: SizedBox(
                                                width: 298,
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
                                vertical: 28.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Latest Posts",
                                          style: TextStyle(
                                            color: AppColors.accentColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 90,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: AppColors.accentColor,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 24),
                                  Text(
                                    "Most Popular",
                                    style: const TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 24),
                                  Text(
                                    "All",
                                    style: const TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: PaginatedArticleList(articles: articles),
                            ),

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
