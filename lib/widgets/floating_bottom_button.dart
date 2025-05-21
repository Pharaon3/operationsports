import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';

class BottomIconButton extends StatelessWidget {
  const BottomIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomIconButton(
                Icons.person,
                isActive: false,
                onTap: () {
                  // Profile logic
                },
              ),
              const SizedBox(width: 30),
              _buildBottomIconButton(
                Icons.home,
                isActive: true,
                onTap: () {
                  // Already on home
                },
              ),
              const SizedBox(width: 30),
              _buildBottomIconButton(
                Icons.notifications_none,
                isActive: false,
                onTap: () {
                  // Notifications logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomIconButton(
    IconData icon, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 28,
        color: isActive ? AppColors.accentColor : Colors.grey,
      ),
    );
  }
}
