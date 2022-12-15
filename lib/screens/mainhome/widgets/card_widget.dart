import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/Liked_songs_list.dart';
import 'package:music_player/screens/mainhome/screens/albums_list.dart';
import 'package:music_player/screens/mainhome/screens/most_played.dart';
import 'package:music_player/screens/mainhome/screens/playlist_list_screen.dart';

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
    AlbumsList(),
    PlayListScreen(),
    MostPlayed(),
  ];
  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => screens[index])));
        },
        child: Container(
          height: 55,
          width: vwidth * 0.45,
          decoration: BoxDecoration(
              color: colorextralight, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 10),
                child: Icon(cardicon),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Text(
                  cardtext.toString(),
                  style: GoogleFonts.kanit(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
