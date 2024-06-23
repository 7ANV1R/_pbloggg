class CreateBlogPayload {
  final String title;
  final String content;

  CreateBlogPayload({
    required this.title,
    required this.content,
  });

  Map<String, String> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
