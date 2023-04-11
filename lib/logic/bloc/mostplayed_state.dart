part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedState {}

class MostplayedInitial extends MostplayedState {}

class DisplayRecentlyPlayed extends MostplayedState {
 final List<MostPlayed> mostPlayed;

  DisplayRecentlyPlayed(this.mostPlayed);
}
