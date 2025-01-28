part of 'time_bloc.dart';

abstract class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class StartTimer extends TimeEvent {}

class UpdateTime extends TimeEvent {} 