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
    on<AddToRecentlyPlayed>((event, emit) {
      final box = RecentlyPlayedBox.getInstance();
      final List<RecentlyPlayed> recentlyplayed = box.values.toList();

      try {
        bool isAlready = recentlyplayed
            .where(
                (element) => element.songname == event.recentlyPlayed.songname)
            .isEmpty;
        if (isAlready == true) {
          box.add(event.recentlyPlayed);
          add(FetchRecentlyPlayed());
        } else {
          int index = recentlyplayed.indexWhere(
              (element) => element.songname == event.recentlyPlayed.songname);
          box.deleteAt(index);
          box.add(event.recentlyPlayed);
          print('${event.recentlyPlayed.songname}added to recentlyplayed');
          add(FetchRecentlyPlayed());
        }
      } on Exception catch (e) {
        log(e.toString());
      }
    });
  }
}
