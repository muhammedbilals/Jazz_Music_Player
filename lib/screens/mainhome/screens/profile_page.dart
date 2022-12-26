import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  List<IconData> icon = [
    Icons.notifications,
    Icons.share,
    Icons.shield,
    Icons.gavel,
    Icons.info
  ];
  List profilelist = [
    'Notifications',
    'Share',
    'Privacy Policy',
    'Terms & conditions',
    'About',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colordark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colordark,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Your Profile',
                  style: GoogleFonts.kanit(fontSize: 40, color: colorwhite),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profilelist.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                      child: ListTile(
                        leading: Icon(
                          icon[index],
                          color: colorwhite,
                        ),
                        title: Text(
                          profilelist[index],
                          style:
                              GoogleFonts.kanit(color: colorwhite, fontSize: 20),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
