class AuthorPreviewModel {
  final String id;
  final String fullName;
  final String email;
  final String? cover;

  AuthorPreviewModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.cover,
  });

  factory AuthorPreviewModel.fromJson(Map<String, dynamic> json) {
    return AuthorPreviewModel(
      id: json['_id'],
      fullName: json['full_name'] ?? 'Unknown Author',
      email: json['email'] ?? 'N/A',
      cover: json['cover'],
    );
  }
}

// {
// //                 "_id": "6656071d004dcbb9e3af1d0b",
// //                 "full_name": "User 1",
// //                 "email": "user1@gmail.com",
// //                 "cover": null
// //             }