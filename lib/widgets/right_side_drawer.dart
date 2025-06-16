import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:operationsports/core/constants.dart';

class RightSideDrawer extends StatelessWidget {
  const RightSideDrawer({super.key});

  static const List<String> games = [
    "EA Sports College Football 26",
    "NBA 2K25",
    "Madden NFL 26",
    "EA Sports FC 25",
    "MLB The Show 25",
    "EA Sports F1 25",
    "NHL 25",
    "EA Sports PGA Tour",
    "PGA Tour 2K25",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: const Color(0xFF1F1F1F),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.go('/profile');
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.account_circle_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sports games",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 43),
          Container(
            padding: EdgeInsets.only(left: 7),
            child: Text(
              "Games",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 17),

          // List of games
          ...games.map(
            (title) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 57),
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "ABOUT US",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "TERMS",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  "PRIVACY",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          const Spacer(),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                FontAwesomeIcons.facebook,
                color: AppColors.secondaryColor,
                size: 20,
              ),
              SizedBox(width: 24),
              Icon(
                FontAwesomeIcons.youtube,
                color: AppColors.secondaryColor,
                size: 20,
              ),
              SizedBox(width: 24),
              Icon(
                FontAwesomeIcons.twitter,
                color: AppColors.secondaryColor,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
