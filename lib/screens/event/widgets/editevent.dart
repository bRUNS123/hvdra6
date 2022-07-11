import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hydraflutter/models/models.dart';
import 'package:hydraflutter/providers/providers.dart';
import 'package:hydraflutter/screens/event/widgets/pickdate.dart';
import 'package:hydraflutter/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../services/event_service.dart';
import '../../../services/services.dart';

editEvent(Event event, context) async {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            insetPadding: const EdgeInsets.all(5),
            title: const Text('Editar Evento'),
            content: Builder(builder: (context) {
              TextEditingController controllerEditInitialDate =
                  TextEditingController(
                      text: DateFormat('yyyy-MM-dd').format(event.start));
              TextEditingController controllerEditEndDate =
                  TextEditingController(
                      text: DateFormat('yyyy-MM-dd').format(event.end));
              final eventForm = Provider.of<EventFormProvider>(context);
              final eventService = Provider.of<EventService>(context);

              final TextEditingController controllers =
                  TextEditingController(text: event.professionalName!);

              final size = MediaQuery.of(context).size;
              eventForm.profesionalId;

              return SizedBox(
                height: size.height * 0.25,
                width: 300,
                child: Form(
                    key: eventForm.editFormKey,
                    child: Column(
                      children: [
                        TypeAheadFormField<GetProfessionalList?>(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Escribe un parametro por favor.';
                            }
                            return null;
                          },
                          onSuggestionSelected:
                              (GetProfessionalList? suggestion) {
                            final profesional = suggestion!;

                            controllers.text = profesional.fullName!;

                            // final idProfesional = profesional.id;

                            eventForm.profesionalId = profesional.id!;
                          },
                          itemBuilder:
                              (context, GetProfessionalList? suggestion) {
                            final profesional = suggestion!;
                            return ListTile(title: Text(profesional.fullName!));
                          },
                          debounceDuration: const Duration(milliseconds: 300),
                          suggestionsCallback: eventService.getProfessionals,
                          getImmediateSuggestions: true,
                          hideSuggestionsOnKeyboardHide: false,
                          hideOnEmpty: false,
                          noItemsFoundBuilder: (context) => const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('No se ha encontrado.'),
                          ),
                          textFieldConfiguration: TextFieldConfiguration(
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              labelText: 'Profesional',
                              labelStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 22),
                              hintText: 'nombre del profesional',
                              icon: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.secondary,
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
                                  controllerEditInitialDate,
                                  controllerEditEndDate,
                                  event,
                                );
                              },
                              icon: const Icon(Icons.edit_calendar_outlined)),
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
                                  controllerEditInitialDate,
                                  controllerEditEndDate,
                                  event,
                                );
                              },
                              icon: const Icon(Icons.edit_calendar_outlined)),
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
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);

                          TextEditingController controllerEditInitialDate =
                              TextEditingController(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(event.start));
                          TextEditingController controllerEditEndDate =
                              TextEditingController(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(event.end));
                          final userProvider =
                              Provider.of<AuthService>(context, listen: false);
                          final eventService =
                              Provider.of<EventService>(context, listen: false);
                          final eventProvider = Provider.of<EventFormProvider>(
                              context,
                              listen: false);
                          await eventService.updateEvent(
                              event.id!,
                              EventUpdate(
                                  start: DateTime.parse(
                                      controllerEditInitialDate.text),
                                  end: DateTime.parse(
                                      controllerEditEndDate.text),
                                  professional:
                                      (eventProvider.profesionalId!)));
                          eventProvider.refreshEvents(
                              id: userProvider.userInfo.id);
                          navigator.pop();
                        },
                        child: const Text('Guardar')),
                  ],
                ),
              )
            ],
            elevation: 10,
          ),
      barrierDismissible: true);
}
