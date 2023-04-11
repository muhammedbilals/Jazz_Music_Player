import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/model/songmodel.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(PlaylistInitial()) {
    on<FetchPlayListSongs>((event, emit) {
      try {
        final playlistbox = PlaylistSongsbox.getInstance();
        List<PlaylistSongs> playlistsong = playlistbox.values.toList();
        emit(DisplayPlaylist(playlistsong));
        // add(event);
      } catch (e) {
        log(e.toString());
      }
    });
    on<AddtoPlaylist>((event, emit) {
      try {
        final songbox = SongBox.getInstance();
        final playbox = PlaylistSongsbox.getInstance();
        // final box1 = PlaylistSongsbox.getInstance();
        List<PlaylistSongs> playlistDB = playbox.values.toList();
        PlaylistSongs? playsongs = playbox.getAt(event.index);
        List<Songs> playsongdb = playsongs!.playlistssongs!;
        List<Songs> songdb = songbox.values.toList();
        bool isAlreadyAdded =
            playsongdb.any((element) => element.id == songdb[event.index].id);
        if (!isAlreadyAdded) {
          playsongdb.add(
            Songs(
              songname: songdb[event.index].songname,
              artist: songdb[event.index].artist,
              duration: songdb[event.index].duration,
              songurl: songdb[event.index].songurl,
              id: songdb[event.index].id,
            ),
          );
        }
        playbox.putAt(
            event.index,
            PlaylistSongs(
                playlistname: playlistDB[event.index].playlistname,
                playlistssongs: playsongdb));
        print('songs added  ${songdb[event.index].songname}');
      } catch (e) {
        log(e.toString());
      }
    });
    on<CreatePlaylist>((event, emit) {
      final box1 = PlaylistSongsbox.getInstance();
      List<Songs> songsplaylist = [];

      try {
        box1.add(PlaylistSongs(
            playlistname: event.title, playlistssongs: songsplaylist));
        add(FetchPlayListSongs());
        print('playlist created ${event.title}');
      } on Exception catch (e) {
        log(e.toString());
      }
    });
    on<DeletePlaylistSong>((event, emit) {
      final box1 = PlaylistSongsbox.getInstance();

      box1.deleteAt(event.index);
    });
    on<DeletePlaylist>((event, emit) {
      final box1 = PlaylistSongsbox.getInstance();

      box1.deleteAt(event.index);
      add(FetchPlayListSongs());
    });
  }
}
