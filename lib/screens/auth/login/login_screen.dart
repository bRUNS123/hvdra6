import 'package:flutter/material.dart';
import 'package:hydraflutter/providers/login_form_provider.dart';

import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../widgets/widgets.dart';
import 'widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AuthBackground(
            child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: size.height * 0.02),
            CardContainer(
                child: Stack(
              children: [
                const Positioned(
                    right: -10, top: -10, child: ThemePopUpButton()),
                Column(children: [
                  SizedBox(height: size.height * 0.01),
                  Text('HλδRA',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.05,
                          color: Theme.of(context).colorScheme.secondary)),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: const _LoginForm(),
                  ),
                  SizedBox(height: size.height * 0.04),
                ]),
              ],
            )),
          ]),
        )),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final size = MediaQuery.of(context).size;
    return Form(
        //Validaciones y manejo de referencia KEY.
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const RoundedInputField(),
            SizedBox(height: size.height * 0.035),
            const RoundedPasswordField(
              confirmPassword: false,
            ),
            SizedBox(height: size.height * 0.03),
            const RememberMe(),
            SizedBox(height: size.height * 0.02),
            LoginButton(
              loginForm: loginForm,
              textButton: S.of(context).login,
            ),
            SizedBox(height: size.height * 0.015),
            AlreadyHaveAnAccountCheck(press: () {}),
            SizedBox(height: size.height * 0.02),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('home');
                },
                child: Text('Home'))
          ],
        ));
  }
}
