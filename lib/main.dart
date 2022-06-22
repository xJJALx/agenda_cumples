import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/data/repositories/firebase_cumples_repository.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseCumplesRepository.initializeApp();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CumpleProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..initPrefs()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda cumpleaños',
      theme: Provider.of<ThemeProvider>(context).getTheme,
      initialRoute: 'auth',
      routes: appRoutes,
    );
  }
}
