import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double widthSize;
  final VoidCallback press;
  final Color colorText;
  final Color colorBack;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
    required this.colorText,
    required this.colorBack,
    required this.widthSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: widthSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          onPrimary: colorText,
          primary: colorBack,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )),
      child: Text(
        text,
      ),
    );
  }
}
