part of 'all_songs_bloc.dart';

@immutable
abstract class AllSongsEvent {}

class FetchAllSongs extends AllSongsEvent {
  FetchAllSongs();
}
