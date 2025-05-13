import 'package:flutter/material.dart';
import 'package:operationsports/screens/newsletter.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_widget.dart';
import './article_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xFF171717),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding for the title
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0), // Padding for logo
                  child: Image.asset('assets/logo.png', height: 26), // Adjust height as needed
                ),
                const SizedBox(width: 4.0), // Space between logo and title
                const Text(
                  'OPERATION SPORTS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Image.asset('assets/menu.png', height: 40),
              onPressed: () {
                // Define what happens when the menu button is pressed
              },
            ),
          ],
        ),
      ),
    ),
      body: Container(
        color: Color(0xFF171717), // Background color
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (value) {
                  // Optionally: add search logic here
                  // articleProvider.searchArticles(value);
                },
              ),
            ),

            // Button Row
            Container(
              // color: const Color(0xFF2C2C2C), // Dark grey background
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey[300], // Light grey text
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsLetter()),
                      );
                    },
                    child: const Text("Newsletter"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey[300],
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      // Handle Forums button
                    },
                    child: const Text("Forums"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey[300],
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      // Handle Review button
                    },
                    child: const Text("Review"),
                  ),
                ],
              ),
            ),


            Expanded(
              child: RefreshIndicator(
                onRefresh: () => articleProvider.fetchArticles(),
                child: Builder(
                  builder: (context) {
                    if (articleProvider.isLoading) {
                      return const LoadingIndicator();
                    }

                    if (articleProvider.hasError) {
                      return AppErrorWidget(message: articleProvider.errorMessage);
                    }

                    final articles = articleProvider.articles;

                    if (articles.isEmpty) {
                      return const Center(child: Text("No articles found."));
                    }

                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(
                          article: articles[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetailScreen(
                                  articleId: articles[index].id.toString(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
