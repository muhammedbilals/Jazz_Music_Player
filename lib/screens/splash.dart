import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/bottom_navigation.dart';
import 'package:music_player/screens/login_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerSplash extends StatefulWidget {
  const PlayerSplash({super.key});

  @override
  State<PlayerSplash> createState() => _PlayerSplashState();
}
  final audioquery = OnAudioQuery();
  final box = SongBox.getInstance();

  List<SongModel> fetchSongs = [];
  List<SongModel> allSongs = [];

class _PlayerSplashState extends State<PlayerSplash> {

 @override
  void initState() {
    requestStoragePermission();

    navigateToHome(context);
    super.initState();
  }
  requestStoragePermission() async {
    bool permissionStatus = await audioquery.permissionsStatus();
    if (!permissionStatus) {
      await audioquery.permissionsRequest();

      fetchSongs = await audioquery.querySongs();
      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      for (var element in allSongs) {
        await box.add(Songs(
          songname: element.title,
          artist: element.artist,
          duration: element.duration,
          id: element.id,
          songurl: element.uri,
        ));
      }
    }
    if (!mounted) return;
    setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('assets/images/icons8-music 2.png'),
        ),
      ),
      backgroundColor: colordark,
    );
  }

 
}

navigateToHome(BuildContext ctx) async {
  await Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomeMain(),
      ),
    );
  });
}
