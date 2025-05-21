import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'routes/app_routes.dart';
import 'providers/auth_provider.dart';
import 'providers/article_provider.dart';
import 'providers/navigation_provider.dart';
import './core/constants.dart';

void main() {
  runApp(const OperationSportsApp());
}

class OperationSportsApp extends StatelessWidget {
  const OperationSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp.router(
        title: 'Operation Sports',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
