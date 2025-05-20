import 'package:flutter/material.dart';

class DefaultAppbar extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const DefaultAppbar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset('assets/logo.png', height: 26),
              ),
              const SizedBox(width: 4.0),
              const Text(
                'OPERATION SPORTS',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),
          GestureDetector(
            onTap: onMenuPressed,
            child: Image.asset('assets/menu.png', height: 40),
          ),
        ],
      ),
    );
  }
}
