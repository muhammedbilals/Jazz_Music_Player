part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouritesInitial extends FavouritesState {
  FavouritesInitial();

  @override
  List<Object> get props => [];
}

// class CheckFaouritesStatus extends FavouritesState {
//   final bool checkfavouritesStatus;

//   CheckFaouritesStatus(this.checkfavouritesStatus);
// }
class DisplayFavSongs extends FavouritesState {
  final List<favourites> favorites;

  DisplayFavSongs(this.favorites);
    @override
  List<Object> get props => [ favorites];
}
