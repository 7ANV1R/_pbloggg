import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pbloggg_app/core/theme/palette.dart';
import 'package:pbloggg_app/core/ui_helper/ui_helper.dart';
import 'package:pbloggg_app/routes/router.dart';
import 'package:persistent_header_adaptive/persistent_header_adaptive.dart';

import 'widgets/homepage_tabbar.dart';
import 'widgets/latest_blogs.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Palette.darkScaffoldBgColor,
      statusBarIconBrightness: Brightness.dark,
    ));

    final tabController = useTabController(initialLength: 6, initialIndex: 0);
    final scrollController = useScrollController();
    return Container(
      color: Palette.darkScaffoldBgColor,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Palette.darkScaffoldBgColor,
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
                      onPressed: () {
                        // scroll to end
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
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
                  child: HomePageTabBar(
                    tabController: tabController,
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: [
                // TODO: fix scroll position issue when switching tabs
                HomePageLatestBlogs(
                  key: UniqueKey(),
                ),
                HomePageLatestBlogs(
                  key: UniqueKey(),
                ),
                HomePageLatestBlogs(
                  key: UniqueKey(),
                ),
                HomePageLatestBlogs(
                  key: UniqueKey(),
                ),
                HomePageLatestBlogs(
                  key: UniqueKey(),
                ),
                HomePageLatestBlogs(
                  key: UniqueKey(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push(RouteOf.createBlog);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
