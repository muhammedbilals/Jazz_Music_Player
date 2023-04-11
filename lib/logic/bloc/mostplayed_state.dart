part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedState extends Equatable{}

class MostplayedInitial extends MostplayedState {

    @override
  List<Object> get props => [];
}

class DisplayRecentlyPlayed extends MostplayedState {
 final List<MostPlayed> mostPlayed;

  DisplayRecentlyPlayed(this.mostPlayed);

    @override
  List<Object> get props => [mostPlayed];
}
