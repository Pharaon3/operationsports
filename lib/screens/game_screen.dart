import 'package:flutter/material.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_appbar.dart';
import 'package:operationsports/widgets/game_list.dart';
import 'package:operationsports/widgets/topic_grid.dart';
import '../widgets/menu_button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        title: DefaultAppbar(),
      ),
      body: Stack(
        children: [
          // Main content
          Container(
            color: const Color(0xFF171717),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search articles...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (value) {
                      // Optional search logic
                    },
                  ),
                ),
                // Button Row
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: MenuButton(selectedMenu: 4),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: TopicGrid(
                    menuItems: [
                      'Cars',
                      'Fight',
                      'Bike',
                      'Motorcycle',
                      'Baseball',
                      'Cricket',
                      'Rugby',
                      'Tennis',
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GameListWidget(
                    gameTitles: const [
                      "Horizon Chase 2",
                      "Horizon Chase Turbo Senna Forever",
                      "Mario Kart 8",
                      "Mario Kart Tour",
                      "Mario Kart World",
                      "Need For Speed",
                      "Need For Speed 2017",
                      "Need For Speed Heat",
                      "Need For Speed Hot Pursuit Remastered",
                      "Need For Speed No Limits",
                      "Need for Speed Payback",
                      "Need For Speed Unbound",
                    ],
                  ),
                ),

                AppFooter(),
              ],
            ),
          ),

          // BottomIconButton(),
        ],
      ),
    );
  }
}
