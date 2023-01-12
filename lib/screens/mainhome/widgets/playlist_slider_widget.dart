import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/mostplayed.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/screens/mainhome/screens/playlist_full_list.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSlider extends StatelessWidget {
  PlaylistSlider({super.key});

  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;
    final playbox = PlaylistSongsbox.getInstance();

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
              child: Text('Your Playlists',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite)),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            /////////////////////
            child: ValueListenableBuilder<Box<PlaylistSongs>>(
              valueListenable: playbox.listenable(),
              builder: (context, Box<PlaylistSongs> playlistbox, child) {
                List<PlaylistSongs> playlistsong = playlistbox.values.toList();
                return Align(
                  alignment: Alignment.centerLeft,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (Orientation == Orientation.portrait) ? 1 : 1),
                    shrinkWrap: true,
                    itemCount: playlistsong.length,
                    // physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => PlaylistFullList(
                                        playindex: index,
                                        playlistname: playlistsong[index]
                                            .playlistname))));
                          },
                          child: Column(
                            children: [
                              playlistsong[index].playlistssongs!.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: SizedBox(
                                        width: 115,
                                        height: 115,
                                        child: QueryArtworkWidget(
                                          keepOldArtwork: true,
                                          artworkBorder:
                                              BorderRadius.circular(10),
                                          id: playlistsong[index]
                                              .playlistssongs![0]
                                              .id!,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              'assets/images/music.jpeg',
                                              height: vheight * 0.06,
                                              width: vheight * 0.06,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SizedBox(
                                        width: 115,
                                        height: 115,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.asset(
                                            'assets/images/music.jpeg',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                              Text(
                                playlistsong[index].playlistname!,
                                style: GoogleFonts.kanit(color: colorwhite),
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
