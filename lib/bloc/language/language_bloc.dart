import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydraflutter/services/services.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final String currentLanguage;

  LanguageBloc(this.currentLanguage)
      : super(LanguageState(locale: Locale(currentLanguage))) {
    on<LocaleChangeEvent>((event, emit) {
      LocalStorage.prefs.setString('languageCode', event.locale.languageCode);
      emit(state.copyWith(locale: event.locale));
    });
  }
}
