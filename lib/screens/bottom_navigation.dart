import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/home_screen.dart';
import 'package:music_player/screens/mainhome/screens/profile_page.dart';
import 'package:music_player/screens/searchSreen/screens/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeMain extends StatelessWidget {
   HomeMain({super.key});

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _NavScreens() {
    return [PlayerHome(), const SearchScreen(), ProfilePage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: colorextralight,
        inactiveColorPrimary: colorwhite,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("SEARCH"),
        activeColorPrimary: colorextralight,
        inactiveColorPrimary: colorwhite,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("SETTINGS"),
        activeColorPrimary: colorextralight,
        inactiveColorPrimary: colorwhite,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _NavScreens(),
      items: _navBarsItems(),
      // confineInSafeArea: true,
      backgroundColor: colordark, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.

      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: colordark,
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

      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}
