import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String secondLastName = '';
  String email = '';
  String rut = '';

  String phoneNumber = '';
  // TextEditingController emailController = TextEditingController();
  // TextEditingController nameController =
  //     TextEditingController(text: 'provider aqui');
  // TextEditingController lastNameController = TextEditingController();
  // TextEditingController secondLastNameController = TextEditingController();
  // TextEditingController rutController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();

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

  // set emailRemember(String emailRemember) {
  //   email = emailRemember;
  //   controller.text = emailRemember;
  //   notifyListeners();
  // }
}
