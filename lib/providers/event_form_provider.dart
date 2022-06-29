import 'package:flutter/material.dart';
import 'package:hydraflutter/services/event_service.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class EventFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  String? title;
  String? description;

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

// String getControllerStart {
//  if (dateRange == null) {
//       return '';
// } else {
//   controller = DateFormat('yyyy/MM/dd').format(dateRange!.start);
// }

  // String getFrom() {
  //   if (dateRange == null) {
  //     return '';
  //   } else {
  //     return DateFormat('yyyy/MM/dd').format(dateRange!.start);
  //   }
  // }

  // String getUntil() {
  //   if (dateRange == null) {
  //     return '';
  //   } else {
  //     return DateFormat('yyyy/MM/dd').format(dateRange!.end);
  //   }
  // }

  // TextEditingController controller = TextEditingController();

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  // set isLoading(bool value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  // bool isValidForm() {
  //   final String valid = '${formKey.currentState?.validate()}';
  //   debugPrint('Valido: $valid');
  //   return formKey.currentState?.validate() ?? false;
  // }
}
