part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent extends Equatable {}

class AddtoFavourites extends FavouritesEvent {
  final favourites favsong;
  final int index;

  AddtoFavourites(this.favsong, this.index);
  @override
  List<Object> get props => [favsong];
}

class FetchFavSongs extends FavouritesEvent {
  FetchFavSongs();

  @override
  List<Object> get props => [];
}

// class CheckFavouritesStatus extends FavouritesEvent {
//   final int id;

//   CheckFavouritesStatus(this.id);
//   @override
//   List<Object> get props => [];
// }
