import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistFullList extends StatelessWidget {
  PlaylistFullList({super.key});

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    final List<PlaylistModel> playlistsong1 = [];
    final box = PlaylistSongsbox.getInstance();
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
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: colorextralight,
                              borderRadius: BorderRadius.circular(30)),
                          width: 40,
                          height: 40,
                          child: IconButton(
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Icon(
                                Icons.arrow_back_ios,
                              ),
                            ),
                            color: colorblack,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(
                    'Fav Songs',
                    style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                  ),
                  subtitle: Text(
                    '20 Songs',
                    style: GoogleFonts.kanit(
                        fontSize: 14, color: colorwhite.withOpacity(0.7)),
                  ),
                  trailing: Wrap(
                    spacing: 10,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.shuffle,
                          color: colorwhite,
                          size: 30,
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: colorextralight),
                        child: const Icon(
                          Icons.play_arrow,
                          color: colordark,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                // Icon(Icons.play_arrow)
                ValueListenableBuilder<Box<PlaylistSongs>>(
                  valueListenable: box.listenable(),
                  builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                    List<PlaylistSongs> playlistsong =
                        playlistsongs.values.toList();
                    print(playlistsongs);
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: playlistsong.length,
                      itemBuilder: ((context, index) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 5),
                            child: ListTile(
                              leading: ClipRRect(
                                child: Image.asset(
                                  playlistsong[index]
                                      .playlistssongs![index]
                                      .songurl!,
                                ),
                              ),
                              title: Text(
                                playlistsong[index]
                                    .playlistssongs![index]
                                    .songname!,
                                style: GoogleFonts.kanit(color: colorwhite),
                              ),
                              subtitle: Text(
                                  playlistsong[index]
                                      .playlistssongs![index]
                                      .artist!,
                                  style: GoogleFonts.kanit(
                                      color: colorwhite.withOpacity(0.7),
                                      fontSize: 12)),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite),
                                    color: Colors.red,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // showOptions(context);
                                    },
                                    icon: const Icon(Icons.more_vert),
                                    color: colorwhite,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
