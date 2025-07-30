import 'package:flutter/material.dart';
import 'package:operationsports/providers/newsletter_provider.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/paginated_newsletter.dart';
import 'package:provider/provider.dart';
import '../widgets/app_footer.dart';
import '../widgets/newslettersection.dart';

class NewsLetter extends StatefulWidget {
  const NewsLetter({super.key});

  @override
  State<NewsLetter> createState() => _NewsLetterState();
}

class _NewsLetterState extends State<NewsLetter> {
  final GlobalKey<PaginatedNewsletterListState> _paginatedListKey = GlobalKey<PaginatedNewsletterListState>();

  @override
  void initState() {
    super.initState();
    // Ensure newsletter data is loaded when screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsletterProvider = Provider.of<NewsletterProvider>(context, listen: false);
      if (newsletterProvider.newsletters.isEmpty) {
        print('Newsletter: Initializing newsletter data...'); // Debug log
        newsletterProvider.fetchNewsletters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsletterProvider = Provider.of<NewsletterProvider>(context);
    
    return MainScaffold(
      child: RefreshIndicator(
        onRefresh: () async {
          print('Newsletter: Pull to refresh triggered'); // Debug log
          await newsletterProvider.refreshNewsletters();
          // Also refresh the paginated newsletter list
          if (_paginatedListKey.currentState != null) {
            _paginatedListKey.currentState!.refreshNewsletterList();
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // This ensures pull-to-refresh works
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                const Header(selectedMenu: 2,),

                const NewsletterSection(),

                PaginatedNewsletterList(key: _paginatedListKey),

                const SizedBox(height: 32),

                const AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}