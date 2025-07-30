import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/screens/game_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:operationsports/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class RightSideDrawer extends StatefulWidget {
  const RightSideDrawer({super.key});

  @override
  State<RightSideDrawer> createState() => _RightSideDrawerState();
}

class _RightSideDrawerState extends State<RightSideDrawer> {
  String userName = '';
  String userEmail = '';
  String userAvatar = '/images/default/default_avatar_large.png';
  String userPosts = '';
  String userJoindate = '';

  Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? '';
      userEmail = prefs.getString('email') ?? '';
      userAvatar =
          (prefs.getString('avatarid') == '0' 
          || prefs.getString('avatarid') == ''
              ? '/images/default/default_avatar_large.png'
              : prefs.getString('avatarid'))!;
      userPosts = prefs.getString('posts') ?? '';
      userJoindate = prefs.getString('joindate') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  static const List<Map<String, dynamic>> games = [
    {"title": "EA Sports College Football 26", "id": 53577},
    {"title": "NBA 2K25", "id": 53804},
    {"title": "Madden NFL 26", "id": 4875},
    {"title": "EA Sports FC 25", "id": 53807},
    {"title": "MLB The Show 25", "id": 53915},
    {"title": "EA Sports F1 24", "id": 53584},
    {"title": "NHL 25", "id": 53841},
    {"title": "EA Sports PGA Tour", "id": 50709},
    {"title": "PGA Tour 2K25", "id": 53964},
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = authProvider.isAuthenticated;
    return Container(
      width: 320,
      color: const Color(0xFF1F1F1F),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // context.go('/profile');
              print("userAvatar: $userAvatar");
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Image.network(
                    'https://forums.operationsports.com/forums/core/$userAvatar',
                    height: 70,
                    width: 70,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 13,
                      ),
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
            (game) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameList(categoryId: game["id"]),
                    ),
                  );
                },
                child: Text(
                  game["title"],
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
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
          if (isLoggedIn)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  onPressed: () async {
                    await authProvider.logout();
                    if (context.mounted) context.go('/login');
                  },
                ),
              ),
            ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
