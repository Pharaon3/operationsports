import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset('assets/logo.png', height: 24),
              ),
              const SizedBox(width: 4.0),
              const Text(
                "OPERATION SPORTS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          const Text(
            "The premier sports gamer destination",
            style: TextStyle(color: Color(0xFF707070)),
          ),
          const SizedBox(height: 16),

          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                FontAwesomeIcons.facebook,
                color: Color(0xFF434343),
                size: 20,
              ),
              SizedBox(width: 24),
              Icon(
                FontAwesomeIcons.youtube,
                color: Color(0xFF434343),
                size: 20,
              ),
              SizedBox(width: 24),
              Icon(
                FontAwesomeIcons.twitter,
                color: Color(0xFF434343),
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Divider(color: Colors.white),

          // Links
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: const [
                Text("ABOUT US", style: TextStyle(color: Color(0xFF707070))),
                SizedBox(height: 8),
                Text("TERMS", style: TextStyle(color: Color(0xFF707070))),
                SizedBox(height: 8),
                Text("PRIVACY", style: TextStyle(color: Color(0xFF707070))),
              ],
            ),
          ),

          const Divider(color: Colors.white),

          const SizedBox(height: 16),
          // Gamurs Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38, bottom: 70),
                child: Image.asset('assets/white gamurs.png', height: 26),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
