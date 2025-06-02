import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:operationsports/models/forum_section.dart';

class ForumService {
  static Future<List<ForumSection>> fetchForumSections() async {
    final url = Uri.parse('https://forums.operationsports.com/forums/api.php?api_m=node.fetchChannelNodeTree&api_c=2&api_s=7334d9bf5c85ba976464e8486a558abd&api_sig=c4ca10044f80076ebbfd5aa0a416b8d3'); // Replace
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final channels = jsonData['channels'] as Map<String, dynamic>;

      final sections = channels.entries
          .map((entry) => ForumSection.fromMapEntry(entry))
          .where((section) => section.subItems.isNotEmpty)
          .toList();

      return sections;
    } else {
      throw Exception('Failed to load forum sections');
    }
  }
}
