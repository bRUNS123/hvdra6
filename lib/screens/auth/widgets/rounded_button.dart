import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color colorText;
  final Color colorBack;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.colorText,
    required this.colorBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
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
      child: Text(
        text,
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          onPrimary: colorText,
          primary: colorBack,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
