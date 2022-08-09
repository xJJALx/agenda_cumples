import 'package:flutter/material.dart';


import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:agenda_cumples/ui/utils/month_text.dart';

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
          Text(getMonth(month), 
          style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
