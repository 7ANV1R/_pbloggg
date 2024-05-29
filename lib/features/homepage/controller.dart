import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/api/blog/blog_api.dart';

final allBlogsProvider = FutureProvider.family((ref, int pageKey) async {
  final api = ref.watch(blogAPIProvider);
  return api.fetchBlogPosts(pageKey: pageKey);
});
