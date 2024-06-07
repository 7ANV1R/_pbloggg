import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pbloggg_app/core/theme/palette.dart';
import 'package:pbloggg_app/data/model/blog_preview_model.dart';
import 'package:pbloggg_app/features/homepage/controller.dart';

import 'blog_preview_card.dart';

class HomePageLatestBlogs extends StatefulHookConsumerWidget {
  const HomePageLatestBlogs({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageLatestBlogsState();
}

class _HomePageLatestBlogsState extends ConsumerState<HomePageLatestBlogs> {
  final PagingController<int, BlogPreviewModel> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchBlogs(pageKey);
    });
  }

  // fetch paginated blogs
  Future<void> _fetchBlogs(int pageKey) async {
    try {
      final paginationResponse = await ref.read(allBlogsProvider(pageKey).future);
      paginationResponse.fold((l) {
        _pagingController.error = l.message;
      }, (r) {
        final isLastPage = r.nextPage == null;
        if (isLastPage) {
          _pagingController.appendLastPage(r.data);
        } else {
          _pagingController.appendPage(r.data, r.nextPage);
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      pagingController: _pagingController,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(
        height: 2,
        margin: const EdgeInsets.symmetric(vertical: 16),
        color: Palette.lightBlackFontColor.withOpacity(0.2),
      ),
      builderDelegate: PagedChildBuilderDelegate<BlogPreviewModel>(
        itemBuilder: (context, item, index) {
          return BlogPreviewCard(
            blogs: item,
          );
        },
      ),
    );
  }
}
