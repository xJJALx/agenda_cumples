import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/ui/providers/providers.dart';

class BtnBack extends StatelessWidget {
  const BtnBack({Key? key, this.color = Colors.white}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextButton(
           onPressed: () {
             Provider.of<CumpleProvider>(context,listen: false).isSelectedSwiper = false;
             Navigator.pop(context);
           },
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
          child: Icon(
            Icons.arrow_back_outlined,
            color: isDark ? Theme.of(context).iconTheme.color : color,
          ),
        ),
      ),
    );
  }
}
