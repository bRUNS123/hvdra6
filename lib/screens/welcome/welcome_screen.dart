import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('eventhorarios');
            },
            child: Text('Event Example'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.of(context).pushNamed('choiceexample');
          //   },
          //   child: Text('Choice Example'),
          // ),
        ],
      ),
    );
  }
}
