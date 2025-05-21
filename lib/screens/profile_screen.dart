import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:operationsports/core/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                top: 38,
                left: 26,
                child: IconButton(
                  icon: Image.asset('assets/red back.png', height: 38),
                  onPressed: () => context.go('/'),
                  tooltip: 'Back',
                ),
              ),

              const SizedBox(height: 24),

              // Avatar and name
              Center(
                child: Column(
                  children: const [
                    Icon(Icons.account_circle_outlined, size: 138, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Jake Smith',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Settings options
              _buildOption('Notifications'),
              _buildOption('Edit profile'),
              _buildOption('Options'),
              _buildOption('Security'),
              _buildOption('Help'),
              _buildOption('Version'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String text) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 30,
          title: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          onTap: () {
            // Handle option tap if needed
          },
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
