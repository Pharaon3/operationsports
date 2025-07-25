import 'package:flutter/material.dart';
import 'package:operationsports/models/article_model.dart';
import 'package:operationsports/models/displayable_content.dart';
import 'package:operationsports/screens/newsletter_detail_screen.dart';
import 'package:operationsports/services/newsletter_service.dart';
import 'package:operationsports/providers/newsletter_provider.dart';
// import 'package:operationsports/widgets/newslettersection.dart';
import 'article_list.dart';
import '../core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<String?> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name');
}

class PaginatedNewsletterList extends StatefulWidget {
  final VoidCallback? onRefresh;
  
  const PaginatedNewsletterList({super.key, this.onRefresh});

  @override
  State<PaginatedNewsletterList> createState() =>
      PaginatedNewsletterListState();
}

class PaginatedNewsletterListState extends State<PaginatedNewsletterList> {
  int currentPage = 1;
  List<DisplayableContent> currentArticles = [];
  int totalPages = 1;

  bool isSubscribed = false;
  final NewsletterService newsletterService = NewsletterService();

  @override
  void initState() {
    super.initState();
    // Initialize the newsletter provider and fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsletterProvider = Provider.of<NewsletterProvider>(context, listen: false);
      print('PaginatedNewsletterList: Initializing, provider has ${newsletterProvider.newsletters.length} newsletters'); // Debug log
      
      // Always fetch newsletter data to ensure it's available
      if (newsletterProvider.newsletters.isEmpty) {
        print('PaginatedNewsletterList: Provider is empty, fetching newsletters...'); // Debug log
        newsletterProvider.fetchNewsletters();
      }
      
      // Always fetch the current page data
      fetchNewsLetter(currentPage);
      checkSubscribe();
    });
  }

  // Public method to refresh the newsletter list
  void refreshNewsletterList() {
    print('PaginatedNewsletterList: Refreshing newsletter list...'); // Debug log
    setState(() {
      currentPage = 1;
    });
    // Clear cache and fetch fresh data
    final newsletterProvider = Provider.of<NewsletterProvider>(context, listen: false);
    newsletterProvider.refreshNewsletters();
    fetchNewsLetter(1);
    checkSubscribe();
  }

  Future<void> checkSubscribe() async {
    try {
      final userName = await getUserName();
      if (userName != null) {
        final testSub = await newsletterService.checkSubscribe(userName);
        setState(() {
          isSubscribed = testSub;
        });
      }
    } catch (e) {
      print('Error checking subscription: $e');
      setState(() {
        isSubscribed = false;
      });
    }
  }

  Future<void> fetchNewsLetter(int page) async {
    try {
      final newsletterProvider = Provider.of<NewsletterProvider>(context, listen: false);
      final result = await newsletterProvider.fetchNewsletterByPage(page.toString());
      setState(() {
        // Properly cast the posts to the correct type
        final posts = result['posts'] as List<dynamic>;
        // Convert each item to DisplayableContent
        currentArticles = posts.map((post) => post as DisplayableContent).toList();
        totalPages = result['totalpages'];
      });
      print('Successfully fetched ${currentArticles.length} articles for page $page');
    } catch (e) {
      print("Something went wrong: $e");
      setState(() {
        currentArticles = [];
        totalPages = 1;
      });
    }
  }

  void changePage(int page) {
    setState(() {
      currentPage = page.clamp(1, totalPages);
      fetchNewsLetter(page.clamp(1, totalPages));
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsletterProvider = Provider.of<NewsletterProvider>(context);
    
    print('PaginatedNewsletterList: Building with ${currentArticles.length} articles, provider has ${newsletterProvider.newsletters.length} newsletters'); // Debug log
    
    // Show loading indicator if provider is loading
    if (newsletterProvider.isLoading && currentArticles.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    
    // Show error if provider has error
    if (newsletterProvider.hasError && currentArticles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: ${newsletterProvider.errorMessage}',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                newsletterProvider.refreshNewsletters();
                fetchNewsLetter(currentPage);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    return Column(
      children: [
        // Article List
        ...currentArticles.where((article) => article.imageUrl.isNotEmpty).map((
          article,
        ) {
          return ArticleList(
            article: article,
            onTap: () {
              isSubscribed
                  ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => NewsDetailScreen(
                            author: article.author,
                            formattedDate: article.formattedDate,
                            imageUrl: article.imageUrl,
                            title: article.title,
                            articleSlug: article.excerpt,
                            articles: currentArticles as List<ArticleModel>,
                          ),
                    ),
                  )
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Subscribe Required'),
                          content: const Text('You need to subscribe to the newsletter to view this content.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
            },
          );
        }),

        const SizedBox(height: 16),

        // Pagination Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _paginationButton(
              icon: Icons.chevron_left,
              onTap: () => changePage(currentPage - 1),
              isEnabled: currentPage > 1,
            ),
            ..._buildPageNumbers(),
            _paginationButton(
              icon: Icons.chevron_right,
              onTap: () => changePage(currentPage + 1),
              isEnabled: currentPage < totalPages,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];

    void addPage(int page) {
      pages.add(
        _paginationNumber(
          number: page,
          isActive: page == currentPage,
          onTap: () => changePage(page),
        ),
      );
    }

    if (totalPages <= 7) {
      for (int i = 1; i <= totalPages; i++) {
        addPage(i);
      }
    } else {
      addPage(1);

      if (currentPage > 4) {
        pages.add(_paginationText('...'));
      }

      int start = (currentPage - 1).clamp(2, totalPages - 3);
      int end = (currentPage + 1).clamp(2, totalPages - 1);
      for (int i = start; i <= end; i++) {
        addPage(i);
      }

      if (currentPage < totalPages - 3) {
        pages.add(_paginationText('...'));
      }

      addPage(totalPages);
    }

    return pages;
  }

  Widget _paginationButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _paginationNumber({
    required int number,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? AppColors.accentColor : Colors.white,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Text(
          '$number',
          style: TextStyle(
            color: isActive ? AppColors.accentColor : Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            decoration: isActive ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }

  Widget _paginationText(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
