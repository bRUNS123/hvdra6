import 'package:flutter/material.dart';
import 'package:hydraflutter/screens/screens.dart';
import 'package:hydraflutter/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: const [ProfileWidget()],
      ),
    );
  }
}
