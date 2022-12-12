import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/libraryScreen/widgets/albums_list_widget.dart';
import 'package:music_player/screens/libraryScreen/widgets/library_list_widget.dart';
import 'package:music_player/screens/libraryScreen/widgets/see_more_widget.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colordark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colordark,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Your Library',
                        style: GoogleFonts.kanit(fontSize: 40, color: colorwhite),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.library_music_outlined,
                          color: colorwhite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Your Playlists',
                            style: GoogleFonts.kanit(
                                fontSize: 20, color: colorwhite)),
                      )
                    ],
                  ),
                ),
                LibraryList(),
                const SeeMoreWidget(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.album_outlined,
                          color: colorwhite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Albums',
                            style: GoogleFonts.kanit(
                                fontSize: 20, color: colorwhite)),
                      ),
                    ],
                  ),
                ),
                AlbumsListWidget(),
                const SeeMoreWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
