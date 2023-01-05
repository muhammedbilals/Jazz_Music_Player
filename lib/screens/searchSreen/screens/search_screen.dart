import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:music_player/screens/mainhome/widgets/all_songs_widget.dart';
import 'package:music_player/screens/searchSreen/widgets/search_song_list.dart';
import 'package:music_player/screens/splash.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    dbSongs = box.values.toList();

    super.initState();
  }

  late List<Songs> dbSongs;
  List<Audio> allSongs = [];
  final TextEditingController myController = TextEditingController();
  // List<Songs> allDbsongs = songbox.values.toList();
  late List<Songs> another = List.from(dbSongs);
  
    bool istaped = true;
  final songbox = SongBox.getInstance();
  
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 47,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colorextralight),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: myController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: 'What do you want to listen to?'),
                        onChanged: (value) => updateList(value),
                      ),
                    ),
                  ),
                ),
               
            
             ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: another.length,
              itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                    child: ListTile(
                      leading: QueryArtworkWidget(
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(10),
                      id: another[index].id!,
                      type: ArtworkType.AUDIO,
                    ),
                      title: Text(
                      another[index].songname!,
                      style: GoogleFonts.kanit(color: colorwhite),
                    ),
                    subtitle: Text(another[index].artist ?? "No Artist",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.kanit(
                            color: colorwhite.withOpacity(0.7), fontSize: 12)),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  istaped = !istaped;
                                });
                              },
                              icon: Icon(Icons.favorite,
                                  color: (istaped)
                                      ? const Color.fromARGB(255, 121, 121, 121)
                                      : const Color.fromARGB(255, 255, 0, 0))),
                          IconButton(
                            onPressed: () {
                              // showOptions(context);
                            },
                            icon: const Icon(Icons.more_vert),
                            color: colorwhite,
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          
        
              ],
            ),
          ),
          // bottomSheet:  NowPlayingSlider(),
        ),
      ),
    );
  }

  // searchSong(String searchWord) {
  //   final suggestions = allDbsongs.where((allsongs) {
  //     final songtitle = allsongs.songname!.toLowerCase();
  //     final input = searchWord.toLowerCase();
  //     return songtitle.contains(input);
  //   }).toList();
  //   setState(() {
  //     allDbsongs = suggestions;
  //   });
  // }

    void updateList(String value) {
    setState(() {
      another = dbSongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      allSongs.clear();
      for (var item in another) {
        allSongs.add(
          Audio.file(
            item.songurl.toString(),
            metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString(),
            ),
          ),
        );
      }
    });
  }
}
