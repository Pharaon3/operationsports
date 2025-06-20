import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/widgets/round_button.dart';
import 'package:operationsports/widgets/forum_card.dart';

class CreateTopicPage extends StatefulWidget {
  const CreateTopicPage({super.key});

  @override
  State<CreateTopicPage> createState() => _CreateTopicPageState();
}

class _CreateTopicPageState extends State<CreateTopicPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final List<String> _tags = [];

  void _addTag(String tag) {
    tag = tag.trim().toLowerCase();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() => _tags.add(tag));
    }
  }

  Future<void> quoteReply(String quote) async {}

  void _showPreviewDialog() {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch ~/ 1000;
    final joinedTimestamp = DateTime(2022, 1, 1).millisecondsSinceEpoch ~/ 1000;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ForumCard(
                  isMainForum: false,
                  forumName:
                      _titleController.text.isEmpty
                          ? 'Preview Forum'
                          : _titleController.text,
                  postText: _bodyController.text,
                  imageUrl: '',
                  date: timestamp.toString(),
                  authorname: 'User Name',
                  joinedDate: joinedTimestamp.toString(),
                  postCount: '123',
                  useravatar:
                      'images/default/default_avatar_large.png', // relative to core URL
                  userrank: 2,
                  quoteReply: quoteReply,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Create New Topic'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title...',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _bodyController,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Write Your Post...",
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(icon: Icons.link, onPressed: () {}),
                      const SizedBox(width: 8),
                      RoundButton(icon: Icons.camera_alt, onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Tags',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    onSubmitted: (val) {
                      val.split(',').forEach(_addTag);
                      _tagController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Add tags (comma separated)...',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 5,
              children:
                  _tags
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          onDeleted: () => setState(() => _tags.remove(tag)),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 5,
              runSpacing: 2,
              children:
                  [
                        'nba',
                        'nba2k',
                        'basketball',
                        'draft',
                        'nfl',
                        'online',
                        'xbox360',
                        'franchise',
                        'roster',
                        'sliders',
                        'dynasty',
                      ]
                      .map(
                        (tag) => ActionChip(
                          label: Text(tag),
                          onPressed: () => _addTag(tag),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFlatButton("Cancel", onPressed: () {}),
                const SizedBox(width: 8),
                _buildFlatButton("Preview", onPressed: _showPreviewDialog),
                const SizedBox(width: 8),
                _buildFilledButton("Post", onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFlatButton(String label, {required VoidCallback onPressed}) {
  return Container(
    width: 59.26,
    height: 24.33,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.86),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(-1.25, 2.5),
          blurRadius: 2.5,
          spreadRadius: -0.62,
        ),
      ],
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentColor,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}

Widget _buildFilledButton(String label, {required VoidCallback onPressed}) {
  return Container(
    width: 59.26,
    height: 24.33,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.86),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(-1.25, 2.5),
          blurRadius: 2.5,
          spreadRadius: -0.62,
        ),
      ],
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.86),
        ),
        textStyle: const TextStyle(fontSize: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}
