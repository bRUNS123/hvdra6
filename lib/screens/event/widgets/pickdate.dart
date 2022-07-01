import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/models.dart';
import '../../../themes/colors.dart';

Future editDate(BuildContext context, TextEditingController? controller,
    TextEditingController? controllerEnd,
    [Event? event]) async {
  var initialDate = DateTimeRange(
    start: event?.start != null ? event!.start : DateTime.now(),
    end: event?.end != null
        ? event!.start
        : DateTime.now().add(const Duration(days: 7)),
  );

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
