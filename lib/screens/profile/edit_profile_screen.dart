import 'package:flutter/material.dart';
import 'package:hydraflutter/models/models.dart';

import 'package:hydraflutter/screens/screens.dart';

import 'package:hydraflutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          extendBody: true,
          appBar: const CustomAppBar(title: 'Editar Perfil'),
          body: EventBackground(
            child: SingleChildScrollView(
              child: Column(children: [
                CardContainer(
                    child: Stack(
                  children: [
                    const _EditUserForm(),
                    // MultiProvider(providers: [
                    //   ChangeNotifierProvider(
                    //     create: (_) => UserFormProvider(),
                    //     child: const
                    //     _EditUserForm(),
                    //   ),
                    // ]),
                    SizedBox(height: size.height * 0.04),
                  ],
                ))
              ]),
            ),
          )),
    );
  }
}

class _EditUserForm extends StatelessWidget {
  const _EditUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userForm = Provider.of<UserFormProvider>(context);

    final userProvider = Provider.of<AuthService>(context, listen: false);

    TextEditingController nameController =
        TextEditingController(text: userProvider.userInfo.firstName ?? '');
    TextEditingController emailController =
        TextEditingController(text: userProvider.userInfo.email ?? '');
    TextEditingController lastNameController =
        TextEditingController(text: userProvider.userInfo.lastName ?? '');
    TextEditingController secondLastNameController =
        TextEditingController(text: userProvider.userInfo.secondLastName ?? '');
    TextEditingController rutController =
        TextEditingController(text: userProvider.userInfo.rut ?? '');
    TextEditingController phoneController = TextEditingController(
        text: userProvider.userInfo.phoneNumber.toString());

    final size = MediaQuery.of(context).size;
    return Form(
      key: key,
      // key: userForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        CustomTextField(
          labelText: 'Nombre',
          hintText: 'nombre...',
          icon: Icons.label,
          // initialValue: userProvider.userInfo.firstName ?? '',
          controller: nameController,
          onChanged: (value) {},
        ),

        CustomTextField(
          controller: lastNameController,
          labelText: 'Apellido Paterno',
          hintText: 'primer apellido...',
          icon: Icons.supervised_user_circle_outlined,
          onChanged: (value) {
            // eventForm.description = value;
          },
        ),
        CustomTextField(
          controller: secondLastNameController,
          labelText: 'Apellido Materno',
          hintText: 'segundo apellido...',
          icon: Icons.supervised_user_circle_rounded,
          onChanged: (value) {
            // eventForm.description = value;
          },
        ),
        CustomEmailField(
          controller: emailController,
          onChanged: (value) {},
          // onChanged: (value) => userForm.email = value,
        ),

        CustomTextField(
          controller: rutController,
          labelText: 'Rut',
          hintText: '0.000.000-0',
          keyboardType: TextInputType.number,
          icon: Icons.short_text_rounded,
          onChanged: (value) {
            // eventForm.description = value;
          },
        ),
        CustomTextField(
          controller: phoneController,
          labelText: 'Telefono',
          hintText: '+56222222222',
          keyboardType: TextInputType.phone,
          icon: Icons.numbers,
          onChanged: (value) {
            // eventForm.description = value;
          },
        ),

        SizedBox(height: size.height * 0.025),
        ElevatedButton(
            onPressed: () {
              // userProv

              userProvider.userUpdate(UserUpdate(
                firstName: nameController.text,
                lastName: lastNameController.text,
                secondLastName: secondLastNameController.text,
                email: emailController.text,
                rut: rutController.text,
                phoneNumber: phoneController.text,
              ));

              userProvider.usernameInfo(emailController.text);

              // userService.
              // eventService.newEvent(EventModel(
              //   title: eventForm.title!,
              //   start: DateTime.parse(eventForm.controllerInitialDate.text),
              //   end: DateTime.parse(eventForm.controllerEndDate.text),
              //   description: eventForm.description!,
              //   profile: userProvider.userInfo.id,

              FocusScope.of(context).unfocus();

              // print(eventForm.title!);
              // print(DateTime.parse(eventForm.controllerInitialDate.text));
              // print(DateTime.parse(eventForm.controllerEndDate.text));
              // print(eventForm.description!);
              // print(userProvider.userInfo.id);
            },
            child: const Text('Guardar cambios')),
        // PickCalendar()
      ]),
    );
    //Validaciones y manejo de referencia KEY.
  }
}
