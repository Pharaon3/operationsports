import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/widgets/menu_button.dart';

class Header extends StatelessWidget {
  final int selectedMenu;
  const Header({super.key, this.selectedMenu = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
            child: SizedBox(
              height: 36,
              child: TextField(
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  hintStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Icons.search, size: 18),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (value) {
                  // Optional search logic
                },
              ),
            ),
          ),

          // Button Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
            child: MenuButton(selectedMenu: selectedMenu),
          ),
        ],
      ),
    );
  }
}
