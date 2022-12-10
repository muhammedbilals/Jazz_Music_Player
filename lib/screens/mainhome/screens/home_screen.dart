import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/widgets/all_songs_widget.dart';
import 'package:music_player/screens/mainhome/widgets/card_widget.dart';
import 'package:music_player/screens/mainhome/widgets/playlist_slider_widget.dart';

class PlayerHome extends StatelessWidget {
  const PlayerHome({super.key});

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colordark,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Hello, Bilal',
                    style: GoogleFonts.kanit(fontSize: 40, color: colorwhite),
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
                      child: Icon(
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
                      style:
                          GoogleFonts.kanit(fontSize: 20, color: colorwhite)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget(cardicon: Icons.favorite, cardtext: 'Liked Songs'),
                CardWidget(cardicon: Icons.album, cardtext: 'Albums'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget(cardicon: Icons.queue_music, cardtext: 'Playlists'),
                CardWidget(cardicon: Icons.person, cardtext: 'Artist')
              ],
            ),
            SizedBox(height: 260, child: PlaylistSlider()),
            Expanded( child: AllSongsWidget()),
            // Expanded(child: AllSongsWidget())
          ],
        ),
      ),
    );
  }
}
