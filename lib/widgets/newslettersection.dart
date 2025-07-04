import 'package:flutter/material.dart';

class NewsletterSection extends StatelessWidget {
  const NewsletterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/newsletter background.png', // Replace with your image asset
                width: double.infinity,
                fit: BoxFit.cover,
                height: 442,
              ),
              Positioned(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Be part of the most\ndedicated sports\ngaming community',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Join 32,000+ fans for weekly news,\nguides, and insights on your favorite sports\ngames, delivered straight to your inbox\nevery Friday.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15, 
                          color: Colors.white70,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Image.asset(
                      'assets/newsletter logo.png', // Replace with your logo asset
                      height: 100,
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Your E-mail',
                                      hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(
                                  0xFF1A1D23,
                                ), // Dark navy/black shade
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Subscribe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
