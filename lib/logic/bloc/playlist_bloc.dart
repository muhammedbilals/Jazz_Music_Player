import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
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
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
