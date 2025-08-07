import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/widgets/round_button.dart';
import 'package:operationsports/widgets/forum_card.dart';
import 'package:operationsports/services/forum_service.dart';
import 'package:operationsports/utils/shared_prefs.dart';

class CreateTopicPage extends StatefulWidget {
  final String forumId;
  final String forumName;
  
  const CreateTopicPage({
    super.key,
    required this.forumId,
    required this.forumName,
  });

  @override
  State<CreateTopicPage> createState() => _CreateTopicPageState();
}

class _CreateTopicPageState extends State<CreateTopicPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool _isLoading = false;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final token = await SharedPrefs.getToken();
    setState(() {
      _isAuthenticated = token != null;
    });
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
                  quoteReply: quoteReply,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _createTopic() async {
    if (!_isAuthenticated) {
      _showErrorDialog('Please login first to create a topic.');
      return;
    }

    if (_titleController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a title for your topic.');
      return;
    }

    if (_bodyController.text.trim().isEmpty) {
      _showErrorDialog('Please enter content for your topic.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ForumService.createTopic(
        forumId: widget.forumId,
        title: _titleController.text.trim(),
        content: _bodyController.text.trim(),
      );

      if (result['success'] == true) {
        _showSuccessDialog(result['message'] ?? 'Topic created successfully!');
      } else {
        _showErrorDialog(result['message'] ?? 'Failed to create topic.');
      }
    } catch (e) {
      _showErrorDialog('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
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
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Create New Topic - ${widget.forumName}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isAuthenticated)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: const Text(
                  'Please login to create a topic',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _titleController,
                    enabled: _isAuthenticated && !_isLoading,
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
                      enabled: _isAuthenticated && !_isLoading,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Write Your Post...",
                      ),
                    ),
                  ),
                  // const SizedBox(height: 12),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     RoundButton(
                  //       icon: Icons.link, 
                  //       onPressed: _isAuthenticated && !_isLoading ? () {} : null
                  //     ),
                  //     const SizedBox(width: 8),
                  //     RoundButton(
                  //       icon: Icons.camera_alt, 
                  //       onPressed: _isAuthenticated && !_isLoading ? () {} : null
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFlatButton(
                  "Cancel", 
                  onPressed: _isLoading ? null : () => Navigator.of(context).pop()
                ),
                const SizedBox(width: 8),
                _buildFlatButton(
                  "Preview", 
                  onPressed: _isLoading ? null : _showPreviewDialog
                ),
                const SizedBox(width: 8),
                _buildFilledButton(
                  _isLoading ? "Creating..." : "Post", 
                  onPressed: _isLoading || !_isAuthenticated ? null : _createTopic
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFlatButton(String label, {required VoidCallback? onPressed}) {
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
        foregroundColor: onPressed != null ? AppColors.accentColor : Colors.grey,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}

Widget _buildFilledButton(String label, {required VoidCallback? onPressed}) {
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
        backgroundColor: onPressed != null ? AppColors.accentColor : Colors.grey,
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
