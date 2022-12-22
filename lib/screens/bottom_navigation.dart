
import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/libraryScreen/screens/library_screen.dart';
import 'package:music_player/screens/mainhome/screens/home_screen.dart';
import 'package:music_player/screens/searchSreen/screens/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _NavScreens() {
    return [ PlayerHome(), const SearchScreen(), LibraryScreen()];
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
        icon: const Icon(Icons.library_music),
        title: ("LIBRARY"),
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

// -----------------------------------------------------------------------------------


// import 'package:flutter/material.dart';
// import 'package:music_player/colors/colors.dart';
// import 'package:music_player/screens/libraryScreen/screens/library_screen.dart';
// import 'package:music_player/screens/mainhome/screens/home_screen.dart';
// import 'package:music_player/screens/searchSreen/screens/search_screen.dart';

// class HomeMain extends StatefulWidget {
//   const HomeMain({super.key});

//   @override
//   State<HomeMain> createState() => _HomeMainState();
// }

// class _HomeMainState extends State<HomeMain> {
//   int _selectedIndex = 0;

//   // int  index= _selectedIndex;
//   // Color? colorafa = colorextralight;
//   // Color? selectedcolor = colorlightdark;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//      PlayerHome(),
//     SearchScreen(),
//     LibraryScreen()
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;

//       // colorafa = colordark;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Center(child: _widgetOptions.elementAt(_selectedIndex)),
      
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: colordark,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Container(
//                 decoration: BoxDecoration(
//                     color: colorlight,
//                     borderRadius: BorderRadius.circular(25)),
//                 height: 40,
//                 width: 100,
//                 child: const Icon(Icons.home_outlined)),
//             label: 'Home',
//             activeIcon: const Icon(
//               Icons.home_sharp,
//             ),
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: colorblack,
//             icon: Container(
//                 decoration: BoxDecoration(

//                     color: colorextralight,
//                     borderRadius: BorderRadius.circular(25)),
//                 height: 40,
//                 width: 100,
//                 child: const Icon(Icons.search)),
//             label: 'Business',
//             activeIcon: const Icon(
//               Icons.search_sharp,
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Container(
//                 decoration: BoxDecoration(
//                     color: colorextralight,

//                     borderRadius: BorderRadius.circular(25)),
//                 height: 40,
//                 width: 100,
//                 child: const Icon(Icons.library_music_outlined)),
//             label: 'School',
//             activeIcon: const Icon(
//               Icons.library_music,
//             ),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
