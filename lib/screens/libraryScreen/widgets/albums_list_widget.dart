import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';

class AlbumsListWidget extends StatelessWidget {
  AlbumsListWidget({super.key});
  List<String> songimage = [
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
  ];
  // List<String> author = [
  //   'Album',
  //   'Album',
  //   'Album',
  // ];
  List<String> songs = [
    'Interstellar',
    'Hans Zimmer',
    'Currents',
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: songs.length,
      shrinkWrap: true,
      
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, index) => GridTile(
        
        child: Image.asset(songimage[index]),
        footer: Text(songs[index]),
      ),
      // itemCount: 4,
    );
  }
}
