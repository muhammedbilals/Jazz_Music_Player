import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/colors/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colorextralight),
            child: TextField(
              decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'What do you want to listen to?'),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
