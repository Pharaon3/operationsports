import 'package:flutter/material.dart';
import 'package:operationsports/widgets/round_button.dart';

class PostInputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onLinkPressed;
  final VoidCallback? onImagePressed;
  final VoidCallback? onPostPressed;

  const PostInputBox({
    super.key,
    required this.controller,
    this.onLinkPressed,
    this.onImagePressed,
    this.onPostPressed,
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
              maxLines: 4,
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
                // RoundButton(icon: Icons.link, onPressed: onLinkPressed),
                // const SizedBox(width: 8),
                // RoundButton(icon: Icons.camera_alt, onPressed: onImagePressed),
                // const SizedBox(width: 8),
                RoundButton(icon: Icons.edit_document, onPressed: onPostPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
