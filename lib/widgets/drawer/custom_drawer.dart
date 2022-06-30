import 'package:flutter/material.dart';

import 'package:hydraflutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../bloc/blocs.dart';
import '../../generated/l10n.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthService>(context, listen: false);

    return Drawer(
        child: Material(
      color: Theme.of(context).colorScheme.primary,
      child: ListView(
        children: <Widget>[
          const DrawHeader(),
          BuildHeader(
            name: userProvider.userInfo.fullName ?? '',
            email: userProvider.userInfo.email ?? '',
            urlImage:
                'https://www.clipartmax.com/png/full/214-2143742_individuals-whatsapp-profile-picture-icon.png',
            onClicked: () {
              Navigator.of(context).pop();
              context.read<NavigationBarBloc>().add(const ChangeIndexEvent(4));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const BuildSearch(),
          BuildMenuItem(
            // text: S.of(context).community,
            text: 'Comunidad',
            icon: (Icons.people),
            onClicked: () => selectedPage(context, 0),
          ),
          BuildMenuItem(
            // text: S.of(context).favorites,
            text: 'Eventos',
            icon: (Icons.event_note_outlined),
            onClicked: () {
              selectedPage(context, 1);
              final eventProvider =
                  Provider.of<EventFormProvider>(context, listen: false);
              eventProvider.refreshEvents();
            },
          ),
          BuildMenuItem(
            // text: S.of(context).announcement,
            text: 'Anuncios',
            icon: (Icons.new_releases_rounded),
            onClicked: () => selectedPage(context, 2),
          ),
          BuildMenuItem(
            // text: S.of(context).files,
            text: 'Documentos',
            icon: (Icons.file_copy_sharp),
            onClicked: () => selectedPage(context, 3),
          ),
          BuildMenuItem(
            // text: S.of(context).users,
            text: 'Profesionales',
            icon: (Icons.supervised_user_circle_sharp),
            onClicked: () => selectedPage(context, 4),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          BuildMenuItem(
            // text: S.of(context).notifications,
            text: 'Notificaciones',
            icon: (Icons.notifications_outlined),
            onClicked: () => selectedPage(context, 5),
          ),
          BuildMenuItem(
            text: S.of(context).settings,
            icon: (Icons.settings),
            onClicked: () => selectedPage(context, 6),
          ),
          BuildMenuItem(
            // text: S.of(context).logout,
            text: 'Cerrar Sesión',
            icon: (Icons.logout),
            onClicked: () => selectedPage(context, 7),
          ),
        ],
      ),
    ));
  }
}

void selectedPage(BuildContext context, int index) {
  final authService = Provider.of<AuthService>(context, listen: false);
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      // Navigator.of(context).pushNamed(CommunityPage.routeName);

      break;
    case 1:
      Navigator.of(context).pushNamed('event');
      break;
    case 4:
      break;
    // Navigator.of(context).pushNamed(UsersScreen.routeName);
    case 6:
      context.read<NavigationBarBloc>().add(const ChangeIndexEvent(3));
      break;
    case 7:
      authService.logout();
      Navigator.pushReplacementNamed(context, 'login');
      break;
  }
}
