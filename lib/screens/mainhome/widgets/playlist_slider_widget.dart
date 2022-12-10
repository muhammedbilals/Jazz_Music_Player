import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';

class PlaylistSlider extends StatelessWidget {
  PlaylistSlider({super.key});
  List<String> playlist = [
    'Dunes',
    'Hans Zimmer Hits',
    'Dark Knight Rises',
    'Tame Impala'
  ];
  List<String> Playlistimage = [
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 160,
            /////////////////////
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: playlist.length,
                // physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) => Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(Playlistimage[index])),
                          ),
                        ),
                        Text(
                          playlist[index],
                          style: GoogleFonts.kanit(
                              fontSize: 15,
                              color: colorwhite.withOpacity(0.5)),
                        )
                      ],
                    ))),
          ),
        )
      ],
    );
  }
}
