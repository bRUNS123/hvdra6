import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../providers/login_form_provider.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({
    Key? key,
  }) : super(key: key);

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool _isChecked = false;

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Recuerdame',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                  width: 2,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              ),
              value: _isChecked,
              onChanged: _handleRememberme,
            ),
          ),
        ),
      ],
    );
  }

  void _loadUserEmailPassword() async {
    final loginForm = Provider.of<LoginFormProvider>(context, listen: false);
    const storage = FlutterSecureStorage();

    try {
      final String? emailRemember = await storage.read(key: 'email');
      final String? boxRemember = await storage.read(key: 'rememberMe');

      _isChecked = boxRemember == 'true' ? true : false;
      loginForm.emailRemember = emailRemember!;

      setState(() {});
    } catch (e) {
      // print(e);
    }
  }

  void _handleRememberme(bool? value) async {
    final loginForm = Provider.of<LoginFormProvider>(context, listen: false);
    const storage = FlutterSecureStorage();

    _isChecked = value!;
    if (!_isChecked) {
      await storage.delete(key: 'email');
      await storage.delete(key: 'rememberMe');
    } else {
      await storage.write(key: 'email', value: loginForm.email);
      await storage.write(key: 'rememberMe', value: value ? 'true' : 'false');
    }

    setState(() {
      _isChecked = value;
    });
  }
}
