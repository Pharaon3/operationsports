import 'package:flutter/material.dart';
import 'package:operationsports/providers/category_provider.dart';
import 'package:operationsports/providers/news_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme.dart';
import 'routes/app_routes.dart';
import 'providers/auth_provider.dart';
import 'providers/article_provider.dart';
import 'providers/navigation_provider.dart';
import 'package:flutter/scheduler.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: AppLifecycleManager(
        child: _AuthLoader(),
      ),
    );
  }
}

class _AuthLoader extends StatefulWidget {
  @override
  State<_AuthLoader> createState() => _AuthLoaderState();
}

class _AuthLoaderState extends State<_AuthLoader> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _waitForAuth();
  }

  Future<void> _waitForAuth() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // Wait a short moment for AuthProvider to load stored data
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return _AuthGate();
  }
}

class _AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp.router(
      title: 'Operation Sports',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
      // Set initial route based on authentication
      // GoRouter already uses initialLocation, but we can redirect in AppRoutes if needed
    );
  }
}

class AppLifecycleManager extends StatefulWidget {
  final Widget child;
  const AppLifecycleManager({Key? key, required this.child}) : super(key: key);

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // App is removed from recents (Android)
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.logout();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
