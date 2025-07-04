import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.article, 'label': 'Articles', 'route': '/home'},
      // {'icon': Icons.person, 'label': 'Profile', 'route': '/profile'}, // optional
      {'icon': Icons.settings, 'label': 'Settings', 'route': '/settings'}, // optional
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      drawer: const CustomDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: ListTile(
              leading: Icon(item['icon'] as IconData),
              title: Text(item['label'] as String),
              onTap: () {
                Navigator.pushNamed(context, item['route'] as String);
              },
            ),
          );
        },
      ),
    );
  }
}
