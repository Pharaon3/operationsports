import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/widgets/forum_card.dart';

class PaginatedForumList extends StatefulWidget {
  final List<ForumSectionMenu> forums;

  const PaginatedForumList({super.key, required this.forums});

  @override
  State<PaginatedForumList> createState() => _PaginatedForumListState();
}

class _PaginatedForumListState extends State<PaginatedForumList> {
  int currentPage = 1;
  final int itemsPerPage = 15;

  int get totalPages => (widget.forums.length / itemsPerPage).ceil();

  List<ForumSectionMenu> get currentForums {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, widget.forums.length);
    return widget.forums.sublist(startIndex, endIndex);
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
        // Forum List
        ...currentForums.map((forum) {
          return ForumCard(
            isMainForum: false,
            authorname: forum.authorname,
            forumName: forum.title,
            postText: forum.content,
            date: forum.publishdate,
            imageUrl: '',
            joinedDate: forum.joinedDate,
            postCount: forum.posts,
            useravatar: forum.useravatar,
          );
        }),

        const SizedBox(height: 16),

        // Pagination Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _paginationButton(
              icon: Icons.chevron_left,
              onTap: () => changePage(currentPage - 1),
              isEnabled: currentPage > 1,
            ),
            ...List.generate(totalPages, (index) {
              int page = index + 1;
              if (page > 4 && page != totalPages) {
                if (page == 5) {
                  return _paginationText('...');
                }
                return const SizedBox.shrink();
              }
              return _paginationNumber(
                number: page,
                isActive: page == currentPage,
                onTap: () => changePage(page),
              );
            }),
            _paginationButton(
              icon: Icons.chevron_right,
              onTap: () => changePage(currentPage + 1),
              isEnabled: currentPage < totalPages,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
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
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Text(
          '$number',
          style: TextStyle(
            color: Colors.white,
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
