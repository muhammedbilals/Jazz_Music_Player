import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/Liked_songs_list.dart';
import 'package:music_player/screens/mainhome/screens/albums_list.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:music_player/screens/mainhome/screens/playlist_list_screen.dart';
import 'package:music_player/screens/mainhome/widgets/all_songs_widget.dart';
import 'package:music_player/screens/mainhome/widgets/card_widget.dart';
import 'package:music_player/screens/mainhome/widgets/playlist_slider_widget.dart';

class PlayerHome extends StatelessWidget {
  const PlayerHome({super.key});

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    return Container(
      color: colordark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colordark,
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Hello, Bilal',
                          style: GoogleFonts.kanit(
                              fontSize: 40, color: colorwhite),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                            decoration: BoxDecoration(
                                color: colorextralight,
                                borderRadius: BorderRadius.circular(30)),
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.person,
                              color: colorblack,
                              size: 25,
                            )),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text('Discover',
                            style: GoogleFonts.kanit(
                                fontSize: 20, color: colorwhite)),
                      )
                    ],
                  ),
                  // ----------------------------------------Liked songs---------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CardWidget(
                      //     cardicon: Icons.favorite, cardtext: 'Liked Songs'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LikedSongsList()),
                            );
                          },
                          child: Container(
                            height: 55,
                            width: vwidth * 0.45,
                            decoration: BoxDecoration(
                                color: colorextralight,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 10),
                                  child: Icon(Icons.favorite),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Text(
                                    'Liked Songs',
                                    style: GoogleFonts.kanit(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ----------------------------------------albums---------------------------------
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AlbumsList()),
                            );
                          },
                          child: Container(
                            height: 55,
                            width: vwidth * 0.45,
                            decoration: BoxDecoration(
                                color: colorextralight,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 10),
                                  child: Icon(Icons.album),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Text(
                                    'Albums',
                                    style: GoogleFonts.kanit(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
// ----------------------------------------playlist-------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PlayListScreen()),
                            );
                          },
                          child: Container(
                            height: 55,
                            width: vwidth * 0.45,
                            decoration: BoxDecoration(
                                color: colorextralight,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 10),
                                  child: Icon(Icons.queue_music),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Text(
                                    'Playlists',
                                    style: GoogleFonts.kanit(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      CardWidget(cardicon: Icons.person, cardtext: 'Artist')
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 5, bottom: 5),
                        child: Text('Your Playlists',
                            style: GoogleFonts.kanit(
                                fontSize: 20, color: colorwhite)),
                      )
                    ],
                  ),
                  PlaylistSlider(),
                  Stack(
                    children: [
                                        
                      AllSongsWidget(),
                      
                       ],
                  ),
                  // Expanded(child: AllSongsWidget())
                  
                ],
              ),
            ),
          ),
          bottomSheet:
          
           NowPlayingSlider(),
           
        ),
      ),
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
