import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/models/category_model.dart';
import 'package:operationsports/services/category_service.dart';
import 'package:operationsports/widgets/app_footer.dart';
import 'package:operationsports/widgets/error_widget.dart';
import 'package:operationsports/widgets/game_list.dart';
import 'package:operationsports/widgets/header.dart';
import 'package:operationsports/widgets/main_scaffold.dart';
import 'package:operationsports/widgets/loading_indicator.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = '';
    });

    try {
      final result = await CategoryService.fetchCategoriesPaginated(
        currentPage,
      );
      setState(() {
        categories = result['categories'];
        totalPages = result['totalPages'];
      });
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void changePage(int page) {
    if (page >= 1 && page <= totalPages) {
      setState(() {
        currentPage = page;
      });
      fetchCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingIndicator();
    }

    if (hasError) {
      return AppErrorWidget(message: errorMessage);
    }

    if (categories.isEmpty) {
      return const Center(child: Text("No categories found."));
    }

    categories.map((category) => category.title).toList();

    return MainScaffold(
      child: ListView(
        children: [
          const Header(selectedMenu: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 34),
            child: Text(
              'Games',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 34, vertical: 12),
            child: Text(
              'Categories',
              style: TextStyle(
                color: AppColors.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 55),
            child: GameListWidget(categories: categories),
          ),
          const SizedBox(height: 16),
          _buildPaginationControls(),
          const SizedBox(height: 20),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    const int maxVisiblePages = 3;

    int startPage = (currentPage - (maxVisiblePages ~/ 2)).clamp(1, totalPages);
    int endPage = (startPage + maxVisiblePages - 1).clamp(1, totalPages);

    // Adjust startPage if we’re near the end
    if (endPage - startPage < maxVisiblePages - 1) {
      startPage = (endPage - maxVisiblePages + 1).clamp(1, totalPages);
    }

    List<Widget> pageButtons = [];

    // Always show first page
    if (startPage > 1) {
      pageButtons.add(
        _paginationNumber(
          number: 1,
          isActive: currentPage == 1,
          onTap: () => changePage(1),
        ),
      );
      if (startPage > 2) {
        pageButtons.add(_paginationText('...'));
      }
    }

    for (int page = startPage; page <= endPage; page++) {
      pageButtons.add(
        _paginationNumber(
          number: page,
          isActive: page == currentPage,
          onTap: () => changePage(page),
        ),
      );
    }

    // Always show last page
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pageButtons.add(_paginationText('...'));
      }
      pageButtons.add(
        _paginationNumber(
          number: totalPages,
          isActive: currentPage == totalPages,
          onTap: () => changePage(totalPages),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _paginationButton(
          icon: Icons.chevron_left,
          onTap: () => changePage(currentPage - 1),
          isEnabled: currentPage > 1,
        ),
        ...pageButtons,
        _paginationButton(
          icon: Icons.chevron_right,
          onTap: () => changePage(currentPage + 1),
          isEnabled: currentPage < totalPages,
        ),
      ],
    );
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
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
