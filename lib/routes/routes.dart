import 'package:flutter/material.dart';
import 'package:hydraflutter/screens/auth/check_auth_screen.dart';

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
      case 'newEvent':
      // return MaterialPageRoute(builder: (_) => const NewEventScreen());

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
