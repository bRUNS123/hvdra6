import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hydraflutter/screens/event/widgets/pickdate.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../../services/services.dart';
import '../../../widgets/widgets.dart';

newEvent(BuildContext context) async {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
          insetPadding: const EdgeInsets.all(5),
          title: const Text('Nuevo Evento'),
          content: Builder(
            builder: (context) {
              late int profesionalId;
              final eventService =
                  Provider.of<EventService>(context, listen: false);
              final eventForm = Provider.of<EventFormProvider>(context);

              final TextEditingController controllers =
                  TextEditingController(text: '');
              TextEditingController controllerInitialDate =
                  TextEditingController(text: '');
              TextEditingController controllerEndDate =
                  TextEditingController(text: '');

              final navigatorContext = Navigator.of(context);
              final size = MediaQuery.of(context).size;
              return SizedBox(
                  height: size.height * 0.35,
                  width: 300,
                  child: Form(
                      key: eventForm.formKey,
                      child: Column(children: [
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

                            profesionalId = profesional.id!;
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
                          controller: controllerInitialDate,
                          labelText: 'Fecha de inicio',
                          hintText: 'aaaa-MMM-dd',
                          icon: Icons.calendar_month_outlined,
                          suffixIcon: IconButton(
                              onPressed: () {
                                editDate(context, controllerInitialDate,
                                    controllerEndDate);
                              },
                              icon: const Icon(Icons.edit_calendar_outlined)),

                          // controller: eventForm.getFrom(),
                        ),
                        CustomTextField(
                          controller: controllerEndDate,
                          labelText: 'Fecha de termino',
                          hintText: 'aaaa-MMM-dd',
                          icon: Icons.insert_invitation_rounded,
                          suffixIcon: IconButton(
                              onPressed: () {
                                editDate(context, controllerInitialDate,
                                    controllerEndDate);
                              },
                              icon: const Icon(Icons.edit_calendar_outlined)),
                        ),
                        SizedBox(height: size.height * 0.025),
                        ElevatedButton(
                            onPressed: () async {
                              final eventService = Provider.of<EventService>(
                                  context,
                                  listen: false);
                              final eventProvider =
                                  Provider.of<EventFormProvider>(context,
                                      listen: false);
                              final userProvider = Provider.of<AuthService>(
                                  context,
                                  listen: false);
                              await eventService.newEvent(Event(
                                patient: userProvider.userInfo.id,
                                professional: profesionalId,
                                start:
                                    DateTime.parse(controllerInitialDate.text),
                                end: DateTime.parse(controllerEndDate.text),
                              ));

                              await eventProvider.refreshEvents();
                              navigatorContext.pop();
                            },
                            child: const Text('Crear Evento')),
                      ])));
            },
          )));
}
