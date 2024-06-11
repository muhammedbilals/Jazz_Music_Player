part of 'recentlyplayed_bloc.dart';

@immutable
abstract class RecentlyplayedState extends Equatable {}

class RecentlyplayedInitial extends RecentlyplayedState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DisplayRecentlyPlayed extends RecentlyplayedState {
  List<RecentlyPlayed> recentPlay;
  DisplayRecentlyPlayed(this.recentPlay) {}
  @override
  List<Object> get props => [recentPlay];
}
