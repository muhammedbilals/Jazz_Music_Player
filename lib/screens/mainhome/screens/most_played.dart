import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/mostplayed.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostPlayedScreen extends StatefulWidget {
  MostPlayedScreen({super.key});

  @override
  State<MostPlayedScreen> createState() => _MostPlayedScreenState();
}

class _MostPlayedScreenState extends State<MostPlayedScreen> {
  final box = MostplayedBox.getInstance();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> songs = [];
  @override
  void initState() {
    List<MostPlayed> songlist = box.values.toList();

    int i = 0;
    for (var item in songlist) {
      if (item.count > 5) {
        mostfinalsong.insert(i, item);
        i++;
      }
    }
    for (var items in mostfinalsong) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    super.initState();
  }

  List<MostPlayed> mostfinalsong = [];
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
                    'Most Played',
                    style: GoogleFonts.kanit(fontSize: 20, color: colorwhite),
                  ),
                  subtitle: Text(
                    '${songs.length} Songs',
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
                        child:  IconButton(
                         icon: Icon(Icons.play_arrow,size: 30,),
                          color: colordark,
                          onPressed: () {
                            audioPlayer.open(
                                  // Audio.file(allDbsongs[songindex].songurl!),
                                  Playlist(audios: songs, startIndex: 0),
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                                  showNotification: true,
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Icon(Icons.play_arrow)
                ValueListenableBuilder<Box<MostPlayed>>(
                  valueListenable: box.listenable(),
                  builder: (context, Box<MostPlayed> mostplayedDB, _) {
                    // List<MostPlayed> mostplayedsongs =
                    //     mostplayedDB.values.toList();
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mostfinalsong.length,
                      itemBuilder: ((context, index) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 5),
                            child: ListTile(
                              onTap: () {
                                audioPlayer.open(
                                  // Audio.file(allDbsongs[songindex].songurl!),
                                  Playlist(audios: songs, startIndex: index),
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                                  showNotification: true,
                                );
                              },
                              leading: QueryArtworkWidget(
                                keepOldArtwork: true,
                                artworkBorder: BorderRadius.circular(10),
                                id: mostfinalsong[index].id,
                                type: ArtworkType.AUDIO,
                              ),
                              title: Text(
                                mostfinalsong[index].songname,
                                style: GoogleFonts.kanit(color: colorwhite),
                              ),
                              subtitle: Text(mostfinalsong[index].artist,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.kanit(
                                      color: colorwhite.withOpacity(0.7),
                                      fontSize: 12)),
                              
                            ),
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
          bottomSheet: NowPlayingSlider(),
        ),
      ),
    );
  }
}
