import 'package:hive/hive.dart';
import 'package:music_player/model/favourites.dart';
import 'package:music_player/model/mostplayed.dart';
import 'package:music_player/model/recentlyplayed.dart';


late Box<RecentlyPlayed> RecentlyPlayedBox;
openrecentlyplayeddb() async {
  RecentlyPlayedBox = await Hive.openBox("recentlyplayed");
}
late Box<favourites> favouritesdb;
openFavouritesDB() async {
  favouritesdb = await Hive.openBox<favourites>('favourites');
}
late Box<MostPlayed> mostplayedsongs;
openmostplayeddb() async {
  mostplayedsongs = await Hive.openBox("Mostplayed");
}


updateRecentlyPlayed(RecentlyPlayed value) {
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

updatePlayedSongsCount(MostPlayed value, int index) {
  final box = MostplayedBox.getInstance();
  List<MostPlayed> list1 = box.values.toList();
  bool isAlready =
      list1.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    box.add(value);
  } else {
    int index =
        list1.indexWhere((element) => element.songname == value.songname);
    box.deleteAt(index);
    // mostplayedsongs.add(value);
    box.put(index, value);
  }
  int count = value.count;
  value.count = count + 1;
}
