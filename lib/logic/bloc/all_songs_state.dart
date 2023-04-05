part of 'all_songs_bloc.dart';

@immutable
abstract class AllSongsState {}

class AllSongsInitial extends AllSongsState {
  AllSongsInitial();
}

class DisplayAllSongs extends AllSongsState {
  final List<Songs> Allsongs;

  DisplayAllSongs(this.Allsongs);
}
