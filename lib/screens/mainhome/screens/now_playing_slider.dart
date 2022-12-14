import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_screen.dart';

class NowPlayingSlider extends StatelessWidget {
  const NowPlayingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        // onVerticalDragDown: (details) {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: ((context) => NowPlayingScreen())));

        // },
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const NowPlayingScreen())));
        },
        child: Container(
          decoration: BoxDecoration(
              color: colorextralight, borderRadius: BorderRadius.circular(20)),
          width: vwidth,
          height: 65,
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                      'assets/images/tame-impala-eventually-1400px_800.jpg')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New person Same Old Mistakes',
                      style: GoogleFonts.kanit(fontSize: 18),
                    ),
                    Text('Tame Impala', style: GoogleFonts.kanit(fontSize: 13)),
                  ],
                ),
              ),
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: colordark),
                  child: IconButton(
                    icon: const Icon(
                      Icons.play_arrow,
                      color: colorwhite,
                      size: 30,
                    ),
                    onPressed: () {},
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
