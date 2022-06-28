// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../providers/providers.dart';
// import '../../../themes/colors.dart';

// Future pickDate(BuildContext context) async {
//   final eventForm = Provider.of<EventFormProvider>(context, listen: false);
//   final initialDateRange = DateTimeRange(
//       start: DateTime.now(),
//       end: DateTime.now().add(const Duration(hours: 24 * 3)));

//   final newDateRanger = await showDateRangePicker(
//     context: context,
//     initialDateRange: eventForm.dateRange ?? initialDateRange,
//     firstDate: DateTime(2022),
//     lastDate: DateTime(DateTime.now().year + 5),
//     builder: (context, child) {
//       return Theme(
//         data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.dark(
//                 onPrimary: Colors.black, // selected text color
//                 onSurface: dateColor, // default text color
//                 primary: Colors.greenAccent // circle color
//                 ),
//             // dialogBackgroundColor: Colors.black54,
//             textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(
//                     textStyle: TextStyle(
//                         color: Colors.green[700],
//                         fontWeight: FontWeight.normal,
//                         fontSize: 14,
//                         fontFamily: 'Quicksand'),
//                     primary:
//                         Colors.lightGreen[200], // color of button's letters
//                     backgroundColor: Colors.black54, // Background color
//                     shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             color: Colors.transparent,
//                             width: 1,
//                             style: BorderStyle.solid),
//                         borderRadius: BorderRadius.circular(50))))),
//         child: child!,
//       );
//     },
//   );
//   if (newDateRanger == null) return;

//   // eventForm.dateRange = newDateRanger;
//   eventForm.dateToString = newDateRanger;
// }
