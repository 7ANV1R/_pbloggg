import 'package:pbloggg_app/data/model/author_preview_model.dart';

class BlogPreviewModel {
  final String id;
  final String title;
  final String? cover;
  final String createdAt;
  final String updatedAt;
  final AuthorPreviewModel author;

  BlogPreviewModel({
    required this.id,
    required this.title,
    this.cover,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  factory BlogPreviewModel.fromJson(Map<String, dynamic> json) {
    return BlogPreviewModel(
      id: json['_id'],
      title: json['title'],
      cover: json['cover'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      author: AuthorPreviewModel.fromJson(json['author']),
    );
  }
}


// {
//             "_id": "66537108faa408caca20d20f",
//             "title": "Test Title 3",
//             "createdAt": "2024-05-26T17:27:36.601Z",
//             "updatedAt": "2024-05-26T17:27:36.601Z",
//             "cover": null,
//             "author": {
//                 "_id": "6656071d004dcbb9e3af1d0b",
//                 "full_name": "User 1",
//                 "email": "user1@gmail.com",
//                 "cover": null
//             }
//         },