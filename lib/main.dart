import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydraflutter/providers/event_form_provider.dart';
import 'package:hydraflutter/providers/user_form_provider.dart';

import 'package:hydraflutter/routes/routes.dart';
import 'package:hydraflutter/screens/auth/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'bloc/blocs.dart';
import 'generated/l10n.dart';

import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) =>
              ThemeBloc(LocalStorage.prefs.getString('themeName') ?? 'dark')),
      BlocProvider(create: (_) => NavigationBarBloc()),
      BlocProvider(
          create: (_) => LanguageBloc(
              LocalStorage.prefs.getString('languageCode') ?? 'es')),
    ],
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        // ChangeNotifierProvider(create: (_) => EventFormProvider())
        ChangeNotifierProvider(create: (_) => UserFormProvider()),

        ChangeNotifierProvider(create: (_) => EventService()),
        ChangeNotifierProvider(create: (_) => EventFormProvider()),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final RouteGenerator _routeGenerator = RouteGenerator();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificationsService.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'HVDRAFLUTTER',
      initialRoute: 'checking',
      onGenerateRoute: _routeGenerator.onGenerateRoute,
      theme: context.watch<ThemeBloc>().state.theme,
      home: const LoginScreen(),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      locale: context.watch<LanguageBloc>().state.locale,
    );
  }
}
