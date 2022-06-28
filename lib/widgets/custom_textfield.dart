import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? initialValue;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.initialValue,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.controller,
    this.onEditingComplete,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(primary: Colors.greenAccent),
      ),
      child: TextFormField(
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        initialValue: initialValue,
        controller: controller,
        autofocus: false,
        autocorrect: false,
        keyboardType: keyboardType,
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
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
          hintText: hintText,
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Escribe un parametro por favor.';
          }
          return null;
        },
      ),
    );
  }
}
