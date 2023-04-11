part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedEvent {}

class FetchRecentlyPlayed extends MostplayedEvent {
  FetchRecentlyPlayed();
}
