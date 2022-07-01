import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/ui/providers/user_provider.dart';
import 'package:agenda_cumples/ui/screens/home/home_screen.dart';
import 'package:agenda_cumples/data/models/models.dart' as cumple_user;

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn 
                  ? 'Bienvenido, inicia sesión para continuar.' 
                  : 'Bienvenido, registrate para crear una cuenta.',
                ),
              );
            },
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(clientId: "666245894893-1tnui02f2uoiaus92bqh8pdm5c0ql2mo.apps.googleusercontent.com"),
            ],
          );
        }

        cumple_user.User userData = cumple_user.User(
          uid: snapshot.data!.uid,
          displayName: snapshot.data!.displayName ?? 'Anónimo', 
          email: snapshot.data!.email ?? 'email');

        Provider.of<UserProvider>(context).initUser(userData);

        return const HomeScreen();
      },
    );
  }
}