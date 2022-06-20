import 'package:flutter/material.dart';
import 'package:hydraflutter/screens/auth/login/widgets/card_container.dart';
import 'package:hydraflutter/screens/screens.dart';
import 'package:hydraflutter/themes/appthemes.dart';
import 'package:hydraflutter/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/event_form_provider.dart';

class NewEventScreen extends StatelessWidget {
  const NewEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print('gestor');
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          extendBody: true,
          appBar: const CustomAppBar(title: 'Nuevo Evento'),
          body: EventBackground(
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: size.height * 0.02),
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
    final size = MediaQuery.of(context).size;
    return Form(
      key: eventForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        const TextField(
          labelText: 'Titulo',
          hintText: 'titulo uno...',
          icon: Icons.label,
        ),

        const TextField(
          labelText: 'Descripción',
          hintText: 'descripción del evento...',
          icon: Icons.description,
        ),
        TextField(
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
        TextField(
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
        ElevatedButton(onPressed: () {}, child: const Text('Enviar Evento')),
        // PickCalendar()
      ]),
    );
    //Validaciones y manejo de referencia KEY.
  }

  Future pickDate(BuildContext context) async {
    final eventForm = Provider.of<EventFormProvider>(context, listen: false);
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 24 * 3)));

    final newDateRanger = await showDateRangePicker(
      context: context,
      initialDateRange: eventForm.dateRange ?? initialDateRange,
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

    eventForm.dateRange = newDateRanger;

    eventForm.dateToString = newDateRanger;

    print(eventForm.dateRange);
  }
}

class TextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;

  final Widget? suffixIcon;
  final TextEditingController? controller;

  const TextField({
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.suffixIcon,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: ,
      onChanged: (value) {
        // loginForm.email = value;
      },
      // initialValue: loginForm.email,
      controller: controller,
      autofocus: false,
      autocorrect: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
        hintText: hintText,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Escribe un título por favor.';
        }
        return null;
      },
    );
  }
}
