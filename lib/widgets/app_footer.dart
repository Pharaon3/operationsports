import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:operationsports/core/constants.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  void _openURL(String url) async {
    Uri uri = Uri.parse(url);

    if (Platform.isWindows) {
      // Use `Process.start` on Windows instead of `launchUrl`
      await Process.start('explorer.exe', [url]);
    } else {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } else {
        print("❌ Could not open: $url");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
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

          const SizedBox(height: 16),
          const Text(
            "The premier sports gamer destination",
            style: TextStyle(
              color: Color(0xFF707070),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 22),

          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _openURL('https://facebook.com/'),
                child: Icon(
                  FontAwesomeIcons.facebook,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
              ),

              SizedBox(width: 24),
              GestureDetector(
                onTap: () => _openURL('https://youtube.com/'),
                child: Icon(
                  FontAwesomeIcons.youtube,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: 24),
              GestureDetector(
                onTap: () => _openURL('https://x.com/'),
                child: Icon(
                  FontAwesomeIcons.twitter,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(color: Colors.white),
          ),

          // Links
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap:
                      () => _openURL('https://www.operationsports.com/about/'),
                  child: const Text(
                    "ABOUT US",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap:
                      () => _openURL('https://www.operationsports.com/terms/'),
                  child: const Text(
                    "TERMS",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap:
                      () => _openURL(
                        'https://www.operationsports.com/privacy-policy/',
                      ),
                  child: const Text(
                    "PRIVACY",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(color: Colors.white),
          ),

          // Gamurs Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38, bottom: 70),
                child: Image.asset('assets/white gamurs.png', height: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
