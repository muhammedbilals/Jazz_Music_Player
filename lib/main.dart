import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/model/dbfunctions.dart';
import 'package:music_player/model/favourites.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/model/recentlyplayed.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);
  Hive.registerAdapter(RecentlyPlayedAdapter());
  // openHiveBox('RecentlyPlayed');
  openrecentlyplayeddb();
  Hive.registerAdapter(favouritesAdapter());
  openFavouritesDB();
  Hive.registerAdapter(PlaylistSongsAdapter());
   await Hive.openBox<PlaylistSongs>('playlist');
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      home: const PlayerSplash(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
