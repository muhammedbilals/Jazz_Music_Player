import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/widgets/now_playing_playbutton_row.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingScreen extends StatefulWidget {
  NowPlayingScreen({super.key, this.index});
  int? index;
  List<Songs>? songs;

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  double _value = 6;
  final box = SongBox.getInstance();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;

    void initState() {
      // TODO: implement initState
      List<Songs> dbsongs = box.values.toList();

      super.initState();
    }

    if (widget.index == null) {
      print('index is null');
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: colordark,
        body: Column(
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
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Text(
                    'Now Playing',
                    style: GoogleFonts.kanit(fontSize: 40, color: colorwhite),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
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
                return Column(
                  children: [
                    QueryArtworkWidget(
                      // quality: 100,
                      artworkQuality: FilterQuality.high,
                      artworkHeight: vheight * 0.44,
                      artworkWidth: vheight * 0.44,
                      artworkBorder: BorderRadius.circular(10),
                      artworkFit: BoxFit.cover,
                      id: allDbdongs[widget.index!].id!,
                      type: ArtworkType.AUDIO,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                allDbdongs[widget.index!].songname!,
                                style: GoogleFonts.kanit(
                                    fontSize: 25, color: colorwhite),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                allDbdongs[widget.index!].artist!,
                                style: GoogleFonts.kanit(
                                    fontSize: 15,
                                    color: colorwhite.withOpacity(0.7)),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: colorwhite,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    
                    
                  ],
                );
              }),
            ),
            NowPlayingPlayButtonRow(
              index: widget.index!,
              audioPlayer: _audioPlayer,
            )
          ],
        ),
      ),
    );
  }
}
// extension on Duration {
//   String toHHmmss() {
//     var microseconds = inMicroseconds;

//     var hours = microseconds ~/ Duration.microsecondsPerHour;
//     microseconds = microseconds.remainder(Duration.microsecondsPerHour);

//     if (microseconds < 0) microseconds = -microseconds;

//     var minutes = microseconds ~/ Duration.microsecondsPerMinute;
//     microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

//     var minutesPadding = minutes < 10 ? "0" : "";

//     var seconds = microseconds ~/ Duration.microsecondsPerSecond;
//     microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

//     var secondsPadding = seconds < 10 ? "0" : "";

//     return "$hours:"
//         "$minutesPadding$minutes:"
//         "$secondsPadding$seconds";
//   }
// }
