import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/Liked_songs_list.dart';
import 'package:music_player/screens/mainhome/screens/recentlyplayedscreen.dart';
import 'package:music_player/screens/mainhome/screens/most_played.dart';
import 'package:music_player/screens/mainhome/screens/playlist_list_screen.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  CardWidget(
      {super.key,
      required this.cardicon,
      required this.cardtext,
      required this.index});
  IconData? cardicon;
  String? cardtext;
  int index;
  //  Function navbutton();
  List screens = [
    LikedSongsList(),
    PlayListScreen(),
    RecentlyPlayedScreen(),
    MostPlayedScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(vwidth * 0.02),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => screens[index]),
            ),
          );
        },
        child: Container(
          height: 55,
          width: vwidth * 0.45,
          decoration: BoxDecoration(
              color: colorextralight, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: vwidth * 0.02, right: vwidth * 0.02),
                child: Icon(cardicon),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: vwidth * 0.02, right: vwidth * 0.02),
                child: SizedBox(
                  width: vwidth * 0.30,
                  child: Text(
                    cardtext.toString(),
                    style: GoogleFonts.kanit(fontSize: 19),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
