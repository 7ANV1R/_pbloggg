class BlogPreviewModel {
  final String title;
  final String imageUrl;
  final String timeAgo;
  final String readTime;

  BlogPreviewModel({
    required this.title,
    required this.imageUrl,
    required this.timeAgo,
    required this.readTime,
  });

  static List<BlogPreviewModel> demoData = [
    BlogPreviewModel(
      title: 'How to make a blog in 2022',
      imageUrl: 'https://images.unsplash.com/photo-1630484163294-4b3b3b3b3b3b',
      timeAgo: '2 hours ago',
      readTime: '10 min read',
    ),
    BlogPreviewModel(
      title: 'A big title for a blog post ' * 2,
      imageUrl: 'https://images.unsplash.com/photo-1630484163294-4b3b3b3b3b3b',
      timeAgo: '1 hour ago',
      readTime: '8 min read',
    ),
  ];
}
