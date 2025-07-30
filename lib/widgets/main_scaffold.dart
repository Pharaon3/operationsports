import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'right_side_drawer.dart';
import 'default_appbar.dart';

class ScrollControlWrapper extends StatefulWidget {
  final Widget child;
  final ScrollController? controller;

  const ScrollControlWrapper({super.key, required this.child, this.controller});

  @override
  State<ScrollControlWrapper> createState() => _ScrollControlWrapperState();
}

class _ScrollControlWrapperState extends State<ScrollControlWrapper> {
  late ScrollController _scrollController;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _showButton = _scrollController.offset > 200;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PrimaryScrollController(
          controller: _scrollController,
          child: widget.child,
        ),
        if (_showButton)
          Positioned(
            right: 16,
            bottom: 20,
            width: 50,
            height: 50,
            child: FloatingActionButton(
              heroTag: 'scroll_up',
              mini: true,
              onPressed: _scrollToTop,
              backgroundColor: Colors.white,
              child: const Icon(Icons.keyboard_arrow_up, size: 40),
            ),
          ),
      ],
    );
  }
}

class MainScaffold extends StatefulWidget {
  final Widget child;
  final void Function(String)? onSearch;

  const MainScaffold({super.key, required this.child, this.onSearch});

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
        if (details.delta.direction > 0) _closeDrawer();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          title: DefaultAppbar(
            onMenuPressed: _toggleDrawer,
            searchQuery: widget.onSearch ?? (String query) => {},
          ),
        ),
        body: Stack(
          children: [
            ScrollControlWrapper(child: widget.child),

            // Overlay when drawer is open
            if (_isDrawerOpen)
              GestureDetector(
                onTap: _closeDrawer,
                child: Container(
                  color: Colors.black.withOpacity(
                    0.3,
                  ), // semi-transparent overlay
                ),
              ),

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
