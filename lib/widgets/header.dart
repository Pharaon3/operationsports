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
      child: Column(
        children: [
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
