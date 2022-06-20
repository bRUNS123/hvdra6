part of 'navbar_bloc.dart';

class NavigationBarState extends Equatable {
  final int index;

  const NavigationBarState(this.index);

  @override
  List<Object> get props => [index];
}
