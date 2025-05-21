// lib/test_data/test_forum_data.dart
import 'package:operationsports/models/forum_model.dart';

final List<Map<String, dynamic>> rawTestForumData = [
  {
    "id": 1,
    "title": {"rendered": 'All Pro Football 2K'},
    "excerpt": {"rendered": 'The NFL makes me sick and 2k is delusional like a guy that thinks he can win the girl (NFL) heart every five years. At this point I made up my mind to stop my hope alive'},
    "yoast_head_json": {
      "og_image": [
        {"url": 'https://images.unsplash.com/photo-1566577739112-5180d4bf9390'},
      ]
    },
    "date": '2024-03-12T01:46:00',
  },
  {
    "id": 2,
    "title": {"rendered": 'All Pro Football 2K'},
    "excerpt": {"rendered": 'The NFL makes me sick and 2k is delusional like a guy that thinks he can win the girl (NFL) heart every five years. At this point I made up my mind to stop my hope alive'},
    "date": '2024-03-13T02:12:00',
  },
  {
    "id": 3,
    "title": {"rendered": 'All Pro Football 2K'},
    "excerpt": {"rendered": 'The NFL makes me sick and 2k is delusional like a guy that thinks he can win the girl (NFL) heart every five years. At this point I made up my mind to stop my hope alive'},
    "date": '2024-03-13T02:12:00',
  },
  {
    "id": 4,
    "title": {"rendered": 'All Pro Football 2K'},
    "excerpt": {"rendered": 'The NFL makes me sick and 2k is delusional like a guy that thinks he can win the girl (NFL) heart every five years. At this point I made up my mind to stop my hope alive'},
    "date": '2024-03-13T02:12:00',
  },
  {
    "id": 5,
    "title": {"rendered": 'All Pro Football 2K'},
    "excerpt": {"rendered": 'The NFL makes me sick and 2k is delusional like a guy that thinks he can win the girl (NFL) heart every five years. At this point I made up my mind to stop my hope alive'},
    "date": '2024-03-13T02:12:00',
  },
];

List<ForumModel> getTestForumList() =>
    rawTestForumData.map((json) => ForumModel.fromJson(json)).toList();
