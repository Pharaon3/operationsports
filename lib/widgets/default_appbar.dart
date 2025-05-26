import 'package:flutter/material.dart';

class DefaultAppbar extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const DefaultAppbar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset('assets/logo.png', height: 22),
              ),
              const SizedBox(width: 4.0),
              const Text(
                'OPERATION SPORTS',
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onMenuPressed,
                child: Container(
                  height: 40,
                  width: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
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
                onTap: onMenuPressed,
                child: Image.asset('assets/menu.png', height: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
