import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppTheme extends Equatable {
  static final ThemeData darkTheme = ThemeData(
    splashColor: Colors.lightGreen.shade200.withOpacity(0.8),
    splashFactory: InkRipple.splashFactory,
    iconTheme: const IconThemeData(color: Colors.greenAccent),
    unselectedWidgetColor: Colors.lightGreen.shade200,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
    )),
    scaffoldBackgroundColor: scaffoldColorDark,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.black,
      secondary: Colors.lightGreen.shade200,
      tertiary: Colors.green[800],
    ),
    primaryColor: Colors.black,
  );

  static final ThemeData lightTheme = ThemeData(
    splashColor: Colors.black38,
    splashFactory: InkRipple.splashFactory,
    iconTheme: const IconThemeData(color: Colors.black),
    unselectedWidgetColor: Colors.black,
    scaffoldBackgroundColor: scaffoldColorLight,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.lightGreen.shade200,
      secondary: Colors.black,
      tertiary: Colors.green[800],
    ),
    primaryColor: Colors.lightGreen[50],
  );

  static final ThemeData blueTheme = ThemeData(
    splashColor: Colors.indigo[900]?.withOpacity(0.8),
    splashFactory: InkRipple.splashFactory,
    iconTheme: const IconThemeData(color: Colors.indigo),
    unselectedWidgetColor: Colors.amber,
    scaffoldBackgroundColor: scaffoldColorBlue,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.blueGrey,
      secondary: Colors.indigo[900],
      tertiary: Colors.lightBlueAccent[400],
    ),
    primaryColor: Colors.lightBlueAccent[50],
  );

  @override
  List<Object?> get props => throw [lightTheme, darkTheme, blueTheme];
}

//#################COLORS#################################//

const appBarColor = Colors.black87;
var scaffoldColorDark = Colors.grey.shade900;
var scaffoldColorLight = const Color.fromARGB(255, 222, 240, 202);
var scaffoldColorBlue = Colors.blueGrey;
var dateColor = Color.fromARGB(255, 80, 200, 140);
