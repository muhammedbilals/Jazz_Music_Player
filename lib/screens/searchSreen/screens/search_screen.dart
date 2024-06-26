import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  final box = SongBox.getInstance();
  late List<Songs> dbSongs;
  @override
  void initState() {
    dbSongs = box.values.toList();
    for (var item in dbSongs) {
      allSongs.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }

    super.initState();
  }

  List<Audio> allSongs = [];
  final TextEditingController myController = TextEditingController();
  late List<Songs> another = List.from(dbSongs);

  bool istaped = true;
  final songbox = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    double vheight = MediaQuery.of(context).size.height;
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
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
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
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/music.jpeg',
                                height: vheight * 0.06,
                                width: vheight * 0.06,
                              ),
                            ),
                          ),
                          title: Text(
                            another[index].songname!,
                            style: GoogleFonts.kanit(color: colorwhite),
                          ),
                          subtitle: Text(another[index].artist ?? "No Artist",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.kanit(
                                  color: colorwhite.withOpacity(0.7),
                                  fontSize: 12)),
                          onTap: () {
                            _audioPlayer.open(
                                Playlist(audios: allSongs, startIndex: index),
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist);
                          },
                        ),
                      )),
                )
              ],
            ),
          ),
          bottomSheet: NowPlayingSlider(),
        ),
      ),
    );
  }

  void updateList(String value) {
    setState(
      () {
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
      },
    );
  }
}
