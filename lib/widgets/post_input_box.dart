import 'package:flutter/material.dart';

class PostInputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onLinkPressed;
  final VoidCallback onImagePressed;

  const PostInputBox({
    super.key,
    required this.controller,
    required this.onLinkPressed,
    required this.onImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: TextField(
              controller: controller,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Write...",
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.black87),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                _roundButton(Icons.link, onLinkPressed),
                const SizedBox(width: 8),
                _roundButton(Icons.camera_alt, onImagePressed),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
