import 'package:flutter/material.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import '../widgets/app_footer.dart';
import '../widgets/forum_menu.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: () async => {},
        child: Builder(
          builder: (context) {
            return ListView(
              children: [
                
                const Header(selectedMenu: 2,),
                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: MenuGrid(),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ForumMenu(
                        title: 'The News Desk',
                        subItems: ['Operation Sports Content and Other News'],
                      ),
                      ForumMenu(
                        title: 'Football',
                        subItems: [
                          'Operation Sports Content and Other News',
                          'Operation Sports Content and Other News',
                        ],
                      ),
                      ForumMenu(
                        title: 'Basketball',
                        subItems: [
                          'Operation Sports Content and Other News',
                          'Operation Sports Content and Other News',
                        ],
                      ),
                      ForumMenu(
                        title: 'Baseball',
                        subItems: [
                          'Operation Sports Content and Other News',
                          'Operation Sports Content and Other News',
                        ],
                      ),
                      ForumMenu(
                        title: 'Hockey',
                        subItems: [
                          'Operation Sports Content and Other News',
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
