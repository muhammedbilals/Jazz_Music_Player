import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';

class LikedSongsList extends StatelessWidget {
  LikedSongsList({super.key});
  List<String> songs = [
    'Hans Zimmer - The Classics ',
    'Dune sound track',
    'evantually',
    'Dark Knight Theme song',
    'Gladiator Sound track',
    'Top Gun: Maverick Soundtrack',
    'There He Is Song The Amazing Spider-Man 2',
    'Hans Zimmer - Interstellar',
    'Hans Zimmer - The Classics ',
    'Dune sound track',
    'evantually',
    'Dark Knight Theme song',
    'Gladiator Sound track',
    'Top Gun: Maverick Soundtrack',
    'There He Is Song The Amazing Spider-Man 2',
    'Hans Zimmer - Interstellar',
  ];

  List<String> author = [
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
    'Hans Zimmer',
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
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
    'assets/images/hanzimmer.jpg',
    'assets/images/hanszimmer.jpg',
    'assets/images/tame-impala-eventually-1400px_800.jpg',
    'assets/images/TDKR_sdtrck_cover.jpg',
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
                      ListTile(
                        title: Text(
                          'Liked Songs',
                          style: GoogleFonts.kanit(
                              fontSize: 20, color: colorwhite),
                        ),
                        subtitle: Text(
                          '120 Songs',
                          style: GoogleFonts.kanit(
                              fontSize: 14, color: colorwhite.withOpacity(0.7)),
                        ),
                        trailing: Wrap(
                          spacing: 10,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.shuffle,
                                color: colorwhite,
                                size: 30,
                              ),
                            ),
                            Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: colorextralight),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: colordark,
                                  size: 30,
                                )),
                          ],
                        ),
                      ),

                      // Icon(Icons.play_arrow)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: songs.length,
                        itemBuilder: ((context, index) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, left: 5),
                              child: ListTile(
                                leading: ClipRRect(
                                    child: Image.asset(
                                  songimage[index],
                                )),
                                title: Text(
                                  songs[index],
                                  style: GoogleFonts.kanit(color: colorwhite),
                                ),
                                subtitle: Text(author[index],
                                    style: GoogleFonts.kanit(
                                        color: colorwhite.withOpacity(0.7),
                                        fontSize: 12)),
                                trailing: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite),
                                      color: Colors.red,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showOptions(context);
                                      },
                                      icon: const Icon(Icons.more_vert),
                                      color: colorwhite,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
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
