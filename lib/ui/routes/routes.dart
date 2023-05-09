import 'package:agenda_cumples/ui/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'auth': (_) => const AuthGate(),
  'home': (_) => const HomeScreen(),
  'cumples': (_) => const CumplesScreen(),
  'cumple-edit': (_) => const CumpleEditScreen(),
  'cumple-details': (_) => const CumpleDetailsScreen(),
  'estadisticas': (_) => const EstadisticasScreen(),
  'perfil': (_) => const ProfileScreen(),
};

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
