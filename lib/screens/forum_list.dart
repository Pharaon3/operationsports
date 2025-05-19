import 'package:flutter/material.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/topic_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/forum_submenu.dart';
import 'package:operationsports/widgets/menu_button.dart';

class ForumList extends StatelessWidget {
  const ForumList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset('assets/logo.png', height: 26),
                  ),
                  const SizedBox(width: 4.0),
                  const Text(
                    'OPERATION SPORTS',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
              IconButton(
                icon: Image.asset('assets/menu.png', height: 40),
                onPressed: () {
                  // Menu action
                },
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => {},
        child: Builder(
          builder: (context) {
            return ListView(
              padding: const EdgeInsets.only(bottom: 20.0),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search forums...',
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

                const MenuButton(selectedMenu: 2),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: MenuGrid(),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ForumSubMenu(
                        title: 'All Pro Football 2K',
                        subItems: ['APF 2K Rosters'],
                      ),
                      ForumSubMenu(
                        title: 'ESPN NFL 2K5 Football',
                        subItems: [
                          'ESPN NFL 2K5 Rosters',
                          'ESPN NFL 2K5 Sliders',
                          'ESPN NFL 2K5 Online',
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: TopicGrid(),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    onTap: () => {},
                    buttonLabel: "New Topic    +",
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ForumSubMenu(
                        title: '',
                        subItems: [
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                          '2k never getting the NFL sim license!!',
                          'Operation Sports Content and Other News',
                        ],
                      ),
                    ],
                  ),
                ),

                const AppFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
