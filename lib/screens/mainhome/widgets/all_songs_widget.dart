import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_screen.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AllSongsWidget extends StatefulWidget {
  const AllSongsWidget({super.key});

  @override
  State<AllSongsWidget> createState() => _AllSongsWidgetState();
}

class _AllSongsWidgetState extends State<AllSongsWidget> {
  bool istaped = true;

  List<String> songs = [
    'Hans Zimmer - The Classics ',
    'Dune sound track',
    'evantually',
    'Dark Knight Theme song',
    'Gladiator Sound track',
    'Top Gun: Maverick Soundtrack',
    'There He Is Song The Amazing Spider-Man 2',
    'Hans Zimmer - Interstellar',
    'Hans Zimmer - The Classics ',
    'Dune sound track',
    'evantually',
    'Dark Knight Theme song',
    'Gladiator Sound track',
    'Top Gun: Maverick Soundtrack',
    'There He Is Song The Amazing Spider-Man 2',
    'Hans Zimmer - Interstellar',
  ];

  List<String> author = [
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
  ];

  List<String> songimage = [
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
  ];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
              child: Text('All Songs',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite)),
            )
          ],
        ),
        ///////////////////
        FutureBuilder(
            // Default values:
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              // Loading content
              if (item.data == null) return const CircularProgressIndicator();

              // When you try "query" without asking for [READ] or [Library] permission
              // the plugin will return a [Empty] list.
              if (item.data!.isEmpty) return const Text("Nothing found!");

              // You can use [item.data!] direct or you can create a:
              // List<SongModel> songs = item.data!;
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: item.data!.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NowPlayingScreen(index: index),
                              ));
                          NowPlayingSlider(index: index);
                          print(index);
                        },
                        leading: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(10),
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                        ),
                        title: Text(
                          item.data![index].title,
                          style: GoogleFonts.kanit(color: colorwhite),
                        ),
                        subtitle: Text(item.data![index].artist ?? "No Artist",
                            style: GoogleFonts.kanit(
                                color: colorwhite.withOpacity(0.7),
                                fontSize: 12)),
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
                                        ? const Color.fromARGB(
                                            255, 121, 121, 121)
                                        : const Color.fromARGB(
                                            255, 255, 0, 0))),
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
            }),
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
