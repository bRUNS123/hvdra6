part of 'navbar_bloc.dart';

abstract class NavigationBarEvent extends Equatable {
  const NavigationBarEvent();

  @override
  List<Object> get props => [];
}

class ChangeIndexEvent extends NavigationBarEvent {
  final int newIndex;

  const ChangeIndexEvent(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
