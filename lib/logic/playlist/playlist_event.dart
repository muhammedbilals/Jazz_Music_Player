// ignore_for_file: override_on_non_overriding_member

part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class FetchPlayListSongs extends PlaylistEvent {
  FetchPlayListSongs();
}

class AddtoPlaylist extends PlaylistEvent {
  final int index;

  AddtoPlaylist(this.index);
}

class CreatePlaylist extends PlaylistEvent {
  final String title;

  CreatePlaylist(this.title);
}

class DeletePlaylistSong extends PlaylistEvent {
  final int index;

  DeletePlaylistSong(this.index);

  @override
  List<Object> get props => [index];
}

class DeletePlaylist extends PlaylistEvent {
  final int index;

  DeletePlaylist(this.index);
}

class EditPlaylist extends PlaylistEvent {
  final int index;
  final String title;

  EditPlaylist(this.index,this.title);

    @override
  List<Object> get props => [index,title];
}
