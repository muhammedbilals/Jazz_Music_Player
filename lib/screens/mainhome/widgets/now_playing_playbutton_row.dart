import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_screen.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';

class NowPlayingPlayButtonRow extends StatefulWidget {
  NowPlayingPlayButtonRow({super.key, required this.audioPlayer});

  // static int? index = 0;
  final AudioPlayer audioPlayer;
  // static ValueNotifier<int> buttonvalue = ValueNotifier(index!);

  List<Songs> dbsongs = box.values.toList();
  @override
  State<NowPlayingPlayButtonRow> createState() =>
      _NowPlayingPlayButtonRowState();
}

Duration _duration = Duration();
Duration _position = Duration();
bool _isplaying = false;
final box = SongBox.getInstance();

class _NowPlayingPlayButtonRowState extends State<NowPlayingPlayButtonRow> {
  bool istaped = true;

  @override
  Widget build(BuildContext context) {
    void initState() {
      // TODO: implement initState
      playsong();
      super.initState();
    }

    return Column(
      children: [
        Slider(
          min: Duration(microseconds: 0).inSeconds.toDouble(),
          value: _position.inSeconds.toDouble(),
          max: _duration.inSeconds.toDouble(),
          onChanged: (value) {
            setState(() {
              changeToSeconds(value.toInt());
              value = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // _value.toString(),
                _position.toString().split('.')[0],
                style: GoogleFonts.kanit(
                    fontSize: 15, color: colorwhite.withOpacity(0.7)),
              ),
              Text(
                // (_value.toString()),
                _duration.toString().split(".")[0],
                style: GoogleFonts.kanit(
                    fontSize: 15, color: colorwhite.withOpacity(0.7)),
              )
            ],
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                      onPressed: () {},
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
                      borderRadius: BorderRadius.circular(35)),
                  child: IconButton(
                    onPressed: () {
                      playsong();
                      print('now playing slider inde${NowPlayingSlider.index}');
                      setState(() {
                        _isplaying = !_isplaying;
                      });
                    },
                    icon: (_isplaying)
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
                      borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                      onPressed: () {
                        skipMusic(_isplaying, widget.audioPlayer,
                            NowPlayingSlider.index!);
                        setState(() {
                          NowPlayingSlider.index! + 1;
                        });
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: colorblack,
                      )),
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
        ),
        Row(
          children: const [],
        )
      ],
    );
  }

  void playsong() async {
    await widget.audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.dbsongs[NowPlayingSlider.index!].songurl!)));
    if (_isplaying) {
      widget.audioPlayer.play();
    } else {
      widget.audioPlayer.pause();
    }
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
    // _isplaying = true;
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }

  skipMusic(bool isPlaying, AudioPlayer audioplayer, int index) async {
    if (!isPlaying) {
      await audioplayer.stop();
    }

    index++;
    await widget.audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.dbsongs[NowPlayingSlider.index!].songurl!)));
    setState(() {
      NowPlayingSlider.enteredvalue.value++;
    });
  }

  previousMusic(bool isPlaying, AudioPlayer player, List<Songs> dbsongs,
      int index) async {
    if (!isPlaying) {
      await player.seekToPrevious();
    }

    index--;
    NowPlayingSlider.enteredvalue.value--;
    // HomeBottomTile.vindex.value--;

    await widget.audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.dbsongs[NowPlayingSlider.index!].songurl!)));

    // HomeBottomTile.vindex.value--;
  }
}
