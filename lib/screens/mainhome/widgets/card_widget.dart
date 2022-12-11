import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';

class CardWidget extends StatelessWidget {
  CardWidget({super.key, required this.cardicon, required this.cardtext});
  IconData? cardicon;
  String? cardtext;
  //  Function navbutton();
  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        // onTap: () =>navbutton() ,
        child: Container(
          
          height: 55,
          width:vwidth*0.45,
          decoration: BoxDecoration(
              color: colorextralight, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [Padding(
              padding: const EdgeInsets.only(left:15.0,right: 10),
              child: Icon(cardicon),
            ), Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Text(cardtext.toString(),style: GoogleFonts.kanit(fontSize: 20),),
            )],
          ),
        ),
      ),
    );
  }
}
