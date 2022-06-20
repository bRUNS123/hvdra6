part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData theme;
  const ThemeState({
    required this.theme,
  });

  ThemeState copyWith({ThemeData? theme}) =>
      ThemeState(theme: theme ?? this.theme);

  @override
  List<Object> get props => [theme];
}
