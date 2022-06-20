import 'package:flutter/material.dart';
import 'package:hydraflutter/widgets/custom_appbar.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Eventos'),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('newEvent');
        },
        child: Text('Nuevo Evento'),
      )),
    );
  }
}
