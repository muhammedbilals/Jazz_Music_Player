import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/model/mostplayed.dart';
import 'package:equatable/equatable.dart';

part 'mostplayed_event.dart';
part 'mostplayed_state.dart';

class MostplayedBloc extends Bloc<MostplayedEvent, MostplayedState> {
  MostplayedBloc() : super(MostplayedInitial()) {
    on<FetchRecentlyPlayed>((event, emit) {
      final mostbox = MostplayedBox.getInstance();
      final List<MostPlayed> mostplay = mostbox.values.toList();

      emit(DisplayRecentlyPlayed(mostplay));
    });
  }
}
