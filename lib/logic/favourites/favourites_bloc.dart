import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/model/favourites.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<AddtoFavourites>((event, emit) {
      final favbox = favocuritesbox.getInstance();
      List<favourites> favourite = favbox.values.toList();
      try {
        bool isAlreadyThere = favourite
            .where((element) => element.songname == event.favsong.songname)
            .isEmpty;
        if (isAlreadyThere) {
          favbox.add(event.favsong);
          
          print("${event.favsong.songname} song added to fav");
        } else {
          print("already added");
          
        }

        add(FetchFavSongs());
      } catch (e) {
        log(e.toString());
      }
    });
    on<FetchFavSongs>((event, emit) {
      try {
        final favbox = favocuritesbox.getInstance();
        List<favourites> favourite = favbox.values.toList();
        emit(DisplayFavSongs(favourite));
      } catch (e) {
        log(e.toString());
      }
    });
    // on<CheckFavouritesStatus>((event, emit) {
    //   final favbox = favocuritesbox.getInstance();
    //   List<favourites> favourite = favbox.values.toList();

    //   bool isAlreadyThere = favourite
    //       .where((element) => element.id == favourite[event.id].songname)
    //       .isEmpty;
    //   emit(ShowFaouritesStatus(isAlreadyThere));
    // });
  }
}
