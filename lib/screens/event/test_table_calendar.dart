import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hydraflutter/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../providers/providers.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventFormProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'NewCalendar'),
      body: TableCalendar(
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekVisible: true,
        focusedDay: eventProvider.focusedDay,
        firstDay: DateTime(2018),
        lastDay: DateTime(2027),
        calendarFormat: eventProvider.format,
        onFormatChanged: (CalendarFormat newFormat) {
          eventProvider.format = newFormat;
          eventProvider.newNotify();
        },
        //Day Changed
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          eventProvider.selectedDay = selectDay;
          eventProvider.focusedDay = focusDay;
          eventProvider.newNotify();
          print(eventProvider.focusedDay);
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(eventProvider.selectedDay, date);
        },
        enabledDayPredicate: (DateTime val) =>
            val.weekday == 1 ||
            val.day == DateTime.now().day ||
            val.weekday == 2 ||
            val.weekday == 3 ||
            val.weekday == 4 ||
            val.weekday == 5,
        //Calendar Styling
        calendarStyle: CalendarStyle(
            defaultTextStyle: const TextStyle(fontWeight: FontWeight.w500),
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary, // circle color
                shape: BoxShape.circle),
            selectedTextStyle: const TextStyle(color: Colors.black),
            todayTextStyle: const TextStyle(color: Colors.black),
            todayDecoration: const BoxDecoration(
                color: Colors.greenAccent, shape: BoxShape.circle)),
        headerStyle: const HeaderStyle(
            titleCentered: true, formatButtonShowsNext: false),
      ),
    );
  }
}
