part of 'recentlyplayed_bloc.dart';

@immutable
abstract class RecentlyplayedEvent {}

class FetchRecentlyPlayed extends RecentlyplayedEvent {
  FetchRecentlyPlayed();
}
