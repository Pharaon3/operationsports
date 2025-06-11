import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/models/displayable_content.dart';

class ArticleList extends StatelessWidget {
  final DisplayableContent article;
  final VoidCallback onTap;

  const ArticleList({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // color: AppColors.primaryColor,
        // elevation: 0,
        color: const Color(0xFF1B1B1B),
        elevation: 2,
        // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Image with border radius
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      height: 92,
                      width: 147,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      errorWidget:
                          (context, url, error) =>
                              const Icon(Icons.broken_image),
                    )
              ),
              const SizedBox(width: 11),
              // Textual content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article Section
                    Text(
                      article.articleSection,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Title
                    Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Author and Date
                    Row(
                      children: [
                        Text(
                          article.author,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70, fontSize: 8),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          article.formattedDate,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFBBBBBB),
                            fontWeight: FontWeight.bold,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
