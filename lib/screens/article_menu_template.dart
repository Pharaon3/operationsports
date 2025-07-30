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

class ArticleMenuTemplate extends StatefulWidget {
  final Function fetchArticles;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;
  final List<ArticleModel> articles;
  final List<ArticleModel> featuredArticles;
  final List<ArticleModel> trendArticles;
  final List<ArticleModel> latestArticles;
  final List<ArticleModel> popularArticles;
  final int selectedMenu;
  final void Function(String)? onSearch;
  final bool isSearchMode;

  const ArticleMenuTemplate({
    super.key,
    required this.fetchArticles,
    required this.isLoading,
    required this.hasError,
    required this.errorMessage,
    required this.articles,
    required this.selectedMenu,
    required this.featuredArticles,
    required this.trendArticles,
    required this.latestArticles,
    required this.popularArticles,
    this.onSearch,
    this.isSearchMode = false,
  });

  @override
  State<ArticleMenuTemplate> createState() => _ArticleMenuTemplateState();
}

class _ArticleMenuTemplateState extends State<ArticleMenuTemplate> {
  String selectedCategory = 'Latest Posts';

  List<ArticleModel> get selectedArticles {
    switch (selectedCategory) {
      case 'Latest Posts':
        List<ArticleModel> sortedArticles = List.from(widget.latestArticles);
        sortedArticles.sort((a, b) => b.date.compareTo(a.date));
        return sortedArticles;
      case 'Most Popular':
        // You may change this logic if you have a separate popular list.
        return widget.popularArticles;
      case 'All':
        List<ArticleModel> sortedArticles = List.from(widget.articles);
        sortedArticles.sort((a, b) => a.title.compareTo(b.title));
        return sortedArticles;
      default:
        return widget.articles;
    }
  }

  Widget _buildCategoryButton(String category) {
    final bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category,
              style: TextStyle(
                color:
                    isSelected
                        ? AppColors.accentColor
                        : AppColors.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                width: 90,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      onSearch: widget.onSearch,
      child: Stack(
        children: [
          Container(
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Header(selectedMenu: widget.selectedMenu),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => widget.fetchArticles(),
                    child: Builder(
                      builder: (context) {
                        if (widget.isLoading) {
                          return const LoadingIndicator();
                        }

                        if (widget.hasError) {
                          return AppErrorWidget(message: widget.errorMessage);
                        }

                        if (widget.articles.isEmpty) {
                          return const Center(
                            child: Text("No articles found."),
                          );
                        }

                        return ListView(
                          children: [
                            // Featured - only show if not in search mode or if we have filtered featured articles
                            if (!widget.isSearchMode || widget.featuredArticles.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 34,
                                  right: 34,
                                  top: 20,
                                ),
                                child: Text(
                                  widget.isSearchMode ? 'Search Results' : 'Featured Story',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            if (!widget.isSearchMode || widget.featuredArticles.isNotEmpty)
                              MainArticleCard(
                                article: widget.featuredArticles.firstWhere(
                                  (article) => article.imageUrl.isNotEmpty,
                                  orElse: () => widget.articles.first,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ArticleDetailScreen(
                                            articleId:
                                                widget.featuredArticles.first.id
                                                    .toString(),
                                            articles:widget.articles,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            if (!widget.isSearchMode || widget.featuredArticles.isNotEmpty)
                              const SizedBox(height: 18),

                            // Trending - only show if not in search mode
                            if (!widget.isSearchMode) ...[
                              Padding(
                                padding: const EdgeInsets.only(left: 34),
                                child: Text(
                                  'Trending',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),

                              Container(
                                color: const Color(0xFF232323),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children:
                                        widget.trendArticles
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
                                                                _,
                                                              ) => ArticleDetailScreen(
                                                                articleId:
                                                                    article.id
                                                                        .toString(),
                                                                articles: widget.articles,
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
                            ],

                            // Category Buttons - only show if not in search mode
                            if (!widget.isSearchMode)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 28.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildCategoryButton('Latest Posts'),
                                    const SizedBox(width: 24),
                                    _buildCategoryButton('Most Popular'),
                                    const SizedBox(width: 24),
                                    _buildCategoryButton('All'),
                                  ],
                                ),
                              ),

                            // Paginated List
                            PaginatedArticleList(
                                articles: selectedArticles,
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
