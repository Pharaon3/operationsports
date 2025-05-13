import 'package:flutter/material.dart';
import '../models/article_model.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onTap;

  const ArticleCard({
    Key? key,
    required this.article,
    required this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Stack(
          children: [
            // Image widget
            Positioned.fill(
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Container for text overlay
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black54, // Dark overlay
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Title color
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Excerpt
                  Text(
                    article.excerpt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white, // Excerpt color
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
