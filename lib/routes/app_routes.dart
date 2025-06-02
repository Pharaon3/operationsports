import 'package:go_router/go_router.dart';
import 'package:operationsports/screens/profile_screen.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/article_detail_screen.dart';
import '../screens/menu_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(path: '/menu', builder: (context, state) => const MenuScreen()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/articleDetail',
        builder: (context, state) {
          final article = state.extra as String;
          return ArticleDetailScreen(articleId: article, articles: []);
        },
      ),
    ],
  );
}
