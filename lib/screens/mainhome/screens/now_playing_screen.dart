import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingScreen extends StatefulWidget {
  NowPlayingScreen({super.key});

  List<Songs>? songs;
  static int? indexvalue = 0;
  static ValueNotifier<int> nowplayingindex = ValueNotifier<int>(indexvalue!);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

final _audioPlayer = AssetsAudioPlayer.withId('0');

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  final box = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;
    Duration duration = Duration.zero;
    Duration position = Duration.zero;

    void initState() {
      // TODO: implement initState
      List<Songs> dbsongs = box.values.toList();

      super.initState();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: colordark,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorextralight,
                          borderRadius: BorderRadius.circular(30)),
                      width: 40,
                      height: 40,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.expand_more,
                          color: colorblack,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: vwidth * 0.17),
                    child: Text(
                      'Now Playing',
                      style: GoogleFonts.kanit(fontSize: 35, color: colorwhite),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ValueListenableBuilder(
                valueListenable: NowPlayingScreen.nowplayingindex,
                builder: (BuildContext context, int value1, child) {
                  return ValueListenableBuilder<Box<Songs>>(
                    valueListenable: box.listenable(),
                    builder: ((context, Box<Songs> allsongbox, child) {
                      List<Songs> allDbdongs = allsongbox.values.toList();

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
                      return _audioPlayer.builderCurrent(
                        builder: ((context, playing) {
                          return Column(
                            children: [
                              QueryArtworkWidget(
                                // quality: 100,
                                artworkQuality: FilterQuality.high,
                                artworkHeight: vheight * 0.44,
                                artworkWidth: vheight * 0.44,
                                artworkBorder: BorderRadius.circular(10),
                                artworkFit: BoxFit.cover,
                                id: allDbdongs[value1].id!,
                                type: ArtworkType.AUDIO,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          // player.getCurrentAudioTitle,

                                          allDbdongs[value1].songname!,
                                          style: GoogleFonts.kanit(
                                              fontSize: 25, color: colorwhite),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          // player.getCurrentAudioArtist,
                                          allDbdongs[value1].artist!,
                                          style: GoogleFonts.kanit(
                                            fontSize: 15,
                                            color: colorwhite.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_border_outlined,
                                      color: colorwhite,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  PlayerBuilder.realtimePlayingInfos(
                                    player: _audioPlayer,
                                    builder: (context, RealtimePlayingInfos) {
                                      duration = RealtimePlayingInfos
                                          .current!.audio.duration;
                                      position =
                                          RealtimePlayingInfos.currentPosition;

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: ProgressBar(
                                          baseBarColor:
                                              Colors.white.withOpacity(0.5),
                                          progressBarColor:
                                              Color.fromARGB(255, 136, 64, 64),
                                          thumbColor:
                                              Color.fromARGB(255, 24, 14, 14),
                                          thumbRadius: 5,
                                          timeLabelPadding: 5,
                                          progress: position,
                                          timeLabelTextStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          total: duration,
                                          onSeek: (duration) async {
                                            await _audioPlayer.seek(duration);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  PlayerBuilder.isPlaying(
                                    player: _audioPlayer,
                                    builder: ((context, isPlaying) {
                                      return Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.shuffle,
                                                    color: colorwhite,
                                                  )),
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: colorextralight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: IconButton(
                                                    onPressed: () {
                                                      previousSong(_audioPlayer,
                                                          value1, allDbdongs);
                                                    },
                                                    icon: const Icon(
                                                      Icons.skip_previous,
                                                      color: colorblack,
                                                    )),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    color: colorextralight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35)),
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (isPlaying) {
                                                      _audioPlayer.pause();
                                                    } else {
                                                      _audioPlayer.play();
                                                    }
                                                    setState(
                                                      () {
                                                        isPlaying = !isPlaying;
                                                      },
                                                    );
                                                  },
                                                  icon: (isPlaying)
                                                      ? Icon(Icons.pause)
                                                      : Icon(
                                                          Icons.play_arrow,
                                                          color: colorblack,
                                                          size: 35,
                                                        ),
                                                ),
                                              ),
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: colorextralight,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    skipMusic(_audioPlayer,
                                                        value1, allDbdongs);
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.skip_next,
                                                    color: colorblack,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.repeat,
                                                  color: colorwhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void skipMusic(AssetsAudioPlayer assetsAudioPlayer, int index,
      List<Songs> dbsongs) async {
    _audioPlayer.open(
      Audio.file(dbsongs[index + 1].songurl!),
    );
    // await _audioPlayer.next();
    setState(() {
      NowPlayingScreen.nowplayingindex.value++;
    });
    await _audioPlayer.stop();
  }

  void previousSong(AssetsAudioPlayer assetsAudioPlayer, int index,
      List<Songs> dbsongs) async {
    _audioPlayer.open(
      Audio.file(dbsongs[index - 1].songurl!),
    );
    // await _audioPlayer.next();
    setState(() {
      NowPlayingScreen.nowplayingindex.value--;
    });
    await _audioPlayer.stop();
  }
}
