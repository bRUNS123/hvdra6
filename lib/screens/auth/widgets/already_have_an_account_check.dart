import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? '¿No tienes una cuenta? ' : 'Ya tienes una cuenta? ',
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              overflow: TextOverflow.ellipsis,
              fontSize: 12),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? 'Registrate' : 'Inicia Sesión',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
