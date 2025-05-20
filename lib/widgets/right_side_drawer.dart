import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RightSideDrawer extends StatelessWidget {
  const RightSideDrawer({super.key});

  static const List<String> games = [
    "EA Sports College Football 25",
    "NBA 2K25",
    "Madden NFL 25",
    "EA Sports FC 25",
    "MLB The Show 24",
    "EA Sports F1 24",
    "NHL 24",
    "EA Sports PGA TOUR",
    "PGA Tour 2K23",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      color: const Color(0xFF1F1F1F),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.go('/profile');
            },
            child: const Row(
              children: [
                CircleAvatar(radius: 24, backgroundColor: Colors.white),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sports games",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Profile", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Games",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),

          // List of games
          ...games.map(
            (title) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(title, style: const TextStyle(color: Colors.grey)),
            ),
          ),

          const Spacer(),
          const Text("ABOUT US", style: TextStyle(color: Colors.grey)),
          const Text("TERMS", style: TextStyle(color: Colors.grey)),
          const Text("PRIVACY", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(Icons.facebook, color: Colors.white),
              SizedBox(width: 20),
              Icon(Icons.ondemand_video, color: Colors.white),
              SizedBox(width: 20),
              Icon(Icons.travel_explore, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
