import 'package:agenda_cumples/data/repositories/firebase_cumples_repository.dart';
import 'package:agenda_cumples/ui/providers/user_provider.dart';
import 'package:agenda_cumples/ui/utils/month_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:agenda_cumples/data/models/models.dart';
// import 'package:agenda_cumples/data/datasources/cumples_datasource.dart';

// * Para manejar que cumpleaños es el primero del mes en una lista, creamos un mapa
// * con el cumple y una propiedad bool

class CumpleProvider extends ChangeNotifier {
  final DateTime _today = DateTime.now();
  final Map<String, double> _monthStatistics = {};
  late Cumple _cumple;
  Map<Cumple, bool> _cumples = {};
  List<Cumple> _cumplesResp = [];
  List<Cumple> _nearCumples = [];
  List<Cumple> _searchCumples = [];
  FirebaseCumplesRepository repository = FirebaseCumplesRepository();
  int _indexCumpleInit = 0;
  bool _isSelectedSwiper = false;

  Map<Cumple, bool> get allCumples => _cumples;
  Map<String, double> get statistics => _monthStatistics;
  List<Cumple> get nearCumples => _nearCumples;
  List<Cumple> get searchCumples => _searchCumples;
  DateTime get today => _today;
  Cumple get cumple => _cumple;
  int get indexCumple => _indexCumpleInit;
  bool get isSelectedSwiper => _isSelectedSwiper;

  int countCumples() => _cumplesResp.length;

  CumpleProvider() {
    getCumples();
  }

  set cumple(Cumple value) {
    _cumple = value;
    notifyListeners();
  }

  set isSelectedSwiper(bool value) {
    _isSelectedSwiper = value;
    notifyListeners();
  }

  getCumples() async {
    // await Future.delayed(const Duration(milliseconds: 500), () => _cumplesResp = cumplesData);
    _cumplesResp = await repository.getCumplesFirebase(UserProvider.usuario.uid);

    sortCumples();
    getNearCumples();
    setMonthTitle();
    getMonthStatistics();

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

  void getMonthStatistics() {
    List<String> months = [];
    _monthStatistics.clear();

    for (var cumple in _cumplesResp) {
      String month = getMonth(cumple.date.month);
      months.add(month);
    }

    for (var month in months) {
      _monthStatistics[month] = !_monthStatistics.containsKey(month) ? (1) : (_monthStatistics[month]! + 1);
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

  void searchCumple(String query) {
    if (query.isEmpty) {
      _searchCumples = [];
    } else {
      _searchCumples = [..._cumplesResp.where((cumple) => cumple.name.toLowerCase().contains(query.toLowerCase()))];

      if (_searchCumples.isEmpty) _searchCumples = [Cumple(name: 'No hay coincidencias', date: DateTime.now())];
    }
    notifyListeners();
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
    _indexCumpleInit = indexCumple; // Guardamos la posición del cumple mas cercano a mostrar. Util para el swiper.

    // Control si no hay cumple cercano
    indexCumple == -1 ? numCumples = _cumplesResp.length : numCumples = indexCumple;

    _cumples.forEach((key, value) {
      if (value == true && key.date.month < nearMonth) numTitles++;
    });

    pixels = (numCumples * cardHeight) + (numTitles * titleHeight);

    return pixels;
  }

  Future<bool> updateCumple(String name, DateTime date) async {
    final DateTime dateFormat = DateTime(date.year, date.month, date.day, 12);
    Cumple newCumple = Cumple(id: cumple.id, name: name, date: dateFormat);
    _cumple = newCumple;

    final resp = await repository.updateCumpleFirebase(newCumple, UserProvider.usuario.uid);
    getCumples();

    return resp;
  }

  Future<String> addCumple(String name, DateTime date) async {
    final DateTime dateFormat = DateTime(date.year, date.month, date.day, 12);
    Cumple cumple = Cumple(name: name, date: dateFormat);
    String resp = '';

    await repository.addCumpleFirebase(cumple, UserProvider.usuario.uid).then((id) {
      _cumple = cumple;
      _cumple.id = id;
      _cumples.putIfAbsent(cumple, () => false);
      resp = id;
    });

    getCumples();

    return resp;
  }

  // Además de resetear el cumpleaños sirve para darle un valor inicial
  void clearCumple() {
    Cumple cumpleAux = Cumple(name: '', date: DateTime(1900, 1, 1));
    cumple = cumpleAux;
    notifyListeners();
  }

  void clearSearchCumple() {
    _searchCumples = [];
    notifyListeners();
  }

  int getAge() {
    int years = _today.year - _cumple.date.year;
    int months = _today.month - _cumple.date.month;

    if (months < 0 && years > 0 || (months == 0 && _today.day < cumple.date.day)) years--;

    return years;
  }

  String getMostCommonMonth() {
    String common = '';
    double aux = 0;

    _monthStatistics.forEach((key, value) {
      if (aux < value) {
        common = key;
        aux = value;
      }
    });

    return common;
  }

  int getMostCommonDay() {
    final Map<int, int> dayStatistics = {};
    List<int> days = [];
    int common = 0;
    int aux = 0;

    for (var cumple in _cumplesResp) {
      int day = cumple.date.day;
      days.add(day);
    }

    for (var day in days) {
      dayStatistics[day] = !dayStatistics.containsKey(day) ? (1) : (dayStatistics[day]! + 1);
    }

    dayStatistics.forEach((key, value) {
      if (aux < value) {
        common = key;
        aux = value;
      }
    });

    return common;
  }
}
