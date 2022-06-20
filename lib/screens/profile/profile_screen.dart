import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        ProfileWidget(),
        SizedBox(height: 20),
        BuildName(),
        SizedBox(height: 15),
        EditInfoButton(),
        SizedBox(height: 50),
        BuildAbout()
      ],
    );
  }
}

class BuildAbout extends StatelessWidget {
  const BuildAbout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Acerca de',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            'Descripción del usuario...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class EditInfoButton extends StatelessWidget {
  const EditInfoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('editprofile');
        },
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            onPrimary: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
        child: const Text('Editar Información'),
      ),
    );
  }
}

class BuildName extends StatelessWidget {
  const BuildName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthService>(context, listen: false);
    return Column(
      children: [
        Text(
          userProvider.userInfo.firstName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(userProvider.userInfo.email ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

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
    );
  }
}
