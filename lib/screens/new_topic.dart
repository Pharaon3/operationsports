import 'package:flutter/material.dart';
import 'package:operationsports/core/constants.dart';
import 'package:operationsports/widgets/round_button.dart';

class CreateTopicPage extends StatelessWidget {
  const CreateTopicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Create New Topic'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Row
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        elevation: WidgetStatePropertyAll(4),
                        shadowColor: WidgetStatePropertyAll(Colors.black26),
                      ),
                      child: Text('Icon'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Title...',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Post Body
              Container(
                height: 180,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Write Your Post...",
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Attachment Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RoundButton(icon: Icons.link, onPressed: () {}),
                        const SizedBox(width: 8),
                        RoundButton(icon: Icons.camera_alt, onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Tags Input
              Row(
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Tags',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40, // Set the height to 40 pixels
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.1,
                            ), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 4, // Blur radius
                            offset: Offset(0, 2), // Offset of the shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Add tags...',
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Tag Suggestions
              const Text(
                'You can also choose from the popular tag list:',
                style: TextStyle(color: Color(0xFF707070), fontSize: 13),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 2,
                children:
                    [
                      'nba',
                      'nba2k',
                      'basketball',
                      'draft',
                      'nfl',
                      'online',
                      'xbox360',
                      'franchise',
                      'roster',
                      'sliders',
                      'dynasty',
                    ].map((tag) {
                      return Chip(
                        label: Text(tag, style: TextStyle(fontSize: 13)),
                        backgroundColor: const Color(0xFFF6F6F6),
                        labelStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 6,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Color(0xFFF6F6F6), width: 1),
                        ),
                        padding: EdgeInsets.all(1),
                      );
                    }).toList(),
              ),

              const SizedBox(height: 30),

              // Advanced Options
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Advanced Options',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.add, color: Colors.white),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Bottom Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildFlatButton("Cancel", onPressed: () {}),
                  const SizedBox(width: 8),
                  _buildFlatButton("Preview", onPressed: () {}),
                  const SizedBox(width: 8),
                  _buildFilledButton("Post", onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildFlatButton(String label, {required VoidCallback onPressed}) {
  return Container(
    width: 59.26,
    height: 24.33,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.86),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(-1.25, 2.5),
          blurRadius: 2.5,
          spreadRadius: -0.62,
        ),
      ],
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}

Widget _buildFilledButton(String label, {required VoidCallback onPressed}) {
  return Container(
    width: 59.26,
    height: 24.33,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.86),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(-1.25, 2.5),
          blurRadius: 2.5,
          spreadRadius: -0.62,
        ),
      ],
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.86),
        ),
        textStyle: const TextStyle(fontSize: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}
