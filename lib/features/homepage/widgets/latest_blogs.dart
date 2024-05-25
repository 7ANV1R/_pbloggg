import 'package:flutter/material.dart';
import 'package:pbloggg_app/core/theme/palette.dart';
import 'package:pbloggg_app/data/model/blog_preview_model.dart';

import 'blog_preview_card.dart';

class HomePageLatestBlogs extends StatelessWidget {
  const HomePageLatestBlogs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 30,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(
        height: 2,
        margin: const EdgeInsets.symmetric(vertical: 16),
        color: Palette.lightBlackFontColor.withOpacity(0.2),
      ),
      itemBuilder: (context, index) {
        return BlogPreviewCard(
          blogs: index.isEven ? BlogPreviewModel.demoData[0] : BlogPreviewModel.demoData[1],
        );
      },
    );
  }
}
