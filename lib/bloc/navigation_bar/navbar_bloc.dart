import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  NavigationBarBloc() : super(const NavigationBarState(2)) {
    on<ChangeIndexEvent>(_onChangeIndex);
  }

  FutureOr<void> _onChangeIndex(
      ChangeIndexEvent event, Emitter<NavigationBarState> emit) {
    emit(NavigationBarState(event.newIndex));
  }
}
