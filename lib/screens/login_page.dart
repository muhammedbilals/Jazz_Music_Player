import 'package:flutter/material.dart';
import 'package:music_player/screens/bottom_navigation.dart';


class PlayerLogin extends StatelessWidget {
  const PlayerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeMain()),
              );
            },
            icon: Icon(Icons.arrow_back)),
      ),
    );
  }
}
