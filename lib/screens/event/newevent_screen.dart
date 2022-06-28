import 'package:flutter/material.dart';

import 'package:hydraflutter/screens/screens.dart';
import 'package:hydraflutter/widgets/widgets.dart';
import 'package:hydraflutter/services/services.dart';

import 'package:provider/provider.dart';

// import 'package:hydraflutter/screens/widgets/textedit_field.dart';

import '../../models/models.dart';
import '../../providers/event_form_provider.dart';
import 'widgets/pickdate.dart';

class NewEventScreen extends StatelessWidget {
  const NewEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          extendBody: true,
          appBar: const CustomAppBar(title: 'Nuevo Evento'),
          body: EventBackground(
            child: SingleChildScrollView(
              child: Column(children: [
                CardContainer(
                    child: Stack(
                  children: [
                    ChangeNotifierProvider(
                      create: (_) => EventFormProvider(),
                      child: const _EventForm(),
                    ),
                    SizedBox(height: size.height * 0.04),
                  ],
                ))
              ]),
            ),
          )),
    );
  }
}

class _EventForm extends StatelessWidget {
  const _EventForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventForm = Provider.of<EventFormProvider>(context);
    final userProvider = Provider.of<AuthService>(context, listen: false);
    final eventService = Provider.of<EventService>(context, listen: false);

    late List<String> autoCompleteData = ["1", "2", "3", "4", "5", "6"];
    final size = MediaQuery.of(context).size;
    return Form(
      key: eventForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        // CustomTextField(
        //   labelText: 'Titulo',
        //   hintText: 'titulo uno...',
        //   icon: Icons.label,
        //   onChanged: (value) {
        //     eventForm.title = value;
        //   },
        // ),

        // CustomTextField(
        //   labelText: 'Descripción',
        //   hintText: 'descripción del evento...',
        //   icon: Icons.description,
        //   onChanged: (value) {
        //     eventForm.description = value;
        //   },
        // ),

//https://www.youtube.com/watch?v=gDryje6oPrk&ab_channel=EasyApproach
        Autocomplete(
          optionsBuilder: (TextEditingValue textEditingValue) {
            // if (textEditingValue.text.isEmpty) {
            //   return const Iterable<String>.empty();
            // } else
            {
              return autoCompleteData.where((word) => word
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            }
          },
          onSelected: (String selectString) {},
          fieldViewBuilder:
              (context, controller, focusNode, onEdittingComplete) {
            return CustomTextField(
                onEditingComplete: onEdittingComplete,
                focusNode: focusNode,
                controller: eventForm.controller,
                labelText: 'Profesional',
                hintText: 'nombre del profesional',
                icon: Icons.person);
          },
        ),

        CustomTextField(
          controller: eventForm.controllerInitialDate,
          labelText: 'Fecha de inicio',
          hintText: 'aaaa-MMM-dd',
          icon: Icons.calendar_month_outlined,
          suffixIcon: IconButton(
              onPressed: () {
                pickDate(context);
              },
              icon: const Icon(Icons.edit_calendar_outlined)),

          // controller: eventForm.getFrom(),
        ),
        CustomTextField(
          controller: eventForm.controllerEndDate,
          labelText: 'Fecha de termino',
          hintText: 'aaaa-MMM-dd',
          icon: Icons.insert_invitation_rounded,
          suffixIcon: IconButton(
              onPressed: () {
                pickDate(context);
              },
              icon: const Icon(Icons.edit_calendar_outlined)),
        ),
        SizedBox(height: size.height * 0.025),
        ElevatedButton(
            onPressed: () {
              print('');
              eventService.newEvent(Event(
                patient: userProvider.userInfo.id,
                professional: int.parse(eventForm.controller.text),
                start: DateTime.parse(eventForm.controllerInitialDate.text),
                end: DateTime.parse(eventForm.controllerEndDate.text),
              ));
              print(eventForm.controller.text);
              // print(selectPro);
              // print(userProvider.userInfo.id);

              print(DateTime.parse(eventForm.controllerInitialDate.text));
              print(DateTime.parse(eventForm.controllerEndDate.text));
              FocusScope.of(context).unfocus();

              // print(eventForm.title!);
              // print(DateTime.parse(eventForm.controllerInitialDate.text));
              // print(DateTime.parse(eventForm.controllerEndDate.text));
              // print(eventForm.description!);
              // print(userProvider.userInfo.id);
            },
            child: const Text('Enviar Evento')),
        // PickCalendar()
      ]),
    );
    //Validaciones y manejo de referencia KEY.
  }
}
