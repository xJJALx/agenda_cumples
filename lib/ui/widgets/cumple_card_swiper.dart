import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

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
