import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydraflutter/bloc/blocs.dart';
import 'package:hydraflutter/themes/appthemes.dart';
import 'dart:math' as math;

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 50,
              child: SvgPicture.asset(
                context.read<ThemeBloc>().state.theme == AppTheme.darkTheme
                    ? 'assets/images/hydralogindark.svg'
                    : 'assets/images/hydraloginlight.svg',
                height: size.height * 0.20,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                context.read<ThemeBloc>().state.theme == AppTheme.darkTheme
                    ? 'assets/images/main_topdark.png'
                    : 'assets/images/main_toplight.png',
                width: size.width * 0.25,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                context.read<ThemeBloc>().state.theme == AppTheme.darkTheme
                    ? 'assets/images/login_bottomdark.png'
                    : 'assets/images/login_bottomlight.png',
                width: size.width * 0.20,
              ),
            ),
            Positioned(
              bottom: 35,
              child: Transform.rotate(
                angle: math.pi,
                child: SvgPicture.asset(
                  context.read<ThemeBloc>().state.theme == AppTheme.darkTheme
                      ? 'assets/images/hydralogindark.svg'
                      : 'assets/images/hydraloginlight.svg',
                  height: size.height * 0.20,
                ),
              ),
            ),
            child,
          ],
        ));
  }
}
