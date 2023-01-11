import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/functions/addToFavourites.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingScreen extends StatefulWidget {
  NowPlayingScreen({super.key});

  List<Songs>? songs;
  static int? indexvalue = 0;
  static ValueNotifier<int> nowplayingindex = ValueNotifier<int>(indexvalue!);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  final _audioPlayer = AssetsAudioPlayer.withId('0');
  final box = SongBox.getInstance();
  bool isRepeat = false;
  bool isShuffleOn = false;

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
                                size: 3000,
                                quality: 100,
                                artworkQuality: FilterQuality.high,
                                artworkHeight: vheight * 0.44,
                                artworkWidth: vheight * 0.44,
                                artworkBorder: BorderRadius.circular(10),
                                artworkFit: BoxFit.cover,
                                id: int.parse(playing.audio.audio.metas.id!),
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/music.jpeg',
                                    height: vheight * 0.44,
                                    width: vheight * 0.44,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: vwidth * 0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: vwidth * 0.03,
                                              right: vwidth * 0.03),
                                          child: Text(
                                            _audioPlayer.getCurrentAudioTitle,
                                            // allDbdongs[value1].songname!,
                                            style: GoogleFonts.kanit(
                                                fontSize: 25,
                                                color: colorwhite),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            _audioPlayer.getCurrentAudioArtist,
                                            // allDbdongs[value1].artist!,
                                            style: GoogleFonts.kanit(
                                              fontSize: 15,
                                              color:
                                                  colorwhite.withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (checkFavoriteStatus(
                                          playing.index, BuildContext)) {
                                        addToFavourites(playing.index);
                                      } else if (!checkFavoriteStatus(
                                          playing.index, BuildContext)) {
                                        removefavourite(playing.index);
                                      }
                                      setState(() {
                                        checkFavoriteStatus(
                                                playing.index, BuildContext) ==
                                            !checkFavoriteStatus(
                                                playing.index, BuildContext);
                                      });
                                    },
                                    icon: (checkFavoriteStatus(
                                            playing.index, BuildContext))
                                        ? const Icon(
                                            Icons.favorite_border_outlined,
                                            color: colorwhite,
                                          )
                                        : const Icon(
                                            Icons.favorite,
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
                                              const Color.fromARGB(
                                                  255, 136, 64, 64),
                                          thumbColor: const Color.fromARGB(
                                              255, 24, 14, 14),
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
                                                  onPressed: () {
                                                    setState(() {});
                                                    audioPlayer.toggleShuffle();
                                                  },
                                                  icon: (isShuffleOn)
                                                      ? const Icon(
                                                          Icons.shuffle,
                                                          color: colorwhite,
                                                        )
                                                      : const Icon(
                                                          Icons.shuffle_rounded,
                                                          color: colorwhite)),
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: colorextralight,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    // previousSong(_audioPlayer,
                                                    //     value1, allDbdongs);
                                                    await audioPlayer
                                                        .previous();
                                                  },
                                                  icon: const Icon(
                                                    Icons.skip_previous,
                                                    color: colorblack,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: colorextralight,
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                ),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    if (isPlaying) {
                                                      await _audioPlayer
                                                          .pause();
                                                    } else {
                                                      await _audioPlayer.play();
                                                    }
                                                    setState(
                                                      () {
                                                        isPlaying = !isPlaying;
                                                      },
                                                    );
                                                  },
                                                  icon: (isPlaying)
                                                      ? const Icon(Icons.pause)
                                                      : const Icon(
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
                                                  onPressed: () async {
                                                    // skipMusic(_audioPlayer,
                                                    //     value1, allDbdongs);
                                                    await audioPlayer.next();
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.skip_next,
                                                    color: colorblack,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isRepeat) {
                                                        audioPlayer.setLoopMode(
                                                            LoopMode.none);
                                                        isRepeat = false;
                                                      } else {
                                                        audioPlayer.setLoopMode(
                                                            LoopMode.single);
                                                        isRepeat = true;
                                                      }
                                                    });
                                                  },
                                                  icon: (isRepeat)
                                                      ? const Icon(
                                                          Icons
                                                              .repeat_one_outlined,
                                                          color: colorwhite,
                                                        )
                                                      : const Icon(Icons.repeat,
                                                          color: colorwhite)),
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
}
//   void skipMusic(AssetsAudioPlayer assetsAudioPlayer, int index,
//       List<Songs> dbsongs) async {
//     _audioPlayer.open(
//       Audio.file(dbsongs[index + 1].songurl!),
//     );
//     // await _audioPlayer.next();
//     setState(() {
//       NowPlayingScreen.nowplayingindex.value++;
//     });
//     await _audioPlayer.stop();
//   }

//   void previousSong(AssetsAudioPlayer assetsAudioPlayer, int index,
//       List<Songs> dbsongs) async {
//     _audioPlayer.open(
//       Audio.file(dbsongs[index - 1].songurl!),
//     );
//     // await _audioPlayer.next();
//     setState(() {
//       NowPlayingScreen.nowplayingindex.value--;
//     });
//     await _audioPlayer.stop();
//   }
// }
