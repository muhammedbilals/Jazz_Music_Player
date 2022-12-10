// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class AllSongsWidget extends StatelessWidget {
//   AllSongsWidget({super.key});
//   List<String> songs = [
//     'Dunes',
//     'Hans Zimmer Hits',
//     'Dark Knight Rises',
//     'Tame Impala'
//   ];
//   List<String> songimage = [
//     'assets/images/hanzimmer.jpg',
//     'assets/images/hanszimmer.jpg',
//     'assets/images/tame-impala-eventually-1400px_800.jpg',
//     'assets/images/TDKR_sdtrck_cover.jpg'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: songs.length,
//         itemBuilder: ((context, index) => ListTile(
          
//               leading: Image.asset(songimage[index]),
//               title: Text(songs[index]),
//               trailing: Icon(Icons.more_vert),
//             )),
//       ),
//     );
//   }
// }
