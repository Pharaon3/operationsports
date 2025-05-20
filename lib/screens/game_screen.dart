import 'package:flutter/material.dart';
import 'package:operationsports/widgets/default_appbar.dart';
import '../widgets/menu_button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        title: DefaultAppbar(),
      ),
      body: Stack(
        children: [
          // Main content
          Container(
            color: const Color(0xFF171717),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search articles...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
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
                // Button Row
                const MenuButton(selectedMenu: 3),

              ],
            ),
          ),

          // BottomIconButton(),
        ],
      ),
    );
  }
}
