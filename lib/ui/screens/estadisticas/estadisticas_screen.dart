import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/utils/gradient_colors.dart';
import 'package:agenda_cumples/ui/utils/month_text.dart';

class EstadisticasScreen extends StatelessWidget {
  const EstadisticasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: SizedBox(
        child: Stack(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  BtnBack(color: Colors.black),
                  _Titulo(),
                ],
              ),
            ),
            Positioned(top: 100, left: 0, child: _Grafica()),
            const _BottomModal()
          ],
        ),
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Estadísticas',
        style: GoogleFonts.play(fontSize: 30),
      ),
    );
  }
}

class _BottomModal extends StatelessWidget {
  const _BottomModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.32,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        ),
        child: const _DatosExtra(),
      ),
    );
  }
}

// TODO: Crear funciones para los datos extra
class _DatosExtra extends StatelessWidget {
  const _DatosExtra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Cumpleaños totales: XX',
            style: GoogleFonts.play(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500,),
          ),
          Text(
            'Mes más común: XX',
            style: GoogleFonts.play(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500,),
          ),
          Text(
            'Nombre más común: XX',
            style: GoogleFonts.play(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500,),
          ),
        ],
      ),
    );
  }
}

class _Grafica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final stats = Provider.of<CumpleProvider>(context).statistics;
    List<Color> colors = getColors(stats, gradientColorsTypePastel);
    // List<List<Color>> colors = getGradientColors(stats, gradientColorsTypePastel);

    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: size.width * 1,
      height: size.height * 0.45,
      child: stats.isNotEmpty
          ? PieChart(
              dataMap: stats,
              chartType: ChartType.disc,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              colorList: colors,
              // gradientList: colors,
              initialAngleInDegree: 0,
              centerText: "Cumples",
              legendOptions: const LegendOptions(showLegends: true, legendPosition: LegendPosition.bottom, showLegendsInRow: true),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                decimalPlaces: 0,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
