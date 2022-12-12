import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/libraryScreen/screens/library_screen.dart';
import 'package:music_player/screens/mainhome/screens/home_screen.dart';
import 'package:music_player/screens/searchSreen/screens/search_screen.dart';

class HomeMain extends StatefulWidget {
  HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;

  // int  index= _selectedIndex;
  // Color? colorafa = colorextralight;
  // Color? selectedcolor = colorlightdark;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
     PlayerHome(),
    SearchScreen(),
    LibraryScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // colorafa = colordark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: _widgetOptions.elementAt(_selectedIndex)),
      // bottomNavigationBar: GNav(
      //   backgroundColor: colordark,
      //   color: colordark,
      //   gap: 8,
      //   tabs: [
      //   GButton(icon: Icons.home,
      //   text: 'Home',
      //   ),
      //   GButton(icon: Icons.search,
      //   text: 'Search',),
      //   GButton(icon: Icons.library_music,
      //   text: 'Library',
      //   )
      // ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorextralight,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(
                    // color: colorlightdark,
                    borderRadius: BorderRadius.circular(25)),
                height: 40,
                width: 100,
                child: const Icon(Icons.home_outlined)),
            label: 'Home',
            activeIcon: const Icon(
              Icons.home_sharp,
            ),
          ),
          BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(

                    // color: colorlightdark,
                    borderRadius: BorderRadius.circular(25)),
                height: 40,
                width: 100,
                child: const Icon(Icons.search)),
            label: 'Business',
            activeIcon: const Icon(
              Icons.search_sharp,
            ),
          ),
          BottomNavigationBarItem(
            icon: Container(
                decoration: BoxDecoration(
                    // color: colorlightdark,

                    borderRadius: BorderRadius.circular(25)),
                height: 40,
                width: 100,
                child: const Icon(Icons.library_music_outlined)),
            label: 'School',
            activeIcon: const Icon(
              Icons.library_music,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
