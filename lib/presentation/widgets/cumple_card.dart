import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/presentation/routes/routes.dart';
import 'package:agenda_cumples/presentation/screens/screens.dart';
import 'package:agenda_cumples/presentation/providers/cumple_provider.dart';

import 'package:agenda_cumples/presentation/utils/gradient_colors.dart';
import 'package:agenda_cumples/presentation/utils/month_text.dart';

class CumpleCard extends StatelessWidget {
  const CumpleCard(this.cumple, {Key? key}) : super(key: key);

  final Cumple cumple;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cumpleProvider = Provider.of<CumpleProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: size.width * 0.9,
      height: 220,
      child: InkWell(
        onTap: () {
          cumpleProvider.cumple = cumple;
          Navigator.push(context, CustomPageRoute(child: const CumpleDetailsScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [gradientColorsTypeOne[cumple.date.month - 1], gradientColorsTypeOne[cumple.date.month]],
              // tileMode: TileMode.clamp,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColorsTypeOne[cumple.date.month].withOpacity(0.35),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(child: _Bubble(), top: -20, right: -50),
              Positioned(
                right: 30,
                top: 20,
                child: Text(
                  cumple.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white70),
                ),
              ),
              Positioned(
                left: 42,
                bottom: 5,
                child: Text(
                  cumple.date.day.toString().padLeft(2, '0'),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 120, color: Colors.white70),
                ),
              ),
              Positioned(
                left: 52,
                bottom: 10,
                child: Text(
                  getMonth(cumple.date.month),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 205,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
