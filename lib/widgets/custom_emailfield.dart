import 'package:flutter/material.dart';

class CustomEmailField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomEmailField({
    this.onChanged,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: ,
      onChanged: onChanged, // (value) {     loginForm.email = value;     },
      // initialValue: loginForm.email,
      controller: controller, //loginForm.controller
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        labelText: 'Correo electronico',
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: 'correos@correos.com',
        icon: Icon(
          Icons.alternate_email_outlined,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = RegExp(pattern);
        return regExp.hasMatch(value ?? '') ? null : 'El correo no es correcto';
      },
    );
  }
}
