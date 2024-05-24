import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pbloggg_app/core/theme/palette.dart';
import 'package:pbloggg_app/core/ui_helper/ui_helper.dart';
import 'package:pbloggg_app/routes/router.dart';
import 'package:persistent_header_adaptive/persistent_header_adaptive.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Palette.scaffoldBgColor,
              elevation: 0,
              title: Text(
                'pbloggg.',
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Palette.darkBlackFontColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    EvaIcons.bell_outline,
                    color: Palette.darkBlackFontColor,
                    size: 22,
                  ),
                ),
              ],
            ),
            AdaptiveHeightSliverPersistentHeader(
              pinned: true,
              needRepaint: false,
              child: Container(
                color: Palette.scaffoldBgColor,
                child: const Center(
                  child: Text('Header'),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('card $index'),
                  ),
                ),
                childCount: 100,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouteOf.createBlog);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
