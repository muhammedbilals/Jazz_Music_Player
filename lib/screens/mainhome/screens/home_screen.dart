import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:music_player/screens/mainhome/widgets/all_songs_widget.dart';
import 'package:music_player/screens/mainhome/widgets/card_widget.dart';
import 'package:music_player/screens/mainhome/widgets/playlist_slider_widget.dart';

class PlayerHome extends StatelessWidget {
  PlayerHome({super.key});
  final box = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    List<Songs> dbsongs = box.values.toList();
    double vwidth = MediaQuery.of(context).size.width;
    return Container(
      color: colordark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colordark,
          // body: Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(image: AssetImage('assets/images/gulf livery.jpg'),fit: BoxFit.cover)
          //   ),
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
                    children: [
                      CardWidget(
                          cardicon: Icons.favorite,
                          cardtext: 'Liked Songs',
                          index: 0),
                      CardWidget(
                          cardicon: Icons.album, cardtext: 'Albums', index: 1),
                    ],
                  ),
// ----------------------------------------playlist-------------------------------------

                  Row(
                    children: [
                      CardWidget(
                        cardicon: Icons.queue_music_outlined,
                        cardtext: 'Playlists',
                        index: 2,
                      ),
                      CardWidget(
                        cardicon: Icons.restart_alt,
                        cardtext: 'Most Played',
                        index: 3,
                      ),
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
                    children: const [
                      AllSongsWidget(),
                    ],
                  ),
                  // Expanded(child: AllSongsWidget())
                ],
              ),
            ),
          ),
          bottomSheet: NowPlayingSlider(),
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
