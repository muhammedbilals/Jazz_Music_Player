import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchSongList extends StatefulWidget {
  const SearchSongList({super.key});

  @override
  State<SearchSongList> createState() => _SearchSongListState();
}

class _SearchSongListState extends State<SearchSongList> {
  bool istaped = true;
  final songbox = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///////////////////
        ValueListenableBuilder<Box<Songs>>(
          valueListenable: songbox.listenable(),
          builder: (context, Box<Songs> allsongs, child) {
            List<Songs> allDbsongs = songbox.values.toList();
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allDbsongs.length,
              itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                    child: ListTile(
                      leading: QueryArtworkWidget(
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(10),
                      id: allDbsongs[index].id!,
                      type: ArtworkType.AUDIO,
                    ),
                      title: Text(
                      allDbsongs[index].songname!,
                      style: GoogleFonts.kanit(color: colorwhite),
                    ),
                    subtitle: Text(allDbsongs[index].artist ?? "No Artist",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.kanit(
                            color: colorwhite.withOpacity(0.7), fontSize: 12)),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  istaped = !istaped;
                                });
                              },
                              icon: Icon(Icons.favorite,
                                  color: (istaped)
                                      ? const Color.fromARGB(255, 121, 121, 121)
                                      : const Color.fromARGB(255, 255, 0, 0))),
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
                  )),
            );
          },
        ),
      ],
    );
  }

//   Widget? iconfav() {
//     if (istaped = true) {
//       return Icon(Icons.favorite_border_outlined);
//     } else {
//       return Icon(Icons.favorite_border_outlined);
//     }
//   }

//   Widget? istapeda() {
//     if (istaped = true) return Icon(Icons.favorite_border_outlined);
//     return Icon(Icons.favorite);
//   }
// }

// Widget lovebuttonoutline() {
//   return Icon(Icons.favorite);
// }

// Widget lovebuttonfilled() {
//   return Icon(Icons.favorite_border_outlined);
// }

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
