import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class PlaylistFullList extends StatefulWidget {
  PlaylistFullList({
    super.key,
    required int this.playindex,
    required this.playlistname,
  });
  int? playindex;
  String? playlistname;
  @override
  State<PlaylistFullList> createState() => _PlaylistFullListState();
}

class _PlaylistFullListState extends State<PlaylistFullList> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> convertAudios = [];
  @override
  void initState() {
    final playbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playbox.values.toList();
    for (var item in playlistsong[widget.playindex!].playlistssongs!) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double vheight = MediaQuery.of(context).size.height;
    final playbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playbox.values.toList();
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
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: colorextralight),
                        child: IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                            size: 30,
                          ),
                          onPressed: () {
                            audioPlayer.open(
                              Playlist(audios: convertAudios, startIndex: 0),
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                              showNotification: true,
                            );
                          },
                          color: colordark,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder<Box<PlaylistSongs>>(
                  valueListenable: playbox.listenable(),
                  builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                    List<PlaylistSongs> playlistsong =
                        playlistsongs.values.toList();
                    List<Songs>? playsong =
                        playlistsong[widget.playindex!].playlistssongs;

                    return playsong!.isNotEmpty
                        ? (ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: playsong.length,
                            itemBuilder: ((context, index) => ListTile(
                                  leading: playlistsong[widget.playindex!]
                                          .playlistssongs!
                                          .isNotEmpty
                                      ? QueryArtworkWidget(
                                          keepOldArtwork: true,
                                          artworkBorder:
                                              BorderRadius.circular(10),
                                          id: playlistsong[widget.playindex!]
                                              .playlistssongs![index]
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
                                        )
                                      : ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.asset(
                                            'assets/images/music.jpeg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  title: Text(
                                    playsong[index].songname!,
                                    style: GoogleFonts.kanit(color: colorwhite),
                                  ),
                                  subtitle: Text(playsong[index].artist!,
                                      style: GoogleFonts.kanit(
                                          color: colorwhite.withOpacity(0.7),
                                          fontSize: 12)),
                                  trailing: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              playsong.removeAt(index);
                                              playlistsong
                                                  .removeAt(widget.playindex!);
                                              playbox.putAt(
                                                  widget.playindex!,
                                                  PlaylistSongs(
                                                      playlistname:
                                                          widget.playlistname!,
                                                      playlistssongs:
                                                          playsong));
                                            },
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  PlaylistFullList(
                                                      playindex:
                                                          widget.playindex!,
                                                      playlistname:
                                                          widget.playlistname),
                                              transitionDuration: Duration.zero,
                                              reverseTransitionDuration:
                                                  Duration.zero,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    audioPlayer.open(
                                      Playlist(
                                          audios: convertAudios,
                                          startIndex: index),
                                      headPhoneStrategy: HeadPhoneStrategy
                                          .pauseOnUnplugPlayOnPlug,
                                      showNotification: true,
                                    );
                                  },
                                )),
                          ))
                        : Padding(
                            padding: EdgeInsets.only(top: vheight * 0.3),
                            child: Text(
                              "Please add a song!",
                              style: GoogleFonts.kanit(color: colorwhite),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
          bottomSheet: NowPlayingSlider(),
        ),
      ),
    );
  }
}
