import 'package:flutter/material.dart';
import 'package:hydraflutter/providers/event_form_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/services.dart';

import '../../widgets/widgets.dart';
import 'widgets/event_widgets.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    // List<Profesionales> profesionales;

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      // floatingActionButton:
      appBar: CustomAppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async {
                  await newEvent(context);
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                // heroTag: null,
                onPressed: () async {
                  Navigator.of(context).pushNamed('eventhorarios');
                },
                icon: const Icon(Icons.more_time),
              ),
            ],
          ),
        ],
        title: 'Eventos',
      ),
      body: Column(children: [
        Flexible(
          child: _listEvents(),
        ),
      ]),
    );
  }

  Widget _listEvents() {
    final size = MediaQuery.of(context).size;
    final eventProvider = Provider.of<EventFormProvider>(context);
    final userProvider = Provider.of<AuthService>(context, listen: false);
    return RefreshIndicator(
      strokeWidth: 3,
      color: Theme.of(context).colorScheme.secondary,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () =>
          eventProvider.refreshEvents(id: userProvider.userInfo.id),
      child: FutureBuilder(
          future: eventProvider.getEventsById(id: userProvider.userInfo.id),
          builder: (_, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.hasData) {
              print('widgetId : ${userProvider.userInfo.id}');
              final events = snapshot.data;
              return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: events!.length,
                  itemBuilder: (_, int i) {
                    return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) async {
                          print('id enWidget: ${userProvider.userInfo.id}');
                          final eventService =
                              Provider.of<EventService>(context, listen: false);

                          await eventService.deleteEvent(events[i].id!);
                          await eventProvider.refreshEvents(
                              id: userProvider.userInfo.id);
                          //Metodo de eliminar0
                        },
                        background: Stack(
                          children: [
                            Container(
                              color: Colors.red.withOpacity(0.7),
                            ),
                            Positioned(
                                left: size.width * 0.8,
                                top: size.height * 0.01,
                                child: const Icon(
                                  Icons.delete,
                                  size: 50,
                                )),
                          ],
                        ),
                        child: _card(events[i]));
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _card(Event event) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () async {
                await editEvent(event, context);
              },
              child: ListTile(
                title: Text('Profesional: ${event.professionalName ?? ''}'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fecha inicio: ${DateFormat('yyyy-MM-dd - hh:mm').format(event.start)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Fecha termino: ${DateFormat('yyyy-MM-dd - hh:mm').format(event.end)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Text('${event.id}')
                  ],
                ),
                leading: const Icon(
                  Icons.event,
                ),
              ),
            )),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
