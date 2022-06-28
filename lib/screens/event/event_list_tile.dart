import 'package:flutter/material.dart';
import 'package:hydraflutter/models/models.dart';

class EventListView extends StatelessWidget {
  final Event eventModel;
  final Function()? onPressed;
  final Function() delete;

  const EventListView(
      {super.key,
      required this.eventModel,
      this.onPressed,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          if (onPressed != null) onPressed!();
        },
        child: Container(
          width: size.width,
          height: 75,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(0.05))
            ],
          ),
          child: Row(children: [
            SizedBox(
              width: size.width / 2.35,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'EventName',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text('EventFecha',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                            fontSize: 12))
                  ]),
            ),
            const Spacer(),
            Text(
              'Event Patient',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            )
          ]),
        ));
  }
}
