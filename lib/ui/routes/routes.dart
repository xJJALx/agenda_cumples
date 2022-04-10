import 'package:flutter/material.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomeScreen(),
  'cumples': (_) => const CumplesScreen(),
  'cumple-edit': (_) => const CumpleEditScreen(),
  'cumple-details': (_) => const CumpleDetailsScreen(),
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
