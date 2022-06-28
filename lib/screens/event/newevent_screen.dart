// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// import 'package:hydraflutter/screens/screens.dart';
// import 'package:hydraflutter/widgets/widgets.dart';
// import 'package:hydraflutter/services/services.dart';

// import 'package:provider/provider.dart';

// // import 'package:hydraflutter/screens/widgets/textedit_field.dart';

// import '../../providers/event_form_provider.dart';
// import '../../themes/colors.dart';

// class NewEventScreen extends StatelessWidget {
//   const NewEventScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//           extendBody: true,
//           appBar: const CustomAppBar(title: 'Nuevo Evento'),
//           body: EventBackground(
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 CardContainer(
//                     child: Stack(
//                   children: [
//                     ChangeNotifierProvider(
//                       create: (_) => EventFormProvider(),
//                       child: const _EventForm(),
//                     ),
//                     SizedBox(height: size.height * 0.04),
//                   ],
//                 ))
//               ]),
//             ),
//           )),
//     );
//   }
// }

// class _EventForm extends StatelessWidget {
//   const _EventForm({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final eventForm = Provider.of<EventFormProvider>(context);
//     final TextEditingController controllers =
//         TextEditingController(text: '123');

//     late List<String> autoCompleteData = ["1", "2", "3", "4", "5", "6"];
//     final size = MediaQuery.of(context).size;

//     return Form(
//       key: eventForm.formKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Column(children: [
//         // CustomTextField(
//         //   labelText: 'Titulo',
//         //   hintText: 'titulo uno...',
//         //   icon: Icons.label,
//         //   onChanged: (value) {
//         //     eventForm.title = value;
//         //   },
//         // ),

//         // CustomTextField(
//         //   labelText: 'Descripción',
//         //   hintText: 'descripción del evento...',
//         //   icon: Icons.description,
//         //   onChanged: (value) {
//         //     eventForm.description = value;
//         //   },
//         // ),

// //https://www.youtube.com/watch?v=gDryje6oPrk&ab_channel=EasyApproach
//         TypeAheadFormField<String?>(
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Escribe un parametro por favor.';
//             }
//             return null;
//           },
//           onSuggestionSelected: (String? val) {
//             controllers.text = val!;
//           },
//           itemBuilder: (context, String? val) => ListTile(title: Text(val!)),
//           suggestionsCallback: (pattern) => autoCompleteData.where(
//             (val) => val.toLowerCase().contains(pattern.toLowerCase()),
//           ),
//           getImmediateSuggestions: true,
//           hideSuggestionsOnKeyboardHide: true,
//           hideOnEmpty: false,
//           noItemsFoundBuilder: (context) => const Padding(
//             padding: EdgeInsets.all(8),
//             child: Text('No se ha encontrado.'),
//           ),
//           textFieldConfiguration: TextFieldConfiguration(
//             decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                     color: Theme.of(context)
//                         .colorScheme
//                         .secondary
//                         .withOpacity(0.5)),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   width: 2,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//               ),
//               labelText: 'Profesional',
//               labelStyle: const TextStyle(color: Colors.grey, fontSize: 22),
//               hintText: 'nombre del profesional',
//               icon: Icon(
//                 Icons.person,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//             ),
//             controller: controllers,
//             keyboardType: TextInputType.name,
//           ),
//         ),

//         // Autocomplete(
//         //   optionsBuilder: (TextEditingValue textEditingValue) {
//         //     // if (textEditingValue.text.isEmpty) {
//         //     //   return const Iterable<String>.empty();
//         //     // } else
//         //     {
//         //       return autoCompleteData.where((word) => word
//         //           .toLowerCase()
//         //           .contains(textEditingValue.text.toLowerCase()));
//         //     }
//         //   },
//         //   onSelected: (String selectString) {},
//         //   fieldViewBuilder:
//         //       (context, controller, focusNode, onEdittingComplete) {
//         //     return CustomTextField(
//         //         onEditingComplete: onEdittingComplete,
//         //         focusNode: focusNode,
//         //         controller: eventForm.controller,
//         //         labelText: 'Profesional',
//         //         hintText: 'nombre del profesional',
//         //         icon: Icons.person);
//         //   },
//         // ),

//         CustomTextField(
//           controller: eventForm.controllerInitialDate,
//           labelText: 'Fecha de inicio',
//           hintText: 'aaaa-MMM-dd',
//           icon: Icons.calendar_month_outlined,
//           suffixIcon: IconButton(
//               onPressed: () {
//                 editDates(context);
//               },
//               icon: const Icon(Icons.edit_calendar_outlined)),

//           // controller: eventForm.getFrom(),
//         ),
//         CustomTextField(
//           controller: eventForm.controllerEndDate,
//           labelText: 'Fecha de termino',
//           hintText: 'aaaa-MMM-dd',
//           icon: Icons.insert_invitation_rounded,
//           suffixIcon: IconButton(
//               onPressed: () {
//                 editDates(context);
//               },
//               icon: const Icon(Icons.edit_calendar_outlined)),
//         ),
//         SizedBox(height: size.height * 0.025),
//         ElevatedButton(
//             onPressed: () {
//               // eventService.newEvent(Event(
//               //   patient: userProvider.userInfo.id,
//               //   professional: int.parse(controllers.text),
//               //   start: DateTime.parse(eventForm.controllerInitialDate.text),
//               //   end: DateTime.parse(eventForm.controllerEndDate.text),
//               // ));
//               print(controllers.text);
//               // print(selectPro);
//               // print(userProvider.userInfo.id);

//               // eventForm.refreshEvents();
//               Navigator.pop;
//             },
//             child: const Text('Enviar Evento')),
//         // PickCalendar()
//       ]),
//     );
//     //Validaciones y manejo de referencia KEY.
//   }
// }

// // Future editDates(
// //   BuildContext context,
// // ) async {
// //   final initialDateRange = DateTimeRange(
// //       start: DateTime.now(),
// //       end: DateTime.now().add(const Duration(hours: 24 * 3)));

// //   final eventForm = Provider.of<EventFormProvider>(context, listen: false);

// //   final newDateRanger = await showDateRangePicker(
// //     context: context,
// //     initialDateRange: initialDateRange,
// //     firstDate: DateTime(2022),
// //     lastDate: DateTime(DateTime.now().year + 5),
// //     builder: (context, child) {
// //       return Theme(
// //         data: Theme.of(context).copyWith(
// //             colorScheme: ColorScheme.dark(
// //                 onPrimary: Colors.black, // selected text color
// //                 onSurface: dateColor, // default text color
// //                 primary: Colors.greenAccent // circle color
// //                 ),
// //             // dialogBackgroundColor: Colors.black54,
// //             textButtonTheme: TextButtonThemeData(
// //                 style: TextButton.styleFrom(
// //                     textStyle: TextStyle(
// //                         color: Colors.green[700],
// //                         fontWeight: FontWeight.normal,
// //                         fontSize: 14,
// //                         fontFamily: 'Quicksand'),
// //                     primary:
// //                         Colors.lightGreen[200], // color of button's letters
// //                     backgroundColor: Colors.black54, // Background color
// //                     shape: RoundedRectangleBorder(
// //                         side: const BorderSide(
// //                             color: Colors.transparent,
// //                             width: 1,
// //                             style: BorderStyle.solid),
// //                         borderRadius: BorderRadius.circular(50))))),
// //         child: child!,
// //       );
// //     },
// //   );
// //   if (newDateRanger == null) return;
// //   eventForm.dateToString = newDateRanger;
// //   // controller!.text = DateFormat('yyyy-MM-dd').format(newDateRanger.start);
// //   // controllerEnd!.text = DateFormat('yyyy-MM-dd').format(newDateRanger.end);
// // }
