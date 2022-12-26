import 'package:hive/hive.dart';
import 'package:music_player/model/recentlyplayed.dart';

late Box<RecentlyPlayed> RecentlyPlayedBox;

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
  }
}
