import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:card_swiper/card_swiper.dart';

class CumpleCardSwiper extends StatelessWidget {
  const CumpleCardSwiper({Key? key, required this.cumples}) : super(key: key);

  final Map<Cumple, bool> cumples;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Swiper(
        itemCount: cumples.length,
        itemWidth: size.width * 0.9,
        index: Provider.of<CumpleProvider>(context).indexCumple, // Nota: si en el provider el index es -1 parece no fallar y directamente toma la ultima posición
        // pagination: const SwiperPagination(),
        // control: const SwiperControl(),
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int i) {
          var cumple = cumples.keys.elementAt(i);
          return CumpleCard(cumple);
        },
      ),
    );
  }
}
