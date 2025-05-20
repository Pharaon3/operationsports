import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 36, left: 54, right: 36, bottom: 28),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9), // light gray background
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF53A2FF), width: 1.5),
      ),
      child: Column(
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
                icon: Image.asset('assets/red up.png', height: 38),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Comment 1
          commentTile(
            username: "sports games",
            date: "01-03-2025",
            comment:
                "As sports games grow and grow in size, tough decisions need to be made each year about where developers should put their time and money. Since these games are so large (for better and worse), it’s nearly impossible to give time to every mode and feature each cycle.",
          ),
          const SizedBox(height: 24),

          // Comment 2
          commentTile(
            username: "sports games",
            date: "01-03-2025",
            comment:
                "As sports games grow and grow in size, tough decisions need to be made each year about where developers should put their time and money. Since these games are so large (for better and worse), it’s nearly impossible to give time to every mode and feature each cycle.",
          ),
          const SizedBox(height: 24),

          // Comment Input
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 36,
                color: Colors.black54,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Your comment here...",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF707070),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {},
                            color: Colors.redAccent,
                            iconSize: 18,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {},
                            color: Colors.redAccent,
                            iconSize: 18,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.account_circle_outlined,
          size: 30,
          color: Colors.black54,
        ),
        const SizedBox(width: 10),
        // Wrap the column with Expanded to allow text wrapping
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF434343),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFFFF5757),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                comment,
                style: const TextStyle(
                  color: Color(0xFF434343),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'answer...',
                style: TextStyle(
                  color: Color(0xFFFF5757),
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
