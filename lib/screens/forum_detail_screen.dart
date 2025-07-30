import 'package:flutter/material.dart';
import 'package:operationsports/models/forum_section.dart';
import 'package:operationsports/services/forum_service.dart';
import 'package:operationsports/widgets/camera.dart';
import 'package:operationsports/widgets/forum_card.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
// import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/post_input_box.dart';
import 'package:operationsports/widgets/paginated_forum.dart';

class ForumDetail extends StatefulWidget {
  final String parentId;
  final String content;
  final String title;
  final String authorname;
  final String publishdate;
  final String joinedDate;
  final String posts;
  final String useravatar;

  const ForumDetail({
    super.key,
    required this.parentId,
    required this.content,
    required this.title,
    required this.authorname,
    required this.publishdate,
    required this.joinedDate,
    required this.posts,
    required this.useravatar,
  });

  @override
  State<ForumDetail> createState() => _ForumDetailState();
}

class _ForumDetailState extends State<ForumDetail> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _postBoxKey = GlobalKey();
  final List<ForumSectionMenu> _forumSections = [];
  final TextEditingController _postController = TextEditingController();
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  bool _showScrollToTopButton = false;
  bool _isReplying = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 300 && !_showScrollToTopButton) {
        setState(() => _showScrollToTopButton = true);
      } else if (_scrollController.offset < 300 && _showScrollToTopButton) {
        setState(() => _showScrollToTopButton = false);
      }
    });

    _loadForumSectionMenu();
  }

  Future<void> _loadForumSectionMenu() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newSections = await ForumService.fetchForumSectionMenu(
        widget.parentId,
        _currentPage,
      );

      final existingIds = _forumSections.map((e) => e.id).toSet();
      final uniqueSections =
          newSections.where((s) => !existingIds.contains(s.id)).toList();

      setState(() {
        if (uniqueSections.isEmpty) {
          _hasMore = false;
        } else {
          _forumSections.addAll(uniqueSections);
          _currentPage++;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasMore = false;
      });
      debugPrint('Error loading forum sections: $e');
    }
  }

  String parseBBCodeToHtml(String bbcode) {
    return bbcode
        .replaceAll('[B]', '<b>')
        .replaceAll('[/B]', '</b>')
        .replaceAll('[I]', '<i>')
        .replaceAll('[/I]', '</i>')
        .replaceAll('[COLOR="Red"]', '<span style="color:red;">')
        .replaceAll('[COLOR="Blue"]', '<span style="color:blue;">')
        .replaceAll('[/COLOR]', '</span>')
        .replaceAllMapped(
          RegExp(r'\[URL="(.+?)"\](.+?)\[/URL\]', dotAll: true),
          (match) => '<a href="${match[1]}">${match[2]}</a>',
        );
  }

  void _openCamera(BuildContext context) async {
    final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraWidget()),
    );

    if (imagePath != null) {
      // Do something with the image path (e.g., display it or save it)
      print('Captured image path: $imagePath');
    }
  }

  Future<void> quoteReply(String quote) async {
    _postController.text = quote;

    final context = _postBoxKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    } else {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _handlePostReply() async {
    if (_postController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a reply.');
      return;
    }
    setState(() { _isReplying = true; });
    try {
      final result = await ForumService.createReply(
        topicId: widget.parentId,
        content: _postController.text.trim(),
      );
      if (result['success'] == true) {
        _showSuccessDialog(result['message'] ?? 'Reply posted successfully!');
        _postController.clear();
        // Optionally reload forum section menu to show new reply
        await _loadForumSectionMenu();
      } else {
        _showErrorDialog(result['message'] ?? 'Failed to post reply.');
      }
    } catch (e) {
      _showErrorDialog('Error: \\${e.toString()}');
    } finally {
      setState(() { _isReplying = false; });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _forumSections.clear();
            _currentPage = 1;
            _hasMore = true;
          });
          await _loadForumSectionMenu();
        },
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              children: [
                const Header(selectedMenu: 1),

                // Column(
                //   children: [
                //     MenuGrid(
                //       menuItems: ['FORUMS', 'BLOGS', 'ARTICLES', 'GROUPS'],
                //       highlightedItems: {'FORUMS'},
                //     ),
                //     MenuGrid(
                //       menuItems: [
                //         'Today\'s posts',
                //         'Member list',
                //         'Calendar',
                //         'News',
                //         'Reviews',
                //       ],
                //       highlightedItems: {'Today\'s posts'},
                //     ),
                //   ],
                // ),
                ForumCard(
                  isMainForum: true,
                  authorname: widget.authorname,
                  forumName: widget.title,
                  postText: parseBBCodeToHtml(widget.content),
                  date: widget.publishdate,
                  imageUrl: '',
                  joinedDate: widget.joinedDate,
                  postCount: widget.posts,
                  useravatar: widget.useravatar,
                  quoteReply: quoteReply,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    onTap: () {
                      final context = _postBoxKey.currentContext;
                      if (context != null) {
                        Scrollable.ensureVisible(
                          context,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          alignment: 0.5,
                        );
                      } else {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    buttonLabel: "Post Reply    +",
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      _isLoading && _forumSections.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : _forumSections.isEmpty
                          ? const Center(
                            child: Text(
                              "No forum posts found.",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                          : PaginatedForumList(
                            forums: _forumSections,
                            cardTitle: widget.title,
                            loadMore: _loadForumSectionMenu,
                            hasMore: _hasMore,
                            quoteReply: quoteReply,
                          ),
                ),
                Padding(
                  key: _postBoxKey,
                  padding: const EdgeInsets.all(16),
                  child: PostInputBox(
                    controller: _postController,
                    onLinkPressed: () => print("Link tapped"),
                    onImagePressed: () => _openCamera(context),
                    onPostPressed: _isReplying ? null : _handlePostReply,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: DefaultButton(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const CreateTopicPage(),
                //         ),
                //       );
                //     },
                //     buttonLabel: "Advanced Options    +",
                //   ),
                // ),
                const AppFooter(),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 20,
              width: 50,
              height: 50,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showScrollToTopButton ? 1.0 : 0.0,
                child:
                    _showScrollToTopButton
                        ? FloatingActionButton(
                          onPressed: () {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                          },
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.keyboard_arrow_up, size: 40),
                        )
                        : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
