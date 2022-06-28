import 'package:flutter/material.dart';

import 'package:hydraflutter/services/services.dart';
import 'package:provider/provider.dart';

import '../../../providers/login_form_provider.dart';

class LoginButton extends StatelessWidget {
  final String textButton;
  final LoginFormProvider loginForm;

  const LoginButton({
    Key? key,
    required this.loginForm,
    required this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return MaterialButton(
      onPressed: loginForm.isLoading
          ? null
          : () async {
              //Si el formulario es valido petición http.
              if (!loginForm.isValidForm()) return;
              final authService =
                  Provider.of<AuthService>(context, listen: false);

              //Si es valido.
              FocusScope.of(context).unfocus();
              loginForm.isLoading = true;

              //Petición http.
              final String? errorMessage = await authService.loginUser(
                loginForm.email,
                loginForm.password,
              );
              //Si no hay error en petición
              if (errorMessage == null) {
                navigator.pushReplacementNamed('home');
                //Obtener datos de usuario.
                final String? errorGettingData =
                    await authService.usernameInfo(loginForm.email);
                if (errorGettingData == null) {
                  print('Todo bien');
                }

                // Navigator.pushReplacementNamed(context, 'home');
              } else {
                //Mostrar error en pantalla.
                debugPrint(errorMessage);
                NotificationsService.showSnackbar(
                    'Los datos ingresados no son correctos.');
                loginForm.isLoading = false;
              }
            },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(loginForm.isLoading ? 'Espere...' : textButton,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      ),
    );
  }
}
