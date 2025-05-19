import 'package:flutter/material.dart';

class DefaultAppbar extends StatelessWidget {
  const DefaultAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset('assets/logo.png', height: 26),
              ),
              const SizedBox(width: 4.0),
              const Text(
                'OPERATION SPORTS',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),
          IconButton(
            icon: Image.asset('assets/menu.png', height: 40),
            onPressed: () {
              // Menu action
            },
          ),
        ],
      ),
    );
  }
}
