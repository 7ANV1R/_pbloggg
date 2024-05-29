class BlogPreviewModel {
  final String id;
  final String title;
  final String? cover;
  final String createdAt;
  final String updatedAt;

  BlogPreviewModel({
    required this.id,
    required this.title,
    this.cover,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPreviewModel.fromJson(Map<String, dynamic> json) {
    return BlogPreviewModel(
      id: json['id'],
      title: json['title'],
      cover: json['cover'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
//  {
//             "id": "66537108faa408caca20d20f",
//             "title": "Test Title 3",
//             "cover": null,
//             "createdAt": "2024-05-26T17:27:36.601Z",
//             "updatedAt": "2024-05-26T17:27:36.601Z"
//         }