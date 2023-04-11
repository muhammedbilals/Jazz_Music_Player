import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/model/dbfunctions.dart';
import 'package:music_player/model/favourites.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:music_player/screens/splash.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FetchFavSongs>((event, emit) {
      try {
        final favbox = favocuritesbox.getInstance();
        List<favourites> favourite = favbox.values.toList();
        emit(DisplayFavSongs(favourite));
      } catch (e) {
        log(e.toString());
      }
    });
    on<AddorRemoveFavourites>((event, emit) {
      List<Songs> dbsongs = box.values.toList();
      final favbox = favocuritesbox.getInstance();
      final favouritessongs = favouritesdb.values.toList();
      bool isalready = favouritessongs
          .where((element) => element.songname == dbsongs[event.index].songname)
          .isEmpty;
      if (isalready) {
        favouritesdb.add(event.favsong);
        add(FetchFavSongs());
      } else {
        int index = favouritessongs.indexWhere(
            (element) => element.songname == event.favsong.songname);
        favbox.deleteAt(index);
        print('deleted at $index');
        print(favbox.length);
        // favbox.deleteAt(event.index);

        add(FetchFavSongs());
      }
    });
    on<RemoveFromFavouritesList>((event, emit) {
      try {
        final favbox = favocuritesbox.getInstance();
        favbox.deleteAt(event.index);
        
        add(FetchFavSongs());
      } on Exception catch (e) {
        log(e.toString());
      }
    });
  }
}
