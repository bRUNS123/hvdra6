import 'package:flutter/material.dart';
import 'package:hydraflutter/services/event_service.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class EventFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  String? title;
  String? description;
  int? profesionalId;

  DateTimeRange? dateRange;
  DateTimeRange? dateEditRange;

  TextEditingController controllerInitialDate = TextEditingController(text: '');
  TextEditingController controllerEndDate = TextEditingController(text: '');
  TextEditingController controller = TextEditingController();
  TextEditingController controllers = TextEditingController(text: '');

  final Object? selectString = {};
  // TextEditingController controllerComplete = TextEditingController();

  set dateToString(DateTimeRange dateRange) {
    controllerInitialDate.text =
        DateFormat('yyyy-MM-dd').format(dateRange.start);
    controllerEndDate.text = DateFormat('yyyy-MM-dd').format(dateRange.end);

    // title = '54321';
    notifyListeners();
  }

  List<Event>? eventModels;

  Future<List<Event>> getEventsById() async {
    if (eventModels != null) {
      return eventModels!;
    }
    var service = EventService();
    eventModels = await service.getEventsById();
    notifyListeners();
    return eventModels!;
  }

  Future<List<Event>> refreshEvents() async {
    var service = EventService();
    eventModels = await service.getEventsById();
    notifyListeners();
    return eventModels!;
  }

  // bool isValidForm() {
  //   final String valid = '${formKey.currentState?.validate()}';
  //   debugPrint('Valido: $valid');
  //   return formKey.currentState?.validate() ?? false;
  // }
}
