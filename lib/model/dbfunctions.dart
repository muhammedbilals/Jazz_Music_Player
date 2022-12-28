import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:music_player/model/recentlyplayed.dart';
import 'package:path_provider/path_provider.dart';

// Future<Box> openHiveBox(String boxName) async {
//     if (!kIsWeb && !Hive.isBoxOpen(boxName))
//       Hive.init((await getApplicationDocumentsDirectory()).path);

//     return await Hive.openBox(boxName);
// }

late Box<RecentlyPlayed> RecentlyPlayedBox;
openrecentlyplayeddb() async {
  RecentlyPlayedBox = await Hive.openBox("recentlyplayed");
}

updateRecentlyPlayed(RecentlyPlayed value, index) {
  List<RecentlyPlayed> list = RecentlyPlayedBox.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    RecentlyPlayedBox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    RecentlyPlayedBox.deleteAt(index);
    RecentlyPlayedBox.add(value);
    print(value.songname);
  }
}
