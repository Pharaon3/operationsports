import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';

class RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const RoundButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: CircleAvatar(
        backgroundColor: onPressed != null ? AppColors.accentColor : Colors.grey,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}