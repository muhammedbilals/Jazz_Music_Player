import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/model/recentlyplayed.dart';

part 'recentlyplayed_event.dart';
part 'recentlyplayed_state.dart';

class RecentlyplayedBloc
    extends Bloc<RecentlyplayedEvent, RecentlyplayedState> {
  RecentlyplayedBloc() : super(RecentlyplayedInitial()) {
    on<FetchRecentlyPlayed>((event, emit) {
    
      try {
          final box = RecentlyPlayedBox.getInstance();
      final List<RecentlyPlayed> recentlyplayed =
          box.values.toList().reversed.toList();
      emit(DisplayRecentlyPlayed(recentlyplayed));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
