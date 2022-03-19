import 'package:agenda_cumples/data/repositories/firebase_cumples_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:agenda_cumples/data/models/models.dart';
// import 'package:agenda_cumples/data/datasources/cumples_datasource.dart';

// * Para manejar que cumpleaños es el primero del mes en una lista, creamos un mapa
// * con el cumple y una propiedad bool

class CumpleProvider extends ChangeNotifier {
  final DateTime _today = DateTime.now();
  Map<Cumple, bool> _cumples = {};
  List<Cumple> _cumplesResp = [];
  List<Cumple> _nearCumples = [];
  FirebaseCumplesRepository repository = FirebaseCumplesRepository();

  Map<Cumple, bool> get allCumples => _cumples;
  List<Cumple> get nearCumples => _nearCumples;
  DateTime get today => _today;

  CumpleProvider() {
    getCumples();
  }

  getCumples() async {
    // await Future.delayed(const Duration(milliseconds: 500), () => _cumplesResp = cumplesData);
    _cumplesResp = await repository.getCumplesFirebase();

    sortCumples();
    getNearCumples();
    setMonthTitle();

    notifyListeners();
  }

  void setMonthTitle() {
    _cumples = {};
    bool firstCumpleOfMonth = false;
    int monthAux = 0;

    for (var cumple in _cumplesResp) {
      if (monthAux != cumple.date.month) {
        monthAux = cumple.date.month;
        firstCumpleOfMonth = true;
      } else {
        firstCumpleOfMonth = false;
      }
      firstCumpleOfMonth ? _cumples.putIfAbsent(cumple, () => true) : _cumples.putIfAbsent(cumple, () => false);
    }
  }

  // Para ordenar correctamente se debe hacer en dos pasos empezando por el dato mas pequeño (día en este caso)
  void sortCumples() {
    _cumplesResp.sort((a, b) => a.date.day.compareTo(b.date.day));
    _cumplesResp.sort((a, b) => a.date.month.compareTo(b.date.month));
    notifyListeners();
  }

  void getNearCumples() async {
    var nextMonth = 1;
    _nearCumples = [];

    // Control mes actual
    if (_nearCumples.isEmpty) {
      _nearCumples = [..._cumplesResp.where((cumple) => cumple.date.month == _today.month && cumple.date.day >= _today.day)];
    }

    // Cumple más cerano
    while (_nearCumples.isEmpty && nextMonth <= 12) {
      _nearCumples = [..._cumplesResp.where((cumple) => cumple.date.month == _today.month + nextMonth)];
      nextMonth++;
    }

    notifyListeners();

    // var nearCumples = _cumples.map((cumple) {
    //   if (cumple.month == _today.month) return cumple;
    // }).toList();
  }

  int goToActualMonth() {
    var pixels = 0;
    var separators = (_today.month - 1) * 60; // 60 height aprox title of month

    for (var i = 0; i < _cumplesResp.length; i++) {
      if (_cumplesResp[i].date.month == _today.month) {
        pixels = 220 * i + separators; // 220 height card cumple
        break;
      }
    }

    return pixels;
  }

  void updateCumpleTest() async {
    // Cumple cumple = Cumple(name: name, date: date);
    // await repository.addCumpleFirebase(cumple).then((value) => _cumples.putIfAbsent(cumple, () => false));
    // getCumples();
  }

  void addCumple(String name, DateTime date) async {
    final DateTime dateFormat = date.add(const Duration(hours: 12));
    Cumple cumple = Cumple(name: name, date: dateFormat);

    await repository.addCumpleFirebase(cumple).then((value) => _cumples.putIfAbsent(cumple, () => false));
    getCumples();
  }
}
