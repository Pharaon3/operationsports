import 'package:flutter/material.dart';
import 'package:operationsports/screens/home_screen.dart';

class DefaultAppbar extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final void Function(String) searchQuery;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const DefaultAppbar({
    super.key,
    required this.onMenuPressed,
    required this.searchQuery,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  State<DefaultAppbar> createState() => _DefaultAppbarState();
}

class _DefaultAppbarState extends State<DefaultAppbar> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void onSearchPress() {
    setState(() {
      isSearching = true;
    });
  }

  void onSearchSubmit() {
    final query = _searchController.text.trim();
    widget.searchQuery(query);
    print("Searching for: $query");
  }

  void onSearchCancel() {
    setState(() {
      isSearching = false;
      _searchController.clear();
    });
    // Clear the search by calling with empty string
    widget.searchQuery('');
  }

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onSearchCancel,
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.2,
                    ),
                  ),
                ),
                onSubmitted: (_) => onSearchSubmit(),
              ),
            ),

            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: onSearchSubmit,
            ),
          ],
        ),
      );
    }

    // Default AppBar
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              // if (widget.showBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: widget.onBackPressed ?? () => Navigator.of(context).maybePop(),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset('assets/logo.png', height: 22),
              ),
              const SizedBox(width: 4.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text(
                  'OPERATION SPORTS',
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onSearchPress,
                child: Container(
                  height: 40,
                  width: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF111111),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: widget.onMenuPressed,
                child: Image.asset('assets/menu.png', height: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
