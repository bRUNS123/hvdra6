import 'package:flutter/material.dart';
import 'package:hydraflutter/screens/profile/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBody: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: SizedBox(
                    height: size.height * 0.58,
                    child: const Body(),
                  ),
                )
              ]),
            ),
            const Positioned(top: 0, child: ProfileImage()),
          ],
        ));
  }
}
