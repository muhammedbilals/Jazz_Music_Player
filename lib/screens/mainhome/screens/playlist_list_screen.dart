import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/libraryScreen/widgets/library_list_widget.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colordark,
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: colorextralight,
                          borderRadius: BorderRadius.circular(30)),
                      width: 40,
                      height: 40,
                      child: IconButton(
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        color: colorblack,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                'Your Playlists',
                style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
              ),
              subtitle: Text(
                '6 Playlist',
                style: GoogleFonts.kanit(
                    fontSize: 14, color: colorwhite.withOpacity(0.7)),
              ),
              trailing: Wrap(
                spacing: 10,
                children: [
                  Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: colorextralight),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: colordark,
                        iconSize: 30,
                        onPressed: () {
                          showPlaylistOptions(context);
                        },
                      )),
                     
                ],
              ),
            ),
            LibraryList(),
            LibraryList()
          ],
        ),
      ),
    );
  }
}

showPlaylistOptions(BuildContext context) {
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
    
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: colorextralight,
      alignment: Alignment.bottomCenter,
      content: Container(
        height: 250,
        width: vwidth,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Create Playlist',
                    style: GoogleFonts.kanit(fontSize: 25, color: colorblack),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: vwidth * 0.90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colorlight,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: colorlightdark,
                          label: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Enter Playlist Name:',
                              style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  color: colorblack.withOpacity(0.5)),
                            ),
                          ),
                          // alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        width: vwidth * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colorlight,
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.kanit(
                                  fontSize: 20, color: colorblack),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        width: vwidth * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colorlight,
                        ),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'continue',
                              style: GoogleFonts.kanit(
                                  fontSize: 20, color: colorblack),
                            ))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
