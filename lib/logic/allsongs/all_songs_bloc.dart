import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/model/songmodel.dart';

part 'all_songs_event.dart';
part 'all_songs_state.dart';

class AllSongsBloc extends Bloc<AllSongsEvent, AllSongsState> {
  AllSongsBloc() : super(AllSongsInitial()) {
    on<FetchAllSongs>((event, emit) {
      try {
        final alldbsongs = SongBox.getInstance();
        List<Songs> allDbsongs = alldbsongs.values.toList();
        emit(DisplayAllSongs(allDbsongs));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
