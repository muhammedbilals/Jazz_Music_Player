import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/colors/colors.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colordark,
        body: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                            decoration: BoxDecoration(
                                color: colorextralight,
                                borderRadius: BorderRadius.circular(30)),
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: colorblack,
                              size: 25,
                            )),
                      ),
      ),
    );
  }
}