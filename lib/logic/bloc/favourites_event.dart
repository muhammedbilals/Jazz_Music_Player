part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent extends Equatable{}

class AddtoFavourites extends FavouritesEvent {
  final favourites favsong;

  AddtoFavourites(this.favsong);
  @override
  List<Object> get props => [favsong];
}

class FetchFavSongs extends FavouritesEvent {
  FetchFavSongs();

    @override
  List<Object> get props => [];
}
