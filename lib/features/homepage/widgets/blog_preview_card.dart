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
        // author row
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
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Palette.blackFontColor,
                      ),
                    ),
                    const Spacer(),
                    kGapSpaceXS,
                    BlogsDateTimeInfo(
                      timeAgo: blogs.timeAgo,
                      readTime: blogs.readTime,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
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
        ),
      ],
    );
  }
}

class BlogsDateTimeInfo extends StatelessWidget {
  const BlogsDateTimeInfo({
    super.key,
    required this.timeAgo,
    required this.readTime,
    this.onTapSave,
    this.onTapMore,
  });
  final String timeAgo, readTime;
  final void Function()? onTapSave, onTapMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          timeAgo,
          style: context.textTheme.labelSmall!.copyWith(
            color: Palette.lightBlackFontColor,
          ),
        ),
        kGapSpaceS,

        // small dot
        Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: Palette.lightBlackFontColor,
            shape: BoxShape.circle,
          ),
        ),

        // 8 min read
        kGapSpaceS,
        Text(
          readTime,
          style: context.textTheme.labelSmall!.copyWith(
            color: Palette.lightBlackFontColor,
          ),
        ),
      ],
    );
  }
}
