import 'package:flutter/material.dart';
import 'package:hydraflutter/screens/auth/check_auth_screen.dart';
import 'package:hydraflutter/screens/event/choice_example.dart';
import 'package:hydraflutter/screens/event/event_horarios.dart';

import '../screens/screens.dart';

class RouteGenerator {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case 'checking':
        return MaterialPageRoute(builder: (_) => const CheckAuthScreen());
      case 'editprofile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case 'event':
        return MaterialPageRoute(builder: (_) => const EventScreen());

      case 'settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case 'calendar':
        return MaterialPageRoute(builder: (_) => const CalendarScreen());

      case 'eventhorarios':
        return MaterialPageRoute(builder: (_) => const EventHorarios());

      default:
        _errorRoute();
    }
    return _errorRoute();
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
