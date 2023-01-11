import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/screens/mainhome/functions/createplaylist.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/screens/mainhome/screens/playlist_full_lsit.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final playlistbox = PlaylistSongsbox.getInstance();
  late List<PlaylistSongs> playlistsong = playlistbox.values.toList();
  final List<PlaylistModel> playlistsong1 = [];

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;
    return SafeArea(
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
                      ),
                    ),
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
                  '${playlistsong.length} Playlist',
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
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<Box<PlaylistSongs>>(
                valueListenable: playlistbox.listenable(),
                builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                  List<PlaylistSongs> playlistsong =
                      playlistsongs.values.toList();
                  return playlistsong.isNotEmpty
                      ? (ListView.builder(
                          shrinkWrap: true,
                          itemCount: playlistsong.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => PlaylistFullList(
                                            playindex: index,
                                            playlistname: playlistsong[index]
                                                .playlistname))));
                              },
                              leading: playlistsong[index]
                                      .playlistssongs!
                                      .isNotEmpty
                                  ? QueryArtworkWidget(
                                      keepOldArtwork: true,
                                      artworkBorder: BorderRadius.circular(10),
                                      id: playlistsong[index]
                                          .playlistssongs![0]
                                          .id!,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          'assets/images/music.jpeg',
                                          height: vheight * 0.06,
                                          width: vheight * 0.06,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.asset(
                                          'assets/images/music.jpeg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              title: Text(
                                playlistsong[index].playlistname!,
                                style: GoogleFonts.kanit(color: colorwhite),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  deletePlaylist(index);
                                },
                                icon: Icon(Icons.delete),
                                color: colorwhite,
                              ),
                            );
                          }),
                        ))
                      : Center(
                          child: Text(
                            "You haven't created any playlist!",
                            style: GoogleFonts.kanit(color: colorwhite),
                          ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

showPlaylistOptions(BuildContext context) {
  final myController = TextEditingController();
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
                        controller: myController,
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
                        ),
                      ),
                    ),
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
                          createplaylist(myController.text);
                          Navigator.pop(context);
                        },
                        label: Text(
                          'Done',
                          style: GoogleFonts.kanit(
                              fontSize: 20, color: colorblack),
                        ),
                      ),
                    ),
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
