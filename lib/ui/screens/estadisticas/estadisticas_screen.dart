import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/utils/gradient_colors.dart';
import 'package:agenda_cumples/ui/utils/month_text.dart';
import 'package:agenda_cumples/ui/widgets/btn_back.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class EstadisticasScreen extends StatelessWidget {
  const EstadisticasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BtnBack(color: Colors.red),
          _Grafica(),
        ],
      ),
    );
  }
}

class _Grafica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final stats = Provider.of<CumpleProvider>(context).statistics;
    List<List<Color>> colors = getGradientColors(stats, gradientColorsTypeOne);

    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 400,
      child: stats.isNotEmpty
          ? PieChart(
              dataMap: stats,
              chartType: ChartType.disc,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              // colorList: colors,
              gradientList: colors,
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
