import 'package:flutter/material.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/app_footer.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';
import '../widgets/main_article_card.dart';
import '../widgets/menu_button.dart';
import '../widgets/paginated_article.dart';
import './article_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34,
                    vertical: 20,
                  ),
                  child: SizedBox(
                    height: 36,
                    child: TextField(
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search articles...',
                        hintStyle: const TextStyle(fontSize: 14),
                        prefixIcon: const Icon(Icons.search, size: 18),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
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
                ),

                // Button Row
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34, vertical: 12),
                  child: MenuButton(),
                ),

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
                              height: 230,
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
                                vertical: 24.0,
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
                                            color: Color(0xFFFF5757),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 90,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFF5757),
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
                                      color: Color(0xFF434343),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 24),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: PaginatedArticleList(
                                articles: [
                                  ...articles,
                                  ...articles,
                                  ...articles,
                                ],
                              ),
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
