import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pbloggg_app/core/ui_helper/ui_helper.dart';

import '../../../core/theme/palette.dart';
import '../../../core/ui_helper/space_helper.dart';
import '../../../data/model/blog_preview_model.dart';

class BlogPreviewCard extends StatelessWidget {
  const BlogPreviewCard({super.key, required this.blogs});
  final BlogPreviewModel blogs;

  @override
  Widget build(BuildContext context) {
    final text = blogs.title;
    return Column(
      children: [
        // author and action btn row
        Row(
          children: [
            const CircleAvatar(
              radius: 10,
            ),
            const SizedBox(width: 8),
            Text(
              'John Doe',
              style: context.textTheme.labelMedium!.copyWith(
                color: Palette.blackFontColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            kGapSpaceS,
            BlogsDateTimeInfo(
              timeAgo: blogs.createdAt,
              // readTime: blogs.readTime,
            ),
            const Spacer(),
            GestureDetector(
              child: const Icon(
                EvaIcons.bookmark_outline,
                color: Palette.blackFontColor,
              ),
            ),
            kGapSpaceS,

            // more button
            GestureDetector(
              child: const Icon(
                EvaIcons.more_vertical,
                color: Palette.blackFontColor,
              ),
            ),
          ],
        ),

        // title and image row
        kGapSpaceS,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "$text\n",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Palette.blackFontColor,
                ),
              ),
            ),
            kGapSpaceM,
            Container(
              width: 16 * 6,
              height: 9 * 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BlogsDateTimeInfo extends StatelessWidget {
  const BlogsDateTimeInfo({
    super.key,
    required this.timeAgo,
    this.readTime = "0 min read",
    this.onTapSave,
    this.onTapMore,
  });
  final String timeAgo, readTime;
  final void Function()? onTapSave, onTapMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // small dot
        Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: Palette.lightBlackFontColor,
            shape: BoxShape.circle,
          ),
        ),
        kGapSpaceS,
        Text(
          timeAgo,
          style: context.textTheme.labelSmall!.copyWith(
            color: Palette.lightBlackFontColor,
          ),
        ),

        // 8 min read
        // kGapSpaceS,
        // Text(
        //   readTime,
        //   style: context.textTheme.labelSmall!.copyWith(
        //     color: Palette.lightBlackFontColor,
        //   ),
        // ),
      ],
    );
  }
}
