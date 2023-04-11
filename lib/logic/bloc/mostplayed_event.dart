part of 'mostplayed_bloc.dart';

@immutable
abstract class MostplayedEvent {}

class FetchMostPlayed extends MostplayedEvent {
  FetchMostPlayed();
}

class UpdateMostPlayedCount extends MostplayedEvent {
  final MostPlayed mostplay;
  final int index;

  UpdateMostPlayedCount(this.mostplay, this.index);
  
      @override
  List<Object> get props => [mostplay,index];
}
