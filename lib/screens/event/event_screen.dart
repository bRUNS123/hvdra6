import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hydraflutter/providers/event_form_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../../themes/colors.dart';
import '../../widgets/widgets.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    final eventForm = Provider.of<EventFormProvider>(context);
    final TextEditingController controllers = TextEditingController(text: '');
    TextEditingController controllerInitialDate =
        TextEditingController(text: '');
    TextEditingController controllerEndDate = TextEditingController(text: '');

    late List<String> autoCompleteData = ["1", "2", "3", "4", "5", "6"];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  insetPadding: const EdgeInsets.all(5),
                  title: const Text('Nuevo Evento'),
                  content: Builder(
                    builder: (context) {
                      final size = MediaQuery.of(context).size;
                      return SizedBox(
                          height: size.height * 0.35,
                          width: 300,
                          child: Form(
                              key: eventForm.formKey,
                              child: Column(children: [
//https://www.youtube.com/watch?v=gDryje6oPrk&ab_channel=EasyApproach
                                TypeAheadFormField<String?>(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Escribe un parametro por favor.';
                                    }
                                    return null;
                                  },
                                  onSuggestionSelected: (String? val) {
                                    controllers.text = val!;
                                  },
                                  itemBuilder: (context, String? val) =>
                                      ListTile(title: Text(val!)),
                                  suggestionsCallback: (pattern) =>
                                      autoCompleteData.where(
                                    (val) => val
                                        .toLowerCase()
                                        .contains(pattern.toLowerCase()),
                                  ),
                                  getImmediateSuggestions: true,
                                  hideSuggestionsOnKeyboardHide: true,
                                  hideOnEmpty: false,
                                  noItemsFoundBuilder: (context) =>
                                      const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('No se ha encontrado.'),
                                  ),
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.5)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      labelText: 'Profesional',
                                      labelStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 22),
                                      hintText: 'nombre del profesional',
                                      icon: Icon(
                                        Icons.person,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                    controller: controllers,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                CustomTextField(
                                  controller: eventForm.controllerInitialDate,
                                  labelText: 'Fecha de inicio',
                                  hintText: 'aaaa-MMM-dd',
                                  icon: Icons.calendar_month_outlined,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        editDates(
                                            context,
                                            controllerInitialDate,
                                            controllerEndDate);
                                      },
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined)),

                                  // controller: eventForm.getFrom(),
                                ),
                                CustomTextField(
                                  controller: eventForm.controllerEndDate,
                                  labelText: 'Fecha de termino',
                                  hintText: 'aaaa-MMM-dd',
                                  icon: Icons.insert_invitation_rounded,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        editDates(
                                            context,
                                            controllerInitialDate,
                                            controllerEndDate);
                                      },
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined)),
                                ),
                                SizedBox(height: size.height * 0.025),
                                ElevatedButton(
                                    onPressed: () {
                                      // eventService.newEvent(Event(
                                      //   patient: userProvider.userInfo.id,
                                      //   professional: int.parse(controllers.text),
                                      //   start: DateTime.parse(eventForm.controllerInitialDate.text),
                                      //   end: DateTime.parse(eventForm.controllerEndDate.text),
                                      // ));
                                      print(controllers.text);
                                      // print(selectPro);
                                      // print(userProvider.userInfo.id);

                                      // eventForm.refreshEvents();
                                      Navigator.pop;
                                    },
                                    child: const Text('Crear Evento')),
                              ])));
                    },
                  ))); // Navigator.of(context).pushNamed('newEvent');
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
    final TextEditingController controllers =
        TextEditingController(text: event.professionalName!);

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
                                      TypeAheadFormField<String?>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Escribe un parametro por favor.';
                                          }
                                          return null;
                                        },
                                        onSuggestionSelected: (String? val) {
                                          controllers.text = val!;
                                        },
                                        itemBuilder: (context, String? val) =>
                                            ListTile(title: Text(val!)),
                                        suggestionsCallback: (pattern) =>
                                            autoCompleteData.where(
                                          (val) => val
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()),
                                        ),
                                        getImmediateSuggestions: true,
                                        hideSuggestionsOnKeyboardHide: false,
                                        hideOnEmpty: false,
                                        noItemsFoundBuilder: (context) =>
                                            const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text('No se ha encontrado.'),
                                        ),
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(0.5)),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                            labelText: 'Profesional',
                                            labelStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 22),
                                            hintText: 'nombre del profesional',
                                            icon: Icon(
                                              Icons.person,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                          controller: controllers,
                                          keyboardType: TextInputType.name,
                                        ),
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
}

Future editDates(
  BuildContext context,
  TextEditingController? controller,
  TextEditingController? controllerEnd,
) async {
  // var initialDate = DateTimeRange(
  //     start: DateTime.now(), end: DateTime(DateTime.now().day + 5));

  final eventForm = Provider.of<EventFormProvider>(context, listen: false);

  final newDateRanger = await showDateRangePicker(
    context: context,
    initialDateRange: DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(days: 7)),
    ),
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
  eventForm.controllerInitialDate.text =
      DateFormat('yyyy-MM-dd').format(newDateRanger.start);

  eventForm.controllerEndDate.text =
      DateFormat('yyyy-MM-dd').format(newDateRanger.end);
}
