part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
  @override
  List<Object> get props => [];
}

class LocaleChangeEvent extends LanguageEvent{
  final Locale locale;
  const LocaleChangeEvent({required this.locale});
}