import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/model/songmodel.dart';


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
