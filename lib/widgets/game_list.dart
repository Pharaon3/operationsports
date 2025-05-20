import 'package:flutter/material.dart';

class GameListWidget extends StatelessWidget {
  final List<String> gameTitles;

  const GameListWidget({
    super.key,
    required this.gameTitles,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: gameTitles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFFF5757),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                gameTitles[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
