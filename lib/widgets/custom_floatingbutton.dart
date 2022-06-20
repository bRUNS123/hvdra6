import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FloatingActionButton(
      elevation: 30,
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
      hoverElevation: 10,
      onPressed: () {
        authService.logout();
        Navigator.pushReplacementNamed(context, 'login');
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Icon(
        Icons.logout,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
