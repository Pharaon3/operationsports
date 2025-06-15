import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'right_side_drawer.dart';
import 'default_appbar.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold>
    with SingleTickerProviderStateMixin {
  bool _isDrawerOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      if (_isDrawerOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _closeDrawer() {
    if (_isDrawerOpen) {
      setState(() {
        _isDrawerOpen = false;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction > 0)
          _closeDrawer(); // swipe left to right to close
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          title: DefaultAppbar(
            onMenuPressed: _toggleDrawer,
            searchQuery: (String query) => {},
          ),
        ),
        body: Stack(
          children: [
            widget.child,
            if (_isDrawerOpen)
              SlideTransition(
                position: _slideAnimation,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RightSideDrawer(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
