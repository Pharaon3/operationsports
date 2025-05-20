import 'package:flutter/material.dart';
import 'package:operationsports/screens/new_topic.dart';
import 'package:operationsports/widgets/forum_card.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/menu_grid.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/default_button.dart';
import 'package:operationsports/widgets/post_input_box.dart';

class ForumDetail extends StatelessWidget {
  const ForumDetail({super.key});

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

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '2k never getting the NFL sim license!!',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
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

                ForumCard(
                  forumName: 'All Pro Football 2K',
                  postText:
                      'The NFL makes me sick and 2k is delusional like a guy that thinks he can win the girl (NFL) heart every five years\n\nAt this point I made up my mind to stop my hope alive',
                  imageUrl:
                      'https://images.unsplash.com/photo-1566577739112-5180d4bf9390',
                  date: '12-03-2024, 01:46 AM',
                ),

                ForumCard(
                  forumName: 'All Pro Football 2K',
                  postText:
                      'The NFL makes me sick and 2k is delusional like a guy that thinks he can win the girl (NFL) heart every five years\n\nAt this point I made up my mind to stop my hope alive',
                  date: '12-03-2024, 01:46 AM',
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: PostInputBox(
                    controller: TextEditingController(),
                    onLinkPressed: () => print("Link tapped"),
                    onImagePressed: () => print("Image tapped"),
                  ),
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
                    buttonLabel: "Advanced Options    +",
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
