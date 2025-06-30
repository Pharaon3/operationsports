import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/widgets/forum_card.dart';

class PaginatedForumList extends StatefulWidget {
  final List<ForumSectionMenu> forums;
  final String cardTitle;
  final Future<void> Function() loadMore;
  final bool hasMore;
  final Future<void> Function(String) quoteReply;

  const PaginatedForumList({
    super.key,
    required this.forums,
    required this.cardTitle,
    required this.loadMore,
    required this.hasMore,
    required this.quoteReply,
  });

  @override
  State<PaginatedForumList> createState() => _PaginatedForumListState();
}

class _PaginatedForumListState extends State<PaginatedForumList> {
  bool isLoading = false;

  Future<void> _loadMore() async {
    setState(() => isLoading = true);
    await widget.loadMore();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.forums.map((forum) {
          return ForumCard(
            isMainForum: false,
            authorname: forum.authorname,
            forumName: widget.cardTitle,
            postText: forum.content,
            date: forum.publishdate,
            imageUrl: '',
            joinedDate: forum.joinedDate,
            postCount: forum.posts,
            useravatar: forum.useravatar,
            quoteReply: widget.quoteReply,
          );
        }),

        const SizedBox(height: 16),

        if (widget.hasMore)
          ElevatedButton(
            onPressed: isLoading ? null : _loadMore,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:
                isLoading
                    ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : const Text(
                      'Load More',
                      style: TextStyle(color: Colors.white),
                    ),
          ),

        const SizedBox(height: 20),
      ],
    );
  }
}
