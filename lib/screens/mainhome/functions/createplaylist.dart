import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/model/songmodel.dart';

createplaylist(String name) async {
  final box1 = PlaylistSongsbox.getInstance();

  List<Songs> songsplaylist = [];

  box1.add(PlaylistSongs(playlistname: name, playlistssongs: songsplaylist));
  // print(name);
}

editPlaylist(String name, index) async {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> playlistsong = playlistbox.values.toList();
  final box1 = PlaylistSongsbox.getInstance();

  box1.putAt(
      index,
      PlaylistSongs(
          playlistname: name,
          playlistssongs: playlistsong[index].playlistssongs));
}

addToPlaylist(Songs song, int index) {
  final songbox = SongBox.getInstance();
  final playbox = PlaylistSongsbox.getInstance();
  final box1 = PlaylistSongsbox.getInstance();

  List<PlaylistSongs> playlistDB = box1.values.toList();

  PlaylistSongs? playsongs = playbox.getAt(index);
  List<Songs> playsongdb = playsongs!.playlistssongs!;
  List<Songs> songdb = songbox.values.toList();
  bool isAlreadyAdded =
      playsongdb.any((element) => element.id == songdb[index].id);
  if (!isAlreadyAdded) {
    playsongdb.add(
      Songs(
        songname: songdb[index].songname,
        artist: songdb[index].artist,
        duration: songdb[index].duration,
        songurl: songdb[index].songurl,
        id: songdb[index].id,
      ),
    );
  }
  playbox.putAt(
      index,
      PlaylistSongs(
          playlistname: playlistDB[index].playlistname,
          playlistssongs: playsongdb));
}

deletePlaylist(int index) {
  final box1 = PlaylistSongsbox.getInstance();

  box1.deleteAt(index);
}
