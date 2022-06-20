import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/login_form_provider.dart';

class RoundedPasswordField extends StatefulWidget {
  final bool confirmPassword;
  const RoundedPasswordField({
    required this.confirmPassword,
    Key? key,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool passwordVisible = true;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Column(
      children: [
        TextFormField(
          controller: _pass,
          validator: (value) {
            return (value != null && value.length >= 3)
                ? null
                : 'La contraseña debe contenter 3 caracteres';
          },
          onChanged: (value) {
            loginForm.password = value;
          },
          autocorrect: false,
          obscureText: passwordVisible,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            labelText: 'Contraseña',
            labelStyle: const TextStyle(color: Colors.grey),
            hintText: 'contraseña1...',
            icon: Icon(
              Icons.lock_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                passwordVisible ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
          ),
        ),
        widget.confirmPassword
            ? TextFormField(
                controller: _confirmPass,
                validator: (String? val) {
                  if (val == null) {
                    return "The value is null";
                  } else if (val.isEmpty) {
                    return "Please Re-Enter New Password";
                  } else if (val.length < 6) {
                    return "Password must be at least 6 characters long";
                  } else if (val != _pass.text) {
                    "Password must be same as above";
                  }

                  return null;
                },
                onChanged: (value) {
                  loginForm.password = value;
                },
                autocorrect: false,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  labelText: 'Confirmación contraseña',
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: 'confirma...',
                  icon: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
