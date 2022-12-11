import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/widgets/alert_dialog.dart';

class AllSongsWidget extends StatefulWidget {
  AllSongsWidget({super.key});

  @override
  State<AllSongsWidget> createState() => _AllSongsWidgetState();
}

class _AllSongsWidgetState extends State<AllSongsWidget> {
  bool istaped = true;

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
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
              child: Text('All Songs',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite)),
            )
          ],
        ),
        ///////////////////
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: songs.length,
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 5),
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
                          color: colorwhite.withOpacity(0.7), fontSize: 12)),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              istaped = false;
                            });
                          },
                          icon: Icon(Icons.favorite,
                              color: (istaped)
                                  ? Color.fromARGB(255, 121, 121, 121)
                                  : Color.fromARGB(255, 255, 0, 0))),
                      IconButton(
                        onPressed: () {
                          showOptions(context);
                        },
                        icon: Icon(Icons.more_vert),
                        color: colorwhite,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }

//   Widget? iconfav() {
//     if (istaped = true) {
//       return Icon(Icons.favorite_border_outlined);
//     } else {
//       return Icon(Icons.favorite_border_outlined);
//     }
//   }

//   Widget? istapeda() {
//     if (istaped = true) return Icon(Icons.favorite_border_outlined);
//     return Icon(Icons.favorite);
//   }
// }

// Widget lovebuttonoutline() {
//   return Icon(Icons.favorite);
// }

// Widget lovebuttonfilled() {
//   return Icon(Icons.favorite_border_outlined);
// }




          
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
                    icon: Icon(
                      Icons.favorite,
                      color: colorblack,
                    ),
                    label: Text(
                      'Add to Favourites',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.playlist_add,
                      color: colorblack,
                    ),
                    label: Text(
                      'Add to Playlist',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      color: colorblack,
                    ),
                    label: Text(
                      'Share',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shuffle,
                      color: colorblack,
                    ),
                    label: Text(
                      'Shuffle',
                      style: GoogleFonts.kanit(color: colorblack, fontSize: 17),
                    )),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
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
