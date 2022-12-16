import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/bottom_navigation.dart';
import 'package:music_player/screens/login_page.dart';

class PlayerSplash extends StatefulWidget {
  const PlayerSplash({super.key});

  @override
  State<PlayerSplash> createState() => _PlayerSplashState();
}

class _PlayerSplashState extends State<PlayerSplash> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('assets/images/icons8-music 2.png'),
        ),
      ),
      backgroundColor: colordark,
      
    );
    
  }
  @override
  void initState() {
    navigateToHome(context);
    super.initState();
}
}

navigateToHome(BuildContext ctx) async {
  await Future.delayed(const Duration(milliseconds: 1500), () {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        
        builder: (ctx) => const HomeMain(),
      ),
    );
  });
}