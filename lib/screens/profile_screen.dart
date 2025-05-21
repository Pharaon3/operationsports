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
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: Colors.black),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Jake Smith',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Settings options
              const Divider(color: Colors.grey),
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
          title: Text(text, style: const TextStyle(color: Colors.white70)),
          onTap: () {
            // Handle option tap if needed
          },
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
