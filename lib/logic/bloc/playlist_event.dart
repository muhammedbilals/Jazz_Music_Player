part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class FetchPlayListSongs extends PlaylistEvent {
  FetchPlayListSongs();
}
