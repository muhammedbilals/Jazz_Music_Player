import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/functions/createplaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistFullList extends StatefulWidget {
  PlaylistFullList({super.key, required int this.playindex});
  int? playindex;
  @override
  State<PlaylistFullList> createState() => _PlaylistFullListState();
}

class _PlaylistFullListState extends State<PlaylistFullList> {
  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    final List<PlaylistModel> playlistsong1 = [];
    final playbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playbox.values.toList();
    final songbox = SongBox.getInstance();
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
                    playlistsong[widget.playindex!].playlistname!,
                    style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                  ),
                  subtitle: Text(
                    '${playlistsong[widget.playindex!].playlistssongs!.length} Songs',
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
                  valueListenable: playbox.listenable(),
                  builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                    List<PlaylistSongs> playlistsong =
                        playlistsongs.values.toList();
                    List<Songs> dbsongs = songbox.values.toList();
                    List<Songs>? playsong =
                        playlistsong[widget.playindex!].playlistssongs;
                    print(playlistsong[widget.playindex!].playlistssongs);
                    if (playlistsong == null) {
                      print('library songs  is null');
                      print(playlistsong);
                      return Center(child: Text('No songs'));
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: playsong!.length,
                        itemBuilder: ((context, index) => ListTile(
                              leading: QueryArtworkWidget(
                                keepOldArtwork: true,
                                artworkBorder: BorderRadius.circular(10),
                                id: playlistsong[widget.playindex!]
                                    .playlistssongs![index]
                                    .id!,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Image.asset(
                                    'assets/images/music.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                playsong[index].songname!,
                                // playlistsong[index]
                                //     .playlistssongs![index]
                                //     .songname!,
                                style: GoogleFonts.kanit(color: colorwhite),
                              ),
                              subtitle: Text(playsong[index].artist!,
                                  // playlistsong[index]
                                  //     .playlistssongs![index]
                                  //     .artist!,
                                  style: GoogleFonts.kanit(
                                      color: colorwhite.withOpacity(0.7),
                                      fontSize: 12)),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showPlaylistSongOptions(context, index);
                                    },
                                    icon: const Icon(Icons.more_vert),
                                    color: colorwhite,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            )),
                      );
                    }
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

showPlaylistSongOptions(BuildContext context, int index) {
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: colorextralight,
          alignment: Alignment.bottomCenter,
          content: Container(
            height: 50,
            width: vwidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextButton.icon(
                  //     onPressed: () {
                  //       if (checkFavoriteStatus(index, BuildContext)) {
                  //         addToFavourites(index);
                  //       } else if (!checkFavoriteStatus(index, BuildContext)) {
                  //         removefavourite(index);
                  //       }
                  //       setState(() {});

                  //       Navigator.pop(context);
                  //     },
                  //     icon: (checkFavoriteStatus(index, context))
                  //         ? const Icon(
                  //             Icons.favorite_border_outlined,
                  //             color: colorblack,
                  //           )
                  //         : Icon(
                  //             Icons.favorite,
                  //             color: colorblack,
                  //           ),
                  //     label: (checkFavoriteStatus(index, context))
                  //         ? Text(
                  //             'Add to Favourites',
                  //             style: GoogleFonts.kanit(
                  //                 color: colorblack, fontSize: 17),
                  //           )
                  //         : Text(
                  //             'Remove from Favourites',
                  //             style: GoogleFonts.kanit(
                  //                 color: colorblack, fontSize: 17),
                  //           )),
                  TextButton.icon(
                      onPressed: () {
                        deleteFromPlaylist(index);
                        // showPlaylistOptions(context, index);
                      },
                      icon: const Icon(
                        Icons.playlist_remove,
                        color: colorblack,
                      ),
                      label: Text(
                        'Remove from Playlist',
                        style:
                            GoogleFonts.kanit(color: colorblack, fontSize: 17),
                      )),
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.repeat,
                  //     color: colorblack,
                  //   ),
                  //   label: Text(
                  //     'Repeat',
                  //     style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
