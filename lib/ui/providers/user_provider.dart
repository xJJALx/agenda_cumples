import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/data/repositories/firebase_cumples_repository.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  static User usuario = User(displayName: '');
  final FirebaseCumplesRepository _repository = FirebaseCumplesRepository();
  String _uid = '';

  get displayName => usuario.displayName;
  get ocupacion => usuario.ocupacion;

  void setUid(String id) {
    _uid = id;
    usuario.uid = _uid;
    loadUser();
  }

  loadUser() async {
    await _repository.getInfoUser(_uid).then((info) {
      usuario.displayName = info.displayName;
      usuario.ocupacion = info.ocupacion;
      usuario.docId = info.docId;
    });
    notifyListeners();
  }

  addInfoUser() async {
    _repository.addInfoUserFirebase(usuario).then((value) => usuario.docId = value);
    notifyListeners();
  }

  updateInfoUser() {
    _repository.updateInfoUserFirebase(usuario);
    notifyListeners();
  }
}
