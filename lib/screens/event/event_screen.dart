import 'package:flutter/material.dart';
import 'package:hydraflutter/providers/event_form_provider.dart';
import 'package:hydraflutter/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../../themes/colors.dart';
import '../../widgets/widgets.dart';
import 'widgets/pickdate.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('newEvent');
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
        )
      ]),
    );
  }

  Widget _listEvents() {
    final size = MediaQuery.of(context).size;
    final eventProvider = Provider.of<EventFormProvider>(context);

    return FutureBuilder(
        future: eventProvider.getEventsById(),
        builder: (_, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data;
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: events!.length,
                itemBuilder: (_, int i) {
                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (DismissDirection direction) {
                        final eventService =
                            Provider.of<EventService>(context, listen: false);

                        eventService.deleteEvent(events[i].id!);
                        eventProvider.refreshEvents();
                        //Metodo de eliminar0
                        print(events[i].id);

                        //  Provider.of<ScanListProvider>(context, listen: false)
                        // .borrarScanPorId(scans[i].id);
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
        });
  }

  Widget _card(Event event) {
    //Deberia estar la lista de profesionales.
    late List<String> autoCompleteData = <String>["1", "2", "3", "4", "5", "6"];

    TextEditingController controllerEditInitialDate = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(event.start));
    TextEditingController controllerEditEndDate =
        TextEditingController(text: DateFormat('yyyy-MM-dd').format(event.end));
    final eventForm = Provider.of<EventFormProvider>(context);
    final eventService = Provider.of<EventService>(context);

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          insetPadding: const EdgeInsets.all(5),
                          title: const Text('Editar Evento'),
                          content: Builder(builder: (context) {
                            final size = MediaQuery.of(context).size;
                            return SizedBox(
                              height: size.height * 0.25,
                              width: 300,
                              child: Form(
                                  key: eventForm.editFormKey,
                                  child: Column(
                                    children: [
                                      Autocomplete(
                                        initialValue: TextEditingValue(
                                            text: event.professionalName!),
                                        optionsBuilder: (TextEditingValue
                                            textEditingValue) {
                                          {
                                            return autoCompleteData.where(
                                                (word) => word
                                                    .toLowerCase()
                                                    .contains(textEditingValue
                                                        .text
                                                        .toLowerCase()));
                                          }
                                        },
                                        onSelected: (String selectString) {},
                                        fieldViewBuilder: (context, controller,
                                            focusNode, onEdittingComplete) {
                                          return CustomTextField(
                                              onEditingComplete:
                                                  onEdittingComplete,
                                              focusNode: focusNode,
                                              controller: controller,
                                              labelText: 'Profesional',
                                              hintText:
                                                  'nombre del profesional',
                                              icon: Icons.person);
                                        },
                                      ),
                                      CustomTextField(
                                        controller: controllerEditInitialDate,
                                        labelText: 'Fecha de inicio',
                                        hintText: 'aaaa-dd-MMM',
                                        icon: Icons.calendar_month_outlined,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              editDate(
                                                  context,
                                                  event,
                                                  controllerEditInitialDate,
                                                  controllerEditEndDate);
                                            },
                                            icon: const Icon(
                                                Icons.edit_calendar_outlined)),

                                        // controller: eventForm.getFrom(),
                                      ),
                                      CustomTextField(
                                        controller: controllerEditEndDate,
                                        labelText: 'Fecha de termino',
                                        hintText: 'aaaa-dd-MMM',
                                        icon: Icons.insert_invitation_rounded,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              editDate(
                                                  context,
                                                  event,
                                                  controllerEditInitialDate,
                                                  controllerEditEndDate);
                                            },
                                            icon: const Icon(
                                                Icons.edit_calendar_outlined)),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        final eventProvider =
                                            Provider.of<EventFormProvider>(
                                                context,
                                                listen: false);
                                        eventService.updateEvent(
                                            event.id!,
                                            EventUpdate(
                                                start: DateTime.parse(
                                                    controllerEditInitialDate
                                                        .text),
                                                end: DateTime.parse(
                                                    controllerEditEndDate.text),
                                                professional:
                                                    event.professional!));
                                        Navigator.pop(context);
                                        eventProvider.refreshEvents();
                                      },
                                      child: const Text('Guardar')),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancelar')),
                                ],
                              ),
                            )
                          ],
                          elevation: 10,
                        ),
                    barrierDismissible: true);
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

Future editDate(
  BuildContext context,
  Event event,
  TextEditingController? controller,
  TextEditingController? controllerEnd,
) async {
  var initialDate = DateTimeRange(start: event.start, end: event.end);

  final newDateRanger = await showDateRangePicker(
    context: context,
    initialDateRange: initialDate,
    firstDate: DateTime(2022),
    lastDate: DateTime(DateTime.now().year + 5),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
                onPrimary: Colors.black, // selected text color
                onSurface: dateColor, // default text color
                primary: Colors.greenAccent // circle color
                ),
            // dialogBackgroundColor: Colors.black54,
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontFamily: 'Quicksand'),
                    primary:
                        Colors.lightGreen[200], // color of button's letters
                    backgroundColor: Colors.black54, // Background color
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50))))),
        child: child!,
      );
    },
  );
  if (newDateRanger == null) return;

  controller!.text = DateFormat('yyyy-MM-dd').format(newDateRanger.start);
  controllerEnd!.text = DateFormat('yyyy-MM-dd').format(newDateRanger.end);

  print(initialDate);
}
