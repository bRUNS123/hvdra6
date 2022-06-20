import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  TextEditingController controller = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    final String valid = '${formKey.currentState?.validate()}';
    debugPrint('Valido: $valid');
    return formKey.currentState?.validate() ?? false;
  }

  set emailRemember(String emailRemember) {
    email = emailRemember;
    controller.text = emailRemember;
    notifyListeners();
  }
}
