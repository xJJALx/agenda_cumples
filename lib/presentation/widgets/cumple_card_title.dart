import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:agenda_cumples/presentation/widgets/widgets.dart';

import '../../data/models/models.dart';
import '../utils/month_text.dart';

class CumpleCardTitle extends StatelessWidget {
  const CumpleCardTitle(this.cumple, {Key? key}) : super(key: key);

  final Cumple cumple;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MonthTitle(cumple.date.month),
        CumpleCard(cumple),
      ],
    );
  }
}

class _MonthTitle extends StatelessWidget {
  const _MonthTitle(this.month, {Key? key}) : super(key: key);

  final int month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40),
      child: Row(
        children: [
          Text(getMonth(month), style: GoogleFonts.play(fontSize: 20)),
        ],
      ),
    );
  }
}
