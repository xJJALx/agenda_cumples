import 'package:agenda_cumples/data/models/models.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  static User usuario = User(displayName: '');

  void initUser(User user) {
    usuario.displayName = user.displayName;
    usuario.uid = user.uid;
    usuario.email = user.email;
  }
}
