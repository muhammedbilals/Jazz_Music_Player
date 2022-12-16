import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/bottom_navigation.dart';
import 'package:music_player/screens/libraryScreen/widgets/library_list_widget.dart';
import 'package:music_player/screens/mainhome/screens/Liked_songs_list.dart';
import 'package:music_player/screens/mainhome/screens/albums_list.dart';
import 'package:music_player/screens/mainhome/screens/most_played.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:music_player/screens/mainhome/screens/playlist_list_screen.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({super.key});
  List accounttitle = [
    'All Songs',
    'Liked Songs',
    'Most Played',
    'Recently Played',
    'Albums',
    'Your Playlists'
  ];
  List titleicon = [
    Icons.music_note,
    Icons.favorite,
    Icons.restart_alt,
    Icons.history,
    Icons.album_outlined,
    Icons.library_music_outlined,
  ];
  List titlenavigation = [
    HomeMain(),
    LikedSongsList(),
    MostPlayed(),
    MostPlayed(),
    AlbumsList(),
    PlayListScreen()

  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colordark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colordark,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Your Library',
                        style:
                            GoogleFonts.kanit(fontSize: 40, color: colorwhite),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // LibraryList(),
                // const SeeMoreWidget(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: accounttitle.length,
                  itemBuilder: ((context, index) => ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      titlenavigation[index])));
                        },
                        leading: Icon(
                          titleicon[index],
                          color: colorwhite,
                        ),
                        title: Text(
                          accounttitle[index],
                          style: GoogleFonts.kanit(
                              color: colorwhite, fontSize: 20),
                        ),
                      )),
                ),
                // Expanded(child: PlayListScreen())
              ],
            ),
          ),
          bottomSheet: NowPlayingSlider(),
        ),
      ),
    );
  }
}
