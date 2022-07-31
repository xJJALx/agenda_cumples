import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/ui/providers/user_provider.dart';
import 'package:agenda_cumples/ui/screens/home/home_screen.dart';

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
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 220,
                    height: 220,
                    child: Image.asset("assets/icon/icon.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:50),
                    child: Text(
                      action == AuthAction.signIn 
                      ? 'Bienvenido, inicia sesión para continuar.' 
                      : 'Bienvenido, registrate para crear una cuenta.',
                      style: const TextStyle(fontSize: 20,),
                    ),
                  ),
                ],
              );
            },
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(clientId: "666245894893-1tnui02f2uoiaus92bqh8pdm5c0ql2mo.apps.googleusercontent.com"),
            ],
          );
        }

        Provider.of<UserProvider>(context,listen: false).setUid(snapshot.data!.uid);

        return const HomeScreen();
      },
    );


  }
}
