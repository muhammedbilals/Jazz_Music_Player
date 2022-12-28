import 'package:music_player/model/dbfunctions.dart';
import 'package:music_player/model/favourites.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/splash.dart';

addToFavourites(int index, bool isalready) async {
  List<Songs> dbsongs = box.values.toList();
  void initState() {
    // TODO: implement initState
    List<Songs> dbsongs = box.values.toList();
  }

  List<favourites> favouritessongs = [];
  favouritessongs = favouritesdb.values.toList();
  
  if (isalready) {
    favouritessongs
        .where((element) => element.songname == dbsongs[index].songname)
        .isEmpty;
    favouritesdb.add(favourites(
        songname: dbsongs[index].songname,
        artist: dbsongs[index].artist,
        duration: dbsongs[index].duration,
        songurl: dbsongs[index].songurl,
        id: dbsongs[index].id));
  } else {
    // favouritessongs
    //     .where((element) => element.songname == dbsongs[index].songname)
    //     .isEmpty;
    int currentindex = favouritessongs.indexWhere(
                    (element) => element.id == dbsongs[index].id);
                await favouritesdb.deleteAt(currentindex);
    // await favouritesdb.deleteAt(index);
  }
}
// removefavourite(int index)async{
//   List<favourites> favouritessongs = [];
//   List<Songs> dbsongs = box.values.toList();
//   int currentindex = favouritessongs.indexWhere(
//                     (element) => element.id == dbsongs[index].id);
//                 await favouritesdb.deleteAt(currentindex);
// }

deletefavourite(int index)async{
  await favouritesdb.deleteAt(index);
}

bool checkFavoriteStatus(int index, BuildContext) {
  List<favourites> favouritessongs = [];
  List<Songs> dbsongs = box.values.toList();
  favourites value = favourites(
      songname: dbsongs[index].songname,
      artist: dbsongs[index].artist,
      duration: dbsongs[index].duration,
      songurl: dbsongs[index].songurl,
      id: dbsongs[index].id);

  favouritessongs = favouritesdb.values.toList();
  bool isAlreadyThere = favouritessongs
      .where((element) => element.songname == value.songname)
      .isEmpty;
  return isAlreadyThere ? true : false;
}
