import 'package:flutter/material.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/app_footer.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';
import '../widgets/newslettersection.dart';
import '../widgets/paginated_article.dart';

class NewsLetter extends StatelessWidget {
  const NewsLetter({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return MainScaffold(
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

            return ListView(
              children: [
                const Header(selectedMenu: 1,),

                const NewsletterSection(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: const Text(
                          'Archive',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height:
                            40, // Increased height for better text alignment
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Posts...',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black54,
                              size: 20,
                            ),
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true, // Reduces default vertical padding
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                          onChanged: (value) {
                            // Handle search
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                PaginatedArticleList(articles: articles),

                SizedBox(height: 32),

                const AppFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
