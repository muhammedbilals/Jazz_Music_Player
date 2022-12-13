import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';

import '../../mainhome/screens/playlist_list_screen.dart';

class SeeMoreWidget extends StatelessWidget {
  const SeeMoreWidget({super.key});
  // final Widget? passfunction;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorextralight,
      ),
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) =>
          
            PlayListScreen()
          )));
        },
        icon: Icon(
          Icons.expand_more,
          color: colorblack,
        ),
        label: Text(
          'See More',
          style: GoogleFonts.kanit(color: colorblack, fontSize: 16),
        ),
      ),
    );
  }
}
