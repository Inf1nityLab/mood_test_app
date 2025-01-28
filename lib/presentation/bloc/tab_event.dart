part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends TabEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object> get props => [index];
} 