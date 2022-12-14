import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/playlist_full_lsit.dart';

class LibraryList extends StatelessWidget {
  LibraryList({super.key});
  List<String> songimage = [
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
  ];
  List<String> author = [
    'Playlist',
    'Playlist',
    'Playlist',
  ];
  List<String> songs = [
    'Fav Songs',
    'Hans Zimmer Fav',
    'Imapala Fav',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: songs.length,
      itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistFullList(),
                    ));
              },
              leading: ClipRRect(
                  child: Image.asset(
                songimage[index],
              )),
              title: Text(
                songs[index],
                style: GoogleFonts.kanit(color: colorwhite, fontSize: 25),
              ),
              subtitle: Text(author[index],
                  style: GoogleFonts.kanit(
                      color: colorwhite.withOpacity(0.7), fontSize: 15)),
              trailing: Wrap(children: [
                IconButton(
                    onPressed: () {
                      showPlaylistOptions(context);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: colorwhite,
                    )),
                IconButton(
                    onPressed: () {
                      playlistDeleteOption(context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: colorwhite,
                    ))
              ]),
            ),
          )),
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
                        child: TextButton.icon(
                            icon: const Icon(
                              Icons.close,
                              color: colorblack,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: Text(
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
                        child: TextButton.icon(
                            icon: const Icon(
                              Icons.done,
                              color: colorblack,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: Text(
                              'Done',
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

playlistDeleteOption(BuildContext context) {
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
                    'Delete Playlist',
                    style: GoogleFonts.kanit(fontSize: 25, color: colorblack),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Are You Sure',
                      style: GoogleFonts.kanit(fontSize: 20, color: colorblack),
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
                        child: TextButton.icon(
                            icon: const Icon(
                              Icons.close,
                              color: colorblack,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: Text(
                              'No',
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
                        child: TextButton.icon(
                            icon: const Icon(
                              Icons.done,
                              color: colorblack,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: Text(
                              'Yes',
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
