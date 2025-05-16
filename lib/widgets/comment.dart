import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9), // light gray background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF53A2FF), width: 1.5),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434343),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/red up.png',
                      height: 40,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Comment 1
              commentTile(
                username: "sports games",
                date: "01-03-2025",
                comment:
                    "As sports games grow and grow in size, tough decisions need to be made each year about where developers should put their time and money. Since these games are so large (for better and worse), it’s nearly impossible to give time to every mode and feature each cycle.",
              ),
              const SizedBox(height: 24),
              // Comment 2 (Example repeated)
              commentTile(
                username: "sports games",
                date: "01-03-2025",
                comment: "",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget commentTile({
    required String username,
    required String date,
    required String comment,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_circle_outlined,
              size: 36,
              color: Colors.black54,
            ),
            const SizedBox(width: 10),
            Text(
              username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF434343),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFFF5757),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (comment.isNotEmpty)
          Text(
            comment,
            style: const TextStyle(
              color: Color(0xFF434343),
              fontSize: 16,
              height: 1.5,
            ),
          ),
        const SizedBox(height: 6),
        const Text(
          'answer...',
          style: TextStyle(
            color: Color(0xFFFF5757),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
