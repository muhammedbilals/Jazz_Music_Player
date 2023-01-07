import 'package:flutter/material.dart';
import 'package:music_player/model/dbfunctions.dart';
import 'package:music_player/model/favourites.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/splash.dart';

addToFavourites(int index) async {
  List<Songs> dbsongs = box.values.toList();
  void initState() {
    // TODO: implement initState
    List<Songs> dbsongs = box.values.toList();
  }

  List<favourites> favouritessongs = [];
  favouritessongs = favouritesdb.values.toList();
   bool isalready= favouritessongs
        .where((element) => element.songname == dbsongs[index].songname)
        .isEmpty;
  if (isalready) {
    
    favouritesdb.add(favourites(
        songname: dbsongs[index].songname,
        artist: dbsongs[index].artist,
        duration: dbsongs[index].duration,
        songurl: dbsongs[index].songurl,
        id: dbsongs[index].id));
  } else {
    favouritessongs
        .where((element) => element.songname == dbsongs[index].songname)
        .isEmpty;
    int currentindex = favouritessongs
        .indexWhere((element) => element.id == dbsongs[index].id);
    await favouritesdb.deleteAt(currentindex);
    await favouritesdb.deleteAt(index);
  }
}

removefavourite(int index) async {
  final box4 = favocuritesbox.getInstance();
  // List<favourites> favouritessongs = [];
  List<favourites> favsongs = box4.values.toList();
  List<Songs> dbsongs = box.values.toList();
  int currentindex =
      favsongs.indexWhere((element) => element.id == dbsongs[index].id);
  await favouritesdb.deleteAt(currentindex);
}

deletefavourite(int index) async {
  await favouritesdb.deleteAt(favouritesdb.length- index-1);
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
addToFavorites1(int index, favourites value, BuildContext context) async {
  final box4 = favocuritesbox.getInstance();
  List<favourites> favdb = box4.values.toList();
  bool isAlreadyThere =
      favdb.where((element) => element.songname == value.songname).isEmpty;
  if (isAlreadyThere == true) {
    favdb.add(value);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text("Added to favorites"),
    ));
  } else {
    int index =
        favdb.indexWhere((element) => element.songname == value.songname);
    box4.deleteAt(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text("Removed from favorites"),
));
}
}