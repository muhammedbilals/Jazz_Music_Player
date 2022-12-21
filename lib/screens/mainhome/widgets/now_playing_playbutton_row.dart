import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';

class NowPlayingPlayButtonRow extends StatefulWidget {
  const NowPlayingPlayButtonRow({super.key});

  @override
  State<NowPlayingPlayButtonRow> createState() =>
      _NowPlayingPlayButtonRowState();
}

class _NowPlayingPlayButtonRowState extends State<NowPlayingPlayButtonRow> {
  bool istaped = true;
  @override
  Widget build(BuildContext context) {
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
                        setState(() {
                                  istaped = !istaped;
                                });
                      },
                      icon: (istaped)?Icon(Icons.play_arrow):Icon(Icons.pause,
                        color: colorblack,
                        size: 35,
                      )),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorextralight,
                      borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                      onPressed: () {},
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
                    )),
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
}
