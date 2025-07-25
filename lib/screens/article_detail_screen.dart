import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/providers/article_provider.dart';
// import 'package:operationsports/widgets/video_player.dart';
import 'package:provider/provider.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';
import '../widgets/app_footer.dart';
import '../widgets/article_card.dart';
// import '../widgets/comment.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String articleId;
  final List<ArticleModel> articles;

  const ArticleDetailScreen({
    super.key,
    required this.articleId,
    required this.articles,
  });

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late Future<ArticleModel> _articleFuture;
  final ScrollController _scrollController = ScrollController();
  // final GlobalKey _commentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _articleFuture = ArticleService.fetchArticleById(widget.articleId);

    Future.microtask(() {
      Provider.of<ArticleProvider>(context, listen: false).fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      height: 344,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      errorWidget:
                          (context, url, error) =>
                              const Icon(Icons.broken_image),
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
                    // Positioned(
                    //   top: 268,
                    //   left: 24,
                    //   child: IconButton(
                    //     icon: Image.asset('assets/comment.png', height: 57),
                    //     onPressed: () {
                    //       Scrollable.ensureVisible(
                    //         _commentKey.currentContext!,
                    //         duration: const Duration(milliseconds: 500),
                    //         curve: Curves.easeInOut,
                    //       );
                    //     },

                    //     tooltip: 'Leave a comment',
                    //   ),
                    // ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 34, right: 34),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          article.articleSection,
                          style: const TextStyle(
                            color: AppColors.accentColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Title
                      Text(
                        article.title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Author
                          Text(
                            article.author,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white, fontSize: 12),
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
                      // const SizedBox(height: 16),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 25,
                  ),
                  child: Html(
                    data: article.content,
                    style: {
                      "*": Style(color: Colors.white),
                      "img": Style(
                        width: Width(MediaQuery.of(context).size.width),
                      ),
                    },
                    extensions: [
                      TagExtension(
                        tagsToExtend: {"img"},
                        builder: (context) {
                          final src = context.attributes['src'] ?? '';
                          final buildContext = context.buildContext;

                          final screenWidth =
                              buildContext != null
                                  ? MediaQuery.of(buildContext).size.width
                                  : 300.0;

                          return Image.network(
                            src,
                            width: screenWidth,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                      TagExtension(
                        tagsToExtend: {"iframe"},
                        builder: (context) {
                          // final attrs = context.attributes;
                          // if (attrs["data-test-id"] == "beehiiv-embed") {
                          //   final src =
                          //       'https://media.istockphoto.com/id/1224313496/video/a-bus-enters-a-tunnel.mp4?s=mp4-640x640-is&k=20&c=mZiCyVFmRP1hM0XNrR13gCMrMWnGrqqLDdNzNb7e0EE=';
                          //   return Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //       vertical: 12.0,
                          //     ),
                          //     child: VideoWidget(url: src),
                          //   );
                          // }

                          // If not the specific iframe, fallback to default or ignore
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),

                // CommentsPage(key: _commentKey),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 48.0,
                    top: 65.0,
                    bottom: 17.0,
                  ),
                  child: const Text(
                    'Related',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                ),

                SizedBox(
                  height: 230,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          widget.articles
                              .where((article) => article.imageUrl.isNotEmpty)
                              .map((article) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    width: 280,
                                    child: ArticleCard(
                                      article: article,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    ArticleDetailScreen(
                                                      articleId:
                                                          article.id.toString(),
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

                const SizedBox(height: 100),

                const AppFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
