import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/models/category_model.dart';
import 'package:operationsports/screens/game_list.dart';

class GameListWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  // final List<String> gameTitles;

  const GameListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameList(categoryId: categories[index].id)),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.accentColor,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  categories[index].title,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
