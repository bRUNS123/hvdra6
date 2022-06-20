import 'package:flutter/material.dart';

class DrawHeader extends StatelessWidget {
  const DrawHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.read<NavigationBarBloc>().add(const ChangeIndexEvent(2));
        // Navigator.of(context).pushReplacementNamed(MainApp.routeName);
      },
      splashColor: Colors.green,
      splashFactory: InkRipple.splashFactory,
      child: Ink(
          width: 100,
          height: 75,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                SizedBox(
                  child: Image(
                    image: AssetImage('assets/images/hydra.png'),
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'HλδRA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
