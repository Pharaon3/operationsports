import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/article_model.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/article_detail_screen.dart';
import '../screens/menu_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/menu',
        builder: (context, state) => const MenuScreen(),
      ),
      GoRoute(
        path: '/articleDetail',
        builder: (context, state) {
          final article = state.extra as String;
          return ArticleDetailScreen(articleId: article);
        },
      ),

      // GoRoute(
      //   path: '/articleDetail',
      //   builder: (context, state) {
      //     final article = state.extra; // Expecting ArticleModel passed as extra
      //     return ArticleDetailScreen(article: article);
      //   },
      // ),
    ],
  );
}
