import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/mainhome/screens/now_playing_slider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colordark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colordark,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorextralight),
              child: const Padding(
                padding: EdgeInsets.only(left:10),
                child: TextField(
                  
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search ),
                      border: InputBorder.none,
                      hintText: 'What do you want to listen to?'),
                     
                  
                ),
                
              ),
              
            ),
          ),
          bottomSheet: NowPlayingSlider(),
        ),
      ),
    );
  }
}
