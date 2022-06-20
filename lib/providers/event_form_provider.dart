import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? title;
  String? description;

  DateTimeRange? dateRange;
  TextEditingController controllerInitialDate = TextEditingController();
  TextEditingController controllerEndDate = TextEditingController();

  set dateToString(DateTimeRange dateRange) {
    controllerInitialDate.text =
        DateFormat('yyyy-MM-dd').format(dateRange.start);
    controllerEndDate.text = DateFormat('yyyy-MM-dd').format(dateRange.end);
    print(dateRange);
    print('controllertextInitial: ${controllerInitialDate.text}');
    print('controllertextEnd: ${controllerEndDate.text}');
    // title = '54321';
    notifyListeners();
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
