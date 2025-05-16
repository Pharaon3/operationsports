import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';
import '../widgets/app_footer.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String articleId;

  const ArticleDetailScreen({Key? key, required this.articleId})
    : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late Future<ArticleModel> _articleFuture;

  @override
  void initState() {
    super.initState();
    _articleFuture = ArticleService.fetchArticleById(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF171717),
      //   title: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             const Text(
      //               'Article',
      //               style: TextStyle(color: Colors.white, fontSize: 25.0),
      //             ),
      //           ],
      //         ),
      //         IconButton(
      //           icon: Image.asset('assets/menu.png', height: 40),
      //           onPressed: () {
      //             // Menu action
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: FutureBuilder<ArticleModel>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return AppErrorWidget(message: snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Article not found."));
          }

          final article = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      article.imageUrl,
                      width: double.infinity,
                      height: 344,
                      fit: BoxFit.cover,
                    ),
                    // Back Button
                    Positioned(
                      top: 38,
                      left: 26,
                      child: IconButton(
                        icon: Image.asset('assets/red back.png', height: 38),
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: 'Back',
                      ),
                    ),
                    // Comment Button
                    Positioned(
                      top: 268,
                      left: 24,
                      child: IconButton(
                        icon: Image.asset('assets/comment.png', height: 57),
                        onPressed: () {
                          // Handle comment action here
                        },
                        tooltip: 'Leave a comment',
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          article.articleSection,
                          style: const TextStyle(
                            color: Color(0xFFFF5757),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Title
                      Text(
                        article.title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Author
                          Text(
                            article.author,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          // Date
                          Text(
                            article.formattedDate,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF707070),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Html(
                        data: article.content,
                        style: {
                          "*": Style(color: Colors.white),
                          "img": Style(
                            width: Width(
                              MediaQuery.of(context).size.width,
                            ), // Fit image to screen width
                          ),
                        },
                        extensions: [
                          TagExtension(
                            tagsToExtend: {"img"},
                            builder: (context) {
                              final src = context.attributes['src'] ?? '';
                              final buildContext = context.buildContext;

                              // Provide a fallback width if buildContext is null
                              final screenWidth =
                                  buildContext != null
                                      ? MediaQuery.of(buildContext).size.width
                                      : 300.0; // Fallback width

                              return Image.network(
                                src,
                                width: screenWidth,
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const AppFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
