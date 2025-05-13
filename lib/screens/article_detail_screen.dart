import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String articleId;

  const ArticleDetailScreen({Key? key, required this.articleId}) : super(key: key);

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
      appBar: AppBar(title: const Text('Article')),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Html(data: article.content),
              ],
            ),
          );
        },
      ),
    );
  }
}
