import 'package:flutter/material.dart';
import 'package:operationsports/models/displayable_content.dart';
import '../screens/article_detail_screen.dart';
import 'article_list.dart';
import '../core/constants.dart';

class PaginatedArticleList extends StatefulWidget {
  final List<DisplayableContent> articles;

  const PaginatedArticleList({super.key, required this.articles});

  @override
  State<PaginatedArticleList> createState() => _PaginatedArticleListState();
}

class _PaginatedArticleListState extends State<PaginatedArticleList> {
  int currentPage = 1;
  final int itemsPerPage = 15;

  int get totalPages => (widget.articles.length / itemsPerPage).ceil();

  List<DisplayableContent> get currentArticles {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(
      0,
      widget.articles.length,
    );
    return widget.articles.sublist(startIndex, endIndex);
  }

  void changePage(int page) {
    setState(() {
      currentPage = page.clamp(1, totalPages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Article List
        ...currentArticles.where((article) => article.imageUrl.isNotEmpty).map((
          article,
        ) {
          return ArticleList(
            article: article,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ArticleDetailScreen(
                        articleId: article.id.toString(),
                        articles: [],
                      ),
                ),
              );
            },
          );
        }),

        const SizedBox(height: 16),

        // Pagination Controls
        totalPages > 1
            ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _paginationButton(
                  icon: Icons.chevron_left,
                  onTap: () => changePage(currentPage - 1),
                  isEnabled: currentPage > 1,
                ),
                ..._buildPageNumbers(),
                _paginationButton(
                  icon: Icons.chevron_right,
                  onTap: () => changePage(currentPage + 1),
                  isEnabled: currentPage < totalPages,
                ),
              ],
            )
            : Container(),
        const SizedBox(height: 20),
      ],
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];

    void addPage(int page) {
      pages.add(
        _paginationNumber(
          number: page,
          isActive: page == currentPage,
          onTap: () => changePage(page),
        ),
      );
    }

    if (totalPages <= 7) {
      for (int i = 1; i <= totalPages; i++) {
        addPage(i);
      }
    } else {
      addPage(1);

      if (currentPage > 4) {
        pages.add(_paginationText('...'));
      }

      int start = (currentPage - 1).clamp(2, totalPages - 3);
      int end = (currentPage + 1).clamp(2, totalPages - 1);
      for (int i = start; i <= end; i++) {
        addPage(i);
      }

      if (currentPage < totalPages - 3) {
        pages.add(_paginationText('...'));
      }

      addPage(totalPages);
    }

    return pages;
  }

  Widget _paginationButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _paginationNumber({
    required int number,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? AppColors.accentColor : Colors.white,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Text(
          '$number',
          style: TextStyle(
            color: isActive ? AppColors.accentColor : Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            decoration: isActive ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }

  Widget _paginationText(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
