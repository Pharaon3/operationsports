import 'package:flutter/material.dart';
import 'package:operationsports/screens/new_topic.dart';
import 'package:operationsports/widgets/default_appbar.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/menu_button.dart';

class ForumDetail extends StatelessWidget {
  const ForumDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        title: DefaultAppbar(),
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateTopicPage(),
                        ),
                      );
                    },
                    buttonLabel: "Post Reply    +",
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
