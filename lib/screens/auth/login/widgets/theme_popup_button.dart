import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hydraflutter/themes/appthemes.dart';
import 'package:hydraflutter/bloc/theme/theme_bloc.dart';

class ThemePopUpButton extends StatelessWidget {
  const ThemePopUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopupMenuButton(
      color: Theme.of(context).colorScheme.primary,
      itemBuilder: (BuildContext bc) {
        return [
          PopupMenuItem(
            child: Text(
              'dark',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () {
              context
                  .read<ThemeBloc>()
                  .add(const OnThemeChange(themeName: 'dark'));
            },
          ),
          PopupMenuItem(
            child: Text(
              'light',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () {
              context
                  .read<ThemeBloc>()
                  .add(const OnThemeChange(themeName: 'light'));
            },
          ),
          PopupMenuItem(
            child: Text(
              'blue',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () {
              context
                  .read<ThemeBloc>()
                  .add(const OnThemeChange(themeName: 'blue'));
            },
          ),
        ];
      },
      icon: Icon(
        context.read<ThemeBloc>().state.theme == AppTheme.darkTheme
            ? Icons.brightness_medium_sharp
            : Icons.brightness_medium_outlined,
        color: Theme.of(context).colorScheme.secondary,
        size: size.height * 0.04,
      ),
    );
  }
}
