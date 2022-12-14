import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/album_full_list.dart';

class AlbumsList extends StatelessWidget {
  AlbumsList({super.key});
  List<String> songs = [
    'Hans Zimmer',
    'Dune ',
    'currents',
    'Dark Knight',
    'Gladiator',
    'Top Gun: Maverick',
  ];

  List<String> author = [
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
  ];

  List<String> songimage = [
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;

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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          title: Text(
                            'Albums',
                            style: GoogleFonts.kanit(
                                fontSize: 20, color: colorwhite),
                          ),
                          subtitle: Text(
                            '6 albums',
                            style: GoogleFonts.kanit(
                                fontSize: 14,
                                color: colorwhite.withOpacity(0.7)),
                          ),
                        ),
                      ),

                      // Icon(Icons.play_arrow)
                      GridView.builder(
                        itemCount: songs.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (_, index) => GridTile(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            AlbumFullList())));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: colordark,
                                    borderRadius: BorderRadius.circular(20)),
                                height: 500,
                                child: Column(
                                  children: [
                                    Flexible(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child:
                                                Image.asset(songimage[index]))),
                                    Text(
                                      author[index],
                                      style: GoogleFonts.kanit(
                                          fontSize: 20,
                                          color: colorwhite.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // itemCount: 4,
                      )
                    ],
                  ),
                ))));
  }

  showOptions(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: colorblack,
                    ),
                    label: Text(
                      'Add to Favourites',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.playlist_add,
                      color: colorblack,
                    ),
                    label: Text(
                      'Add to Playlist',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: colorblack,
                    ),
                    label: Text(
                      'Share',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shuffle,
                      color: colorblack,
                    ),
                    label: Text(
                      'Shuffle',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.repeat,
                    color: colorblack,
                  ),
                  label: Text(
                    'Repeat',
                    style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
