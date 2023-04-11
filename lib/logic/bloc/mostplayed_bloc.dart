import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/model/mostplayed.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/model/recentlyplayed.dart';

part 'mostplayed_event.dart';
part 'mostplayed_state.dart';

class MostplayedBloc extends Bloc<MostplayedEvent, MostplayedState> {
  MostplayedBloc() : super(MostplayedInitial()) {
    on<FetchRecentlyPlayed>((event, emit) {
      final mostbox = MostplayedBox.getInstance();
      final List<MostPlayed> mostplay = mostbox.values.toList();

      emit(DisplayRecentlyPlayed(mostplay));
    });
    on<UpdateMostPlayedCount>((event, emit) {
        final box = MostplayedBox.getInstance();
  List<MostPlayed> list1 = box.values.toList();
  bool isAlready =
      list1.where((element) => element.songname == event.mostplay.songname).isEmpty;
  if (isAlready == true) {
    box.add(event.mostplay);
  } else {
    
    int index =
        list1.indexWhere((element) => element.songname == event.mostplay.songname);
    box.deleteAt(index);
    // mostplayedsongs.add(event.mostplay);
    box.put(index, event.mostplay);
  }
  int count = event.mostplay.count;
  event.mostplay.count = count + 1;
    });
  }
}
