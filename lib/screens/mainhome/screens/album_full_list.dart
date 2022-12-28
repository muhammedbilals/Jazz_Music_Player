import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/recentlyplayed.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumFullList extends StatefulWidget {
  AlbumFullList({super.key});

  @override
  State<AlbumFullList> createState() => _AlbumFullListState();
}

class _AlbumFullListState extends State<AlbumFullList> {
  final List<RecentlyPlayed> recentplay = [];
    final box = RecentlyPlayedBox.getInstance();

  @override
  Widget build(BuildContext context) {
    void initState() {
      // TODO: implement initState
      

      List<RecentlyPlayed> Recentplay = box.values.toList();

        super.initState();
      
    }

    double vwidth = MediaQuery.of(context).size.width;
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
                    'Current',
                    style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                  ),
                  subtitle: Text(
                    '120 Songs',
                    style: GoogleFonts.kanit(
                        fontSize: 14, color: colorwhite.withOpacity(0.7)),
                  ),
                ),

                // Icon(Icons.play_arrow)

                ValueListenableBuilder<Box<RecentlyPlayed>>(
                  valueListenable: box.listenable(),
                  builder: ((context, Box<RecentlyPlayed> RecentDB, child) {
                    List<RecentlyPlayed> Recentplayed = RecentDB.values.toList();
                    return ListView.builder(
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Recentplayed.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              keepOldArtwork: true,
                              artworkBorder: BorderRadius.circular(10),
                              id: Recentplayed[index].id!,
                              type: ArtworkType.AUDIO,
                            ),
                            title: Text(
                              Recentplayed[index].songname!,
                              style: GoogleFonts.kanit(color: colorwhite),
                            ),
                            subtitle: Text(
                                Recentplayed[index].artist ?? "No Artist",
                                overflow: TextOverflow.ellipsis,
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
                                    showOptions(context);
                                  },
                                  icon: const Icon(Icons.more_vert),
                                  color: colorwhite,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showOptions(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: colorextralight,
        alignment: Alignment.bottomCenter,
        content: Container(
          height: 250,
          width: vwidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: colorblack,
                    ),
                    label: Text(
                      'Add to Favourites',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.playlist_add,
                      color: colorblack,
                    ),
                    label: Text(
                      'Add to Playlist',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: colorblack,
                    ),
                    label: Text(
                      'Share',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shuffle,
                      color: colorblack,
                    ),
                    label: Text(
                      'Shuffle',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.repeat,
                    color: colorblack,
                  ),
                  label: Text(
                    'Repeat',
                    style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
