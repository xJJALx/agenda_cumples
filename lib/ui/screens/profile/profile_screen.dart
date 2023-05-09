import 'package:agenda_cumples/ui/providers/providers.dart';
import 'package:agenda_cumples/ui/screens/profile/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final isDark = context.watch<ThemeProvider>().isDark;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [ 0.0, 1.0 ],
          colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 204, 173, 247)],
        ),
      ),
      child:Scaffold(
        backgroundColor: isDark ? null: Colors.transparent,
        body: const SafeArea(
          child:  Profile(),
        ),
      ),
    );
  }
}
