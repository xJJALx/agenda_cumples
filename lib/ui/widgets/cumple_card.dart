import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:agenda_cumples/ui/providers/theme_provider.dart';
import 'package:agenda_cumples/ui/providers/cumple_provider.dart';

import 'package:agenda_cumples/ui/utils/gradient_colors.dart';
import 'package:agenda_cumples/ui/utils/month_text.dart';

// CORREGIR LINEA AMARILLA CON MATERIAL Fix yellow underline https://github.com/flutter/flutter/issues/30647#issuecomment-509712719
class CumpleCard extends StatelessWidget {
  const CumpleCard(this.cumple, {Key? key, this.shadow = true}) : super(key: key);

  final Cumple cumple;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cumpleProvider = Provider.of<CumpleProvider>(context);
    final isDark = Provider.of<ThemeProvider>(context).isDark;

    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minWidth: 350, maxWidth: 500),
      width: size.width * 0.9,
      height: 220,
      // child: Hero(
      // tag: cumple.id,
      child: GestureDetector(
        onTap: () {
          cumpleProvider.cumple = cumple;
          Navigator.push(context, CustomPageRoute(child: const CumpleDetailsScreen()));
        },
        child: Opacity(
          opacity: 0.95,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  gradientColorsTypeOne[cumple.date.month - 1],
                  gradientColorsTypeOne[cumple.date.month]
                ],
                // tileMode: TileMode.clamp,
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientColorsTypeOne[cumple.date.month].withOpacity(isDark || !shadow ? 0.0 : 0.35),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  right: -50,
                  child: _Bubble(),
                ),
                Positioned(
                  right: 30,
                  top: 20,
                  child: Material(
                    type: MaterialType.transparency, // Fix yellow underline Hero animation
                    child: Text(
                      cumple.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: cumple.name.length < 15 ? 32 : 24,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 42,
                  bottom: 15,
                  child: Material(
                    type: MaterialType.transparency, // Fix yellow underline Hero animation

                    child: SizedBox(
                      height: 120,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          cumple.date.day.toString().padLeft(2, '0'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 110, color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 52,
                  bottom: 10,
                  child: Material(
                    type: MaterialType.transparency, // Fix yellow underline Hero animation
                    child: Text(
                      getMonth(cumple.date.month),
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
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
