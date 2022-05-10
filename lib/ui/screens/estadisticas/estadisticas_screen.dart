import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/utils/gradient_colors.dart';
import 'package:agenda_cumples/ui/utils/month_text.dart';

class EstadisticasScreen extends StatelessWidget {
  const EstadisticasScreen({Key? key, this.tipo = ''}) : super(key: key);

  final String tipo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tipo != 'pageView' ? const BtnBack(color: Colors.black) : const SizedBox(width: 10),
                const _Titulo(),
              ],
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          'Estadísticas',
          style: GoogleFonts.play(fontSize: 34),
        ),
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
          color: Color(0xFFf4f2fe),
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        ),
        child: const _DatosExtra(),
      ),
    );
  }
}

class _DatosExtra extends StatelessWidget {
  const _DatosExtra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Cumpleaños totales: ${cumpleProvider.countCumples()}',
            style: GoogleFonts.play(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Mes más común: ${cumpleProvider.getMostCommonMonth()}',
            style: GoogleFonts.play(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Día más común: ${cumpleProvider.getMostCommonDay()}',
            style: GoogleFonts.play(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
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
    List<Color> colors = getColors(stats, gradientColorsTypeThree);
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
