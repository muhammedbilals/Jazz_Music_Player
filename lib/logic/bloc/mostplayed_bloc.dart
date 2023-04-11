import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/model/mostplayed.dart';
import 'package:music_player/screens/mainhome/screens/most_played.dart';

part 'mostplayed_event.dart';
part 'mostplayed_state.dart';

class MostplayedBloc extends Bloc<MostplayedEvent, MostplayedState> {
  MostplayedBloc() : super(MostplayedInitial()) {
    on<FetchRecentlyPlayed>((event, emit) {
      
    });
  }
}
