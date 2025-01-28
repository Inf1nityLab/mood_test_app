part of 'time_bloc.dart';

class TimeState extends Equatable {
  final String currentDateTime;

  const TimeState({required this.currentDateTime});

  @override
  List<Object> get props => [currentDateTime];
} 