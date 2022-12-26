import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AllSongsWidget extends StatefulWidget {
  const AllSongsWidget({super.key});

  @override
  State<AllSongsWidget> createState() => _AllSongsWidgetState();
}

final OnAudioQuery _audioQuery = OnAudioQuery();
final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');

class _AllSongsWidgetState extends State<AllSongsWidget> {
  bool istaped = true;
  final box = SongBox.getInstance();
  List<Audio> convertAudios = [];

  @override
  Widget build(BuildContext context) {
    void initState() {
      // TODO: implement initState
      List<Songs> dbsongs = box.values.toList();
      for (var item in dbsongs) {
        convertAudios.add(Audio.file(item.songurl!,
            metas: Metas(
                title: item.songname,
                artist: item.artist,
                id: item.id.toString())));

        super.initState();
      }
    }

    @override
    void dispose() {
      _audioPlayer.dispose();
      print('dispose');
      super.dispose();
    }

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
              child: Text('All Songs',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite)),
            ),
          ],
        ),
        ///////////////////
        ValueListenableBuilder<Box<Songs>>(
          valueListenable: box.listenable(),
          builder: ((context, Box<Songs> allsongbox, child) {
            List<Songs> allDbsongs = allsongbox.values.toList();
            // List<MostPlayed> allmostplayedsongs = mostplayedsongs.values.toList();
            if (allDbsongs.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (allDbsongs == null) {
              print('no songs');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allDbsongs.length,
              itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                    child: ListTile(
                      onTap: () {
                        _audioPlayer.open(
                          Audio.file(allDbsongs[index].songurl!),
                        );
                        NowPlayingSlider.enteredvalue.value = index;

                        print('value notifirer passing index$index');
                        print(index);
                        print(allDbsongs[index].songname!);
                      },
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

                                print(allDbsongs[index].songname!);
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
