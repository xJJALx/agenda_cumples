import 'package:agenda_cumples/data/repositories/firebase_cumples_repository.dart';
import 'package:agenda_cumples/ui/utils/month_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:agenda_cumples/data/models/models.dart';
// import 'package:agenda_cumples/data/datasources/cumples_datasource.dart';

// * Para manejar que cumpleaños es el primero del mes en una lista, creamos un mapa
// * con el cumple y una propiedad bool
// TODO Buscador
class CumpleProvider extends ChangeNotifier {
  final DateTime _today = DateTime.now();
  final Map<String, double> _statistics = {};
  Map<Cumple, bool> _cumples = {};
  List<Cumple> _cumplesResp = [];
  List<Cumple> _nearCumples = [];
  FirebaseCumplesRepository repository = FirebaseCumplesRepository();
  late Cumple _cumple;

  Map<Cumple, bool> get allCumples => _cumples;
  Map<String, double> get statistics => _statistics;
  List<Cumple> get nearCumples => _nearCumples;
  DateTime get today => _today;
  Cumple get cumple => _cumple;

   int countCumples() => _cumplesResp.length;

  CumpleProvider() {
    getCumples();
  }

  set cumple(Cumple value) {
    _cumple = value;
    notifyListeners();
  }

  getCumples() async {
    // await Future.delayed(const Duration(milliseconds: 500), () => _cumplesResp = cumplesData);
    _cumplesResp = await repository.getCumplesFirebase();

    sortCumples();
    getNearCumples();
    setMonthTitle();
    getStatistics();

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

  void getStatistics() {
    List<String> months = [];
    _statistics.clear();

    for (var cumple in _cumplesResp) {
      String month = getMonth(cumple.date.month);
      months.add(month);
    }

    for (var key in months) {
      _statistics[key] = !_statistics.containsKey(key) ? (1) : (_statistics[key]! + 1);
    }
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

  double scrollActualCumple() {
    double pixels = 0;
    double numTitles = (_today.month - 1) * 60; // 60 height aprox title of month

    for (var i = 0; i < _today.month; i++) {
      if (_cumplesResp[i].date.month == _today.month) {
        pixels = 220 * i + numTitles; // 220 height card cumple
      }
    }

    return pixels;
  }

  double scrollNextCumple() {
    double pixels = 0;
    double numTitles = 0;
    double titleHeight = 43;
    double cardHeight = 220;
    int numCumples = 0;

    final int nearMonth = _nearCumples.isEmpty ? _today.month : _nearCumples.first.date.month;
    final int indexCumple = _cumplesResp.indexWhere((cumple) => cumple.date.month == nearMonth);

    // Control si no hay cumple cercano
    indexCumple == -1 ? numCumples = 99 : numCumples = indexCumple;

    _cumples.forEach((key, value) {
      if (value == true && key.date.month < nearMonth) numTitles++;
    });

    pixels = (numCumples * cardHeight) + (numTitles * titleHeight);

    return pixels;
  }

  Future<bool> updateCumple(String name, DateTime date) async {
    final DateTime dateFormat = DateTime(date.year, date.month, date.day, 12);
    Cumple newCumple = Cumple(id: cumple.id, name: name, date: dateFormat);

    final resp = await repository.updateCumpleFirebase(newCumple);

    getCumples();

    return resp;
  }

  Future<String> addCumple(String name, DateTime date) async {
    final DateTime dateFormat = DateTime(date.year, date.month, date.day, 12);
    Cumple cumple = Cumple(name: name, date: dateFormat);
    String resp = '';

    await repository.addCumpleFirebase(cumple).then((id) {
      _cumple = cumple;
      _cumple.id = id;
      _cumples.putIfAbsent(cumple, () => false);
      resp = id;
    });

    getCumples();

    return resp;
  }

  void clearCumple() {
    Cumple cumpleAux = Cumple(name: '', date: DateTime(1900, 1, 1));
    cumple = cumpleAux;
    notifyListeners();
  }

  int getAge() {
    int years = _today.year - _cumple.date.year;
    int months = _today.month - _cumple.date.month;

    if (months < 0 && years > 0 || (months == 0 && _today.day < _today.day)) years--;

    return years;
  }


  String getMostCommonMonth() {
    String common = '';
    double aux = 0;

    _statistics.forEach((key, value) {
      if (aux < value) {
        common = key;
        aux = value;
      }
    });

    return common;
  }

// TODO: Revisar, parece que falla
  int getMostCommonDay() {
    int common = 0;
    int aux = 0;

    for (var cumple in _cumplesResp) {
      if (aux < cumple.date.day) common = cumple.date.day;
    }

    return common;
  }
}
