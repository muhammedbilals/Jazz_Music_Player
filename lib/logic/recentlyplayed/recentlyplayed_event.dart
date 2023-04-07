part of 'recentlyplayed_bloc.dart';

@immutable
abstract class RecentlyplayedEvent {}

class FetchRecentlyPlayed extends RecentlyplayedEvent {
  FetchRecentlyPlayed();
}

class AddToRecentlyPlayed extends RecentlyplayedEvent {
  final RecentlyPlayed recentlyPlayed;

  AddToRecentlyPlayed(this.recentlyPlayed);
}
