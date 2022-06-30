import 'package:flutter/material.dart';
import 'package:hydraflutter/services/services.dart';
import 'package:provider/provider.dart';

import '../../auth/login/widgets/widgets.dart';
import '../../auth/widgets/widgets.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthService>(context);

    return Stack(
      // alignment: Alignment.center,
      children: [
        CardContainer(
          child: Stack(
            children: [
              Column(children: [
                const SizedBox(height: 70),
                Center(
                  child: Text(
                    '${userProvider.userInfo.firstName} ${userProvider.userInfo.lastName}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 5),
                Row(children: const [
                  Text(
                    'PERSONAL',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ]),
                const SizedBox(height: 10),
                FittedBox(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          UserPropiedad(title: 'Nombre'),
                          UserPropiedad(title: 'Primer Apellido'),
                          UserPropiedad(title: 'Segundo Apellido'),
                          UserPropiedad(title: 'Email'),
                          UserPropiedad(title: 'Rut'),
                          UserPropiedad(title: 'Teléfono'),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserData(title: '${userProvider.userInfo.firstName}'),
                          UserData(title: '${userProvider.userInfo.lastName}'),
                          UserData(
                              title: '${userProvider.userInfo.secondLastName}'),
                          UserData(title: '${userProvider.userInfo.email}'),
                          UserData(title: '${userProvider.userInfo.rut}'),
                          UserData(
                              title: '${userProvider.userInfo.phoneNumber}'),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                RoundedButton(
                    text: 'Editar Información',
                    press: () {
                      Navigator.of(context).pushNamed('editprofile');
                    },
                    colorText: Theme.of(context).colorScheme.primary,
                    colorBack: Theme.of(context).colorScheme.secondary)
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

class UserPropiedad extends StatelessWidget {
  final String title;
  const UserPropiedad({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (title),
          style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

class UserData extends StatelessWidget {
  final String title;
  const UserData({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (title),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            overflow: TextOverflow.clip,
          ),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: const [
          BuildImage(),
          Positioned(bottom: 0, right: 4, child: EditIcon())
        ],
      ),
    );
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(4),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.edit, size: 20, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

class BuildImage extends StatelessWidget {
  const BuildImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CircleAvatar(
        radius: 68,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: const AssetImage('assets/images/no-image.png'),
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              child: InkWell(onTap: () {}),
            ),
          ),
        ),
      ),
    );
  }
}
