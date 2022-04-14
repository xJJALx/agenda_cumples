import 'dart:ui';

String getMonth(int monthNumber) {
  late String month;
  switch (monthNumber) {
    case 1:
      month = "Enero";
      break;
    case 2:
      month = "Febrero";
      break;
    case 3:
      month = "Marzo";
      break;
    case 4:
      month = "Abril";
      break;
    case 5:
      month = "Mayo";
      break;
    case 6:
      month = "Junio";
      break;
    case 7:
      month = "Julio";
      break;
    case 8:
      month = "Agosto";
      break;
    case 9:
      month = "Septiembre";
      break;
    case 10:
      month = "Octubre";
      break;
    case 11:
      month = "Noviembre";
      break;
    case 12:
      month = "Diciembre";
      break;
  }
  return month;
}

List<Color> getColors(Map map, List colorList) {
  List<Color> colors = [];

  for (var key in map.keys) {
    switch (key) {
      case 'Enero':
        colors.add(colorList[0]);
        break;
      case 'Febrero':
        colors.add(colorList[1]);
        break;
      case 'Marzo':
        colors.add(colorList[2]);
        break;
      case 'Abril':
        colors.add(colorList[3]);
        break;
      case 'Mayo':
        colors.add(colorList[4]);
        break;
      case 'Junio':
        colors.add(colorList[5]);
        break;
      case 'Julio':
        colors.add(colorList[6]);
        break;
      case 'Agosto':
        colors.add(colorList[7]);
        break;
      case 'Septiembre':
        colors.add(colorList[8]);
        break;
      case 'Octubre':
        colors.add(colorList[9]);
        break;
      case 'Noviembre':
        colors.add(colorList[10]);
        break;
      case 'Diciembre':
        colors.add(colorList[11]);
        break;
    }
  }

  return colors;
}

List<List<Color>> getGradientColors(Map map, List colorList) {
  List<List<Color>> gradientColors = [];

  for (var key in map.keys) {
    switch (key) {
      case 'Enero':
        gradientColors.add([colorList[0], colorList[1]]);
        break;
      case 'Febrero':
        gradientColors.add([colorList[1], colorList[2]]);
        break;
      case 'Marzo':
        gradientColors.add([colorList[2], colorList[3]]);
        break;
      case 'Abril':
        gradientColors.add([colorList[3], colorList[4]]);
        break;
      case 'Mayo':
        gradientColors.add([colorList[4], colorList[5]]);
        break;
      case 'Junio':
        gradientColors.add([colorList[5], colorList[6]]);
        break;
      case 'Julio':
        gradientColors.add([colorList[6], colorList[7]]);
        break;
      case 'Agosto':
        gradientColors.add([colorList[7], colorList[8]]);
        break;
      case 'Septiembre':
        gradientColors.add([colorList[8], colorList[9]]);
        break;
      case 'Octubre':
        gradientColors.add([colorList[9], colorList[10]]);
        break;
      case 'Noviembre':
        gradientColors.add([colorList[10], colorList[11]]);
        break;
      case 'Diciembre':
        gradientColors.add([colorList[11], colorList[12]]);
        break;
    }
  }

  return gradientColors;  
}
