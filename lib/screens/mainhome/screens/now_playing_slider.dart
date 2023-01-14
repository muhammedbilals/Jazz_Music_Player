import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/recentlyplayed.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_screen.dart';
import 'package:music_player/screens/splash.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class NowPlayingSlider extends StatefulWidget {
  NowPlayingSlider({super.key});

  static int? index = 0;
  static ValueNotifier<int> enteredvalue = ValueNotifier<int>(index!);
  List<Songs> dbsongs = box.values.toList();

  @override
  State<NowPlayingSlider> createState() => _NowPlayingSliderState();
}

class _NowPlayingSliderState extends State<NowPlayingSlider> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  // bool istaped = false;

  List<Songs> dbsongs = box.values.toList();
  List<Audio> convertAudios = [];

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;

    return audioPlayer.builderCurrent(
      builder: (context, playing) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NowPlayingScreen(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: colorextralight,
                  borderRadius: BorderRadius.circular(20)),
              width: vwidth,
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QueryArtworkWidget(
                    quality: 100,
                    artworkWidth: vwidth * 0.16,
                    artworkHeight: vheight * 0.16,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(10),
                    id: int.parse(playing.audio.audio.metas.id!),
                    type: ArtworkType.AUDIO,
                    // nullArtworkWidget: ClipRRect(
                    //     borderRadius: BorderRadius.circular(10),
                    //     child: Image.asset(
                    //       'assets/images/music.jpeg',
                    //       height: vheight * 0.16,
                    //       width: vheight * 0.16,
                    //     ),
                    //   ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: vwidth * 0.4,
                        child: Text(
                          // allDbdongs[value].songname!,
                          audioPlayer.getCurrentAudioTitle,
                          style: GoogleFonts.kanit(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: vwidth * 0.4,
                        child: Text(
                          // allDbdongs[value].artist ?? "No Artist",
                          audioPlayer.getCurrentAudioArtist,
                          style: GoogleFonts.kanit(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  PlayerBuilder.isPlaying(
                    player: audioPlayer,
                    builder: ((context, isPlaying) {
                      return Padding(
                        padding: EdgeInsets.only(right: vwidth * 0.01),
                        child: Wrap(
                          spacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: colordark),
                              child: IconButton(
                                onPressed: () async {
                                  await audioPlayer.previous();
                                },
                                icon: const Icon(
                                  Icons.skip_previous,
                                  color: colorwhite,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: colordark),
                                child: IconButton(
                                  icon: Icon(
                                    (isPlaying)
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: colorwhite,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    await audioPlayer.playOrPause();

                                    // playsong(value);
                                    setState(() {
                                      isPlaying = !isPlaying;
                                    });
                                  },
                                )),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: colordark),
                              child: IconButton(
                                onPressed: () async {
                                  await audioPlayer.next();
                                  // rsongs = RecentlyPlayed(
                                  //     id: songs.id,
                                  //     artist: songs.artist,
                                  //     duration: songs.duration,
                                  //     songname: songs.songname,
                                  //     songurl: songs.songurl);

                                  // updateRecentlyPlayed(rsongs);
                                },
                                icon: const Icon(
                                  Icons.skip_next,
                                  color: colorwhite,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
