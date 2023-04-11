import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/logic/recentlyplayed/recentlyplayed_bloc.dart';
import 'package:music_player/model/recentlyplayed.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
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
    double vheight = MediaQuery.of(context).size.height;
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
                BlocBuilder<RecentlyplayedBloc, RecentlyplayedState>(
                  builder: (context, state) {
                    if (state is RecentlyplayedInitial) {
                      context
                          .read<RecentlyplayedBloc>()
                          .add(FetchRecentlyPlayed());
                    }
                    if (state is DisplayRecentlyPlayed) {
                      // if (state.recentPlay.isNotEmpty) {
                        return ListView.builder(
                          // reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.recentPlay.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, left: 5),
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  keepOldArtwork: true,
                                  artworkBorder: BorderRadius.circular(10),
                                  id: state.recentPlay[index].id!,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/music.jpeg',
                                      height: vheight * 0.06,
                                      width: vheight * 0.06,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  state.recentPlay[index].songname!,
                                  style: GoogleFonts.kanit(color: colorwhite),
                                ),
                                subtitle: Text(
                                    state.recentPlay[index].artist ??
                                        "No Artist",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.kanit(
                                        color: colorwhite.withOpacity(0.7),
                                        fontSize: 12)),
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
                      // } else {
                      //   Padding(
                      //     padding: EdgeInsets.only(top: vheight * 0.3),
                      //     child: Text(
                      //       "You Have't played any songs",
                      //       style: GoogleFonts.kanit(color: colorwhite),
                      //     ),
                      //   );
                      // }
                    }
                    return Text('data');
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
