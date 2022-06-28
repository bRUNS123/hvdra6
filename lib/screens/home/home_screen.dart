import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydraflutter/bloc/blocs.dart';
import 'package:hydraflutter/generated/l10n.dart';
import 'package:hydraflutter/screens/screens.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:hydraflutter/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screens = [
      const NewsScreen(),
      const ChatScreen(),
      const WelcomeScreen(),
      const SettingsScreen(),
      const ProfileScreen(),
    ];

    final titulos = [
      S.of(context).menu,
      S.of(context).chat,
      S.of(context).hydra,
      S.of(context).settings,
      S.of(context).profile,
    ];

    final items = <Widget>[
      Icon(Icons.newspaper, color: Theme.of(context).colorScheme.primary),
      Icon(Icons.chat, color: Theme.of(context).colorScheme.primary),
      Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
      Icon(Icons.build_sharp, color: Theme.of(context).colorScheme.primary),
      Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
    ];

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, currentIndex) {
        return GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0 && currentIndex.index != 0) {
              context
                  .read<NavigationBarBloc>()
                  .add(ChangeIndexEvent(currentIndex.index - 1));
            } else if (details.primaryVelocity! < 0 &&
                currentIndex.index != 4) {
              context
                  .read<NavigationBarBloc>()
                  .add(ChangeIndexEvent(currentIndex.index + 1));
            } else if (currentIndex.index == 0 &&
                details.primaryVelocity! > 200) {
              context.read<NavigationBarBloc>().add(const ChangeIndexEvent(4));
            } else if (currentIndex.index == 4 &&
                details.primaryVelocity! < -200) {
              context.read<NavigationBarBloc>().add(const ChangeIndexEvent(0));
            }
          },
          child: Scaffold(
              extendBody: true,
              appBar: CustomAppBar(
                title: titulos[currentIndex.index],
              ),
              drawer: const CustomDrawer(),
              floatingActionButton: const CustomFloatingButton(),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              bottomNavigationBar:
                  curvedNav(items, context, currentIndex.index),
              body: screens[currentIndex.index]),
        );
      },
    );
  }

  CurvedNavigationBar curvedNav(
      List<Widget> items, BuildContext context, int currentIndex) {
    final size = MediaQuery.of(context).size;

    return CurvedNavigationBar(
        height: size.width * 0.14,
        items: items,
        index: currentIndex,
        animationDuration: const Duration(
          milliseconds: 400,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        buttonBackgroundColor: Theme.of(context).colorScheme.tertiary,
        color: Theme.of(context).colorScheme.secondary,
        onTap: (index) =>
            context.read<NavigationBarBloc>().add(ChangeIndexEvent(index)));
  }
}
