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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await newEvent(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: const CustomAppBar(
        title: 'Eventos',
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //     child: IconButton(
        //       icon: const Icon(Icons.menu),
        //       onPressed: () => Scaffold.of(context).openDrawer(),
        //     ),
        //   )
        // ],
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

    return RefreshIndicator(
      strokeWidth: 3,
      color: Theme.of(context).colorScheme.secondary,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: eventProvider.refreshEvents,
      child: FutureBuilder(
          future: eventProvider.getEventsById(),
          builder: (_, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data;
              return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: events!.length,
                  itemBuilder: (_, int i) {
                    return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) async {
                          final eventService =
                              Provider.of<EventService>(context, listen: false);

                          await eventService.deleteEvent(events[i].id!);
                          await eventProvider.refreshEvents();
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
                          'Fecha inicio: ${DateFormat('yyyy-MM-dd').format(event.start)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Fecha termino: ${DateFormat('yyyy-MM-dd').format(event.end)}',
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
