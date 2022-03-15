import 'package:agenda_cumples/data/repositories/firebase_cumples_repository.dart';
import 'package:agenda_cumples/presentation/providers/cumple_provider.dart';
import 'package:flutter/material.dart';
import 'package:agenda_cumples/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

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
      initialRoute: 'home',
      routes: appRoutes,
    );
  }
}
