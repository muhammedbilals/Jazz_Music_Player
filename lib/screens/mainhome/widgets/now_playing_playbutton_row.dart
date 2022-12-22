import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';

class NowPlayingPlayButtonRow extends StatefulWidget {
  NowPlayingPlayButtonRow({
    super.key,
    required int this.index,
    required this.audioPlayer
  });
  int? index;
  final AudioPlayer audioPlayer;

  List<Songs> dbsongs = box.values.toList();
  @override
  State<NowPlayingPlayButtonRow> createState() =>
      _NowPlayingPlayButtonRowState();
}

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
                      print(widget.index);
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
                        setState(() {
                          widget.index! + 1;
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
    await widget.audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(widget.dbsongs[widget.index!].songurl!)));
    if (_isplaying) {
       widget.audioPlayer.play();
    } else {
       widget.audioPlayer.pause();
    }
    // _isplaying = true;
  }
}
