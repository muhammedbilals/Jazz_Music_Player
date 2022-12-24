import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_screen.dart';
import 'package:music_player/screens/mainhome/widgets/now_playing_playbutton_row.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingSlider extends StatefulWidget {
  NowPlayingSlider({super.key});
  
  static int? index = 0;
  // final box = SongBox.getInstance();
  static ValueNotifier<int> enteredvalue = ValueNotifier<int>(index!);
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Songs> dbsongs = box.values.toList();

  @override
  State<NowPlayingSlider> createState() => _NowPlayingSliderState();
}

class _NowPlayingSliderState extends State<NowPlayingSlider> {
  bool istaped = true;
  bool _isplaying = true;
  List<Songs> dbsongs = box.values.toList();
  @override
  Widget build(BuildContext context) {
    void initState() {
      // TODO: implement initState
      List<Songs> allDbdongs = box.values.toList();

      super.initState();
    }

    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
        valueListenable: NowPlayingSlider.enteredvalue,
        builder: (BuildContext context, int value, child) {
          print(' entered value index is ===$value');
          return ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: ((context, Box<Songs> allsongbox, child) {
              List<Songs> allDbdongs = allsongbox.values.toList();
              // List<MostPlayed> allmostplayedsongs = mostplayedsongs.values.toList();
              if (allDbdongs.isEmpty) {
                print('no songs in slider db');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlayingScreen(
                            index: value,
                          ),
                        ));
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
                          id: allDbdongs[value].id!,
                          type: ArtworkType.AUDIO,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: vwidth * 0.5,
                              child: Text(
                                allDbdongs[value].songname!,
                                style: GoogleFonts.kanit(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              allDbdongs[value].artist ?? "No Artist",
                              style: GoogleFonts.kanit(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: vwidth * 0.01),
                          child: Wrap(
                            spacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colordark),
                                  child: IconButton(
                                    icon: Icon(
                                      (istaped)
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      color: colorwhite,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      playsong(value);
                                      setState(() {
                                        istaped = !istaped;
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
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.skip_next,
                                    color: colorwhite,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }

  void playsong(int value) async {
    await widget._audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(widget.dbsongs[value].songurl!)));
    if (_isplaying) {
      widget._audioPlayer.play();
      
    } else {
      widget._audioPlayer.pause();
    }
  }
}
