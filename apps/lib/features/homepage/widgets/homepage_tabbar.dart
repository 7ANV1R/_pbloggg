import 'package:flutter/material.dart';

import '../../../core/theme/palette.dart';

class HomePageTabBar extends StatelessWidget {
  const HomePageTabBar({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      color: Palette.darkScaffoldBgColor,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        tabAlignment: TabAlignment.start,
        indicatorColor: Palette.darkBlackFontColor,
        labelColor: Palette.darkBlackFontColor,
        unselectedLabelColor: Palette.lightBlackFontColor,
        tabs: const [
          Tab(
            text: 'Latest',
          ),
          Tab(text: 'Trending'),
          Tab(text: 'Popular'),
          Tab(text: 'Technology'),
          Tab(text: 'Design'),
          Tab(text: 'Development'),
        ],
      ),
    );
  }
}
