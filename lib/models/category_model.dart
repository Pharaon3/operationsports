class CategoryModel {

  final int id;
  final String title;
  final String link;

  CategoryModel({
    required this.id,
    required this.title,
    required this.link,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['name'],
      link: json['link']
    );
  }

}
