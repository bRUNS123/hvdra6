import 'package:flutter/material.dart';
import 'package:hydraflutter/themes/colors.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Container(
        height: size.height * 0.71,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: _cardDecoration(),
        child: child,
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
          color: scaffoldColorDark,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Colors.black45,
                blurRadius: 40,
                offset: Offset(0, 0))
          ]);
}
