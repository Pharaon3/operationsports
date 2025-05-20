import 'package:flutter/material.dart';
import 'package:operationsports/screens/forum_list.dart';

class ForumMenu extends StatefulWidget {
  final String title;
  final List<String> subItems;

  const ForumMenu({super.key, required this.title, required this.subItems});

  @override
  State<ForumMenu> createState() => _ForumMenuState();
}

class _ForumMenuState extends State<ForumMenu> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Accordion Header
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFF5757),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 7),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(
                isExpanded ? Icons.remove_circle : Icons.add_circle,
                color: const Color(0xFF222222),
              ),
            ),
          ),
        ),

        // Sub-items
        if (isExpanded)
          Column(
            children:
                widget.subItems.map((item) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF434343),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: 73,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForumList(),
                                ),
                              );
                            },
                          ),
                        ),
                        
                      ],
                    ),
                  );
                }).toList(),
          ),

        SizedBox(height: 10),
      ],
    );
  }
}
