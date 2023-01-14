import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/widgets/popup.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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
              ListTile(
                onTap: () {
                  Share.share(
                      "https://github.com/muhammedbilals/Jazz_Music_Player",
                      subject: "Github Repo Of This App");
                },
                leading: Icon(
                  Icons.share,
                  color: colorwhite,
                ),
                title: Text(
                  'Share',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return settingmenupopup(mdFilename: 'privacypolicy.md');
                    },
                  );
                },
                leading: Icon(
                  Icons.shield,
                  color: colorwhite,
                ),
                title: Text(
                  'Privacy Policy',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return settingmenupopup(
                            mdFilename: 'termsandconditons.md');
                      });
                },
                leading: Icon(
                  Icons.gavel,
                  color: colorwhite,
                ),
                title: Text(
                  'Terms and Conditions',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                ),
              ),
              ListTile(
                onTap: () {
                  showAboutDialog(
                      context: context,
                      applicationName: "Jazz Player.",
                      applicationIcon: Image.asset(
                        "assets/images/jazzlogo.png",
                        height: 32,
                        width: 32,
                      ),
                      applicationVersion: "1.0.0",
                      children: [
                        const Text(
                            "Jazz is an offline music player app which allows use to hear music from their local storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("App developed by Muhammed Bilal S.")
                      ]);
                },
                leading: Icon(
                  Icons.info,
                  color: colorwhite,
                ),
                title: Text(
                  'About',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
