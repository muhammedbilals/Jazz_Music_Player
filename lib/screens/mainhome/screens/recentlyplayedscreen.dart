import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/recentlyplayed.dart';
import 'package:music_player/screens/mainhome/functions/addToFavourites.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:music_player/screens/mainhome/screens/playlist_list_screen.dart';
import 'package:music_player/screens/mainhome/widgets/all_songs_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  final _audioPlayer = AssetsAudioPlayer.withId('0');
  
  final List<RecentlyPlayed> recentplay = [];
  final box = RecentlyPlayedBox.getInstance();
  List<Audio> rcentplay = [];
  @override
  void initState() {
    // TODO: implement initState
    final List<RecentlyPlayed> recentlyplayed =
        box.values.toList().reversed.toList();
    for (var item in recentlyplayed) {
      rcentplay.add(
        Audio.file(
          item.songurl.toString(),
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
      setState(() {});
    }
    super.initState();
  }

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
                    'Recently Played',
                    style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                  ),
                  subtitle: Text(
                    '${rcentplay.length} Songs',
                    style: GoogleFonts.kanit(
                        fontSize: 14, color: colorwhite.withOpacity(0.7)),
                  ),
                  trailing: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: colorextralight),
                    child: IconButton(
                      onPressed: () {
                        _audioPlayer.open(
                            Playlist(audios: rcentplay, startIndex: 0),
                            showNotification: true,
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            loopMode: LoopMode.playlist);
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: colordark,
                        size: 30,
                      ),
                    ),
                  ),
                ),

                // Icon(Icons.play_arrow)

                ValueListenableBuilder<Box<RecentlyPlayed>>(
                  valueListenable: box.listenable(),
                  builder: ((context, Box<RecentlyPlayed> RecentDB, child) {
                    List<RecentlyPlayed> Recentplayed =
                        RecentDB.values.toList().reversed.toList();
                    return ListView.builder(
                      // reverse: true,
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
                                // IconButton(
                                //     onPressed: () {
                                //       // if (checkFavoriteStatus(
                                //       //     index, BuildContext)) {
                                //       //   addToFavourites(index);
                                //       //   // addToFavorites1(songindex, favourites, context);
                                //       // } else if (!checkFavoriteStatus(
                                //       //     index, BuildContext)) {
                                //       //   removefavourite(index);
                                //       // }
                                //       // setState(
                                //       //   () {

                                //       //   },
                                //       // );
                                //     },
                                //     icon: Icon(Icons.favorite,
                                //         color: (checkFavoriteStatus(
                                //                 index, BuildContext))
                                //             ? Color.fromARGB(255, 85, 85, 85)
                                //             : Color.fromARGB(
                                //                 255, 255, 255, 255))),
                                // IconButton(
                                //   onPressed: () {
                                //     showRecentOptions(context, index);
                                //   },
                                //   icon: const Icon(Icons.more_vert),
                                //   color: colorwhite,
                                // ),
                              ],
                            ),
                            onTap: () {
                              _audioPlayer.open(
                                  Playlist(
                                      audios: rcentplay, startIndex: index),
                                  showNotification: true,
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplug,
                                  loopMode: LoopMode.playlist);
                            },
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
          ),
          bottomSheet: NowPlayingSlider(),
        ),
      ),
    );
  }
//   showRecentOptions(BuildContext context, int index) {
//   double vwidth = MediaQuery.of(context).size.width;
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (context, setState) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           insetPadding: EdgeInsets.zero,
//           contentPadding: EdgeInsets.zero,
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           backgroundColor: colorextralight,
//           alignment: Alignment.bottomCenter,
//           content: Container(
//             height: 150,
//             width: vwidth,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextButton.icon(
//                       onPressed: () {
//                         if (checkFavoriteStatus(index, BuildContext)) {
//                           addToFavourites(index);
//                         } else if (!checkFavoriteStatus(index, BuildContext)) {
//                           removefavourite(index);
//                         }
//                         setState(() {});

//                         Navigator.pop(context);
//                       },
//                       icon: (checkFavoriteStatus(index, context))
//                           ? const Icon(
//                               Icons.favorite_border_outlined,
//                               color: colorblack,
//                             )
//                           : Icon(
//                               Icons.favorite,
//                               color: colorblack,
//                             ),
//                       label: (checkFavoriteStatus(index, context))
//                           ? Text(
//                               'Add to Favourites',
//                               style: GoogleFonts.kanit(
//                                   color: colorblack, fontSize: 17),
//                             )
//                           : Text(
//                               'Remove from Favourites',
//                               style: GoogleFonts.kanit(
//                                   color: colorblack, fontSize: 17),
//                             )),
//                   TextButton.icon(
//                       onPressed: () {

//                       },
//                       icon: const Icon(
//                         Icons.playlist_add,
//                         color: colorblack,
//                       ),
//                       label: Text(
//                         'Add to Playlist',
//                         style:
//                             GoogleFonts.kanit(color: colorblack, fontSize: 17),
//                       )),
//                   TextButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.repeat,
//                       color: colorblack,
//                     ),
//                     label: Text(
//                       'Repeat',
//                       style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
}
