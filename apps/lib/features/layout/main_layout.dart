import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pbloggg_app/core/ui_helper/ui_helper.dart';
import 'package:pbloggg_app/features/homepage/homepage.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../temp/temp_upload.dart';

final GlobalKey<ScaffoldState> mainLayoutScaffoldKey = GlobalKey();

class MainLayoutPage extends StatefulHookConsumerWidget {
  const MainLayoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends ConsumerState<MainLayoutPage> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    return Container(
      color: scheme.onPrimary,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
      child: Scaffold(
        key: mainLayoutScaffoldKey,
        // endDrawer: const AppDrawer(),
        endDrawerEnableOpenDragGesture: false,
        body: PersistentTabView(
          context,
          controller: controller,
          screens: _buildScreens(),
          items: _navBarsItems(context),
          confineInSafeArea: false,

          backgroundColor: scheme.onPrimary, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.

          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            // colorBehindNavBar: scheme.surface,
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),

          navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const TempUpload(),
      const SizedBox(),
      const SizedBox(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesome.house_solid, size: 20),
        title: 'Home',
        activeColorPrimary: getColorScheme(context).primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesome.magnifying_glass_solid, size: 20),
        title: 'Search',
        activeColorPrimary: getColorScheme(context).primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesome.bookmark_solid, size: 20),
        title: 'Bookmarks',
        activeColorPrimary: getColorScheme(context).primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesome.user_solid, size: 20),
        title: 'Profile',
        activeColorPrimary: getColorScheme(context).primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
