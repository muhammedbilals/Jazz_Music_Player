import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
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
  final box = SongBox.getInstance();

  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // playSong(String uri) {
  //   _audioPlayer.setAudioSource(AudioSource.uri(uri.parse(uri)));
  // }

  @override
  Widget build(BuildContext context) {
    void initState() {
      // TODO: implement initState
      List<Songs> dbsongs = box.values.toList();

      super.initState();
    }

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
        ValueListenableBuilder<Box<Songs>>(
          valueListenable: box.listenable(),
          builder: ((context, Box<Songs> allsongbox, child) {
            List<Songs> allDbdongs = allsongbox.values.toList();
            // List<MostPlayed> allmostplayedsongs = mostplayedsongs.values.toList();
            if (allDbdongs.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (allDbdongs == null) {
              print('no songs');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allDbdongs.length,
              itemBuilder: ((context,int  index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlayingScreen(
                                  index: index, songs: allDbdongs),
                            ));
                        // NowPlayingSlider(index: index);
                        print(index);
                        print(allDbdongs[index].songname!);
                      },
                      leading: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(10),
                        id: allDbdongs[index].id!,
                        type: ArtworkType.AUDIO,
                      ),
                      title: Text(
                        allDbdongs[index].songname!,
                        style: GoogleFonts.kanit(color: colorwhite),
                      ),
                      subtitle: Text(allDbdongs[index].artist ?? "No Artist",
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

                                print(allDbdongs[index].songname!);
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
          }),
        )
      ],
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
//   playMusic() async {
//     if (!pauseplay) {
//       await player.setAudioSource(AudioSource.uri(Uri.parse(widget.songs!.songurl!)));
//       player.play();
//     } else {
//       player.pause();
// }
// }
}
