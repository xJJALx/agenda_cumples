import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:agenda_cumples/presentation/providers/cumple_provider.dart';
import 'package:agenda_cumples/presentation/routes/routes.dart';
import 'package:agenda_cumples/presentation/screens/screens.dart';

import 'package:agenda_cumples/presentation/screens/home/widgets/action_item.dart';
import 'package:agenda_cumples/presentation/screens/home/widgets/profile.dart';
import 'package:agenda_cumples/presentation/widgets/cumple_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const [
          HomeHeader(),
          SizedBox(height: 50),
          Expanded(child: CumplesSection()),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: const [
          Profile(),
          MenuActions(),
        ],
      ),
    );
  }
}

class MenuActions extends StatelessWidget {
  const MenuActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<CumpleProvider>(context, listen: false).clearCumple();
            Navigator.push(context, CustomPageRoute(child: const CumpleEditScreen()));
          },
          child: const ActionItem(
            title: 'nuevo',
            icon: Icons.add,
            color: Color(0xFFe5e0fd),
            colorIcon: Color(0xFFa492f8),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, CustomPageRoute(child: const CumplesScreen())),
          child: const ActionItem(
            title: 'cumples',
            icon: Icons.cake_outlined,
            color: Color(0xFFd9ead3),
            colorIcon: Color(0xFF7fb86b),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'notas'),
          child: const ActionItem(
            title: 'notas',
            icon: Icons.note,
            color: Color(0xFFfce5cd),
            colorIcon: Color(0xFFf5a655),
          ),
        ),
      ],
    );
  }
}

class CumplesSection extends StatelessWidget {
  const CumplesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: Color(0xFFf4f2fe),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            ),
            child: _Cumples(),
          ),
        ),
      ],
    );
  }
}

class _Cumples extends StatelessWidget {
  const _Cumples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cumples = Provider.of<CumpleProvider>(context).nearCumples;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Proximos cumpleaños',
            style: GoogleFonts.play(fontSize: 22),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: ShaderMask(
            shaderCallback: (Rect rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.transparent],
                stops: [0.0, 0.15], // 10% purple, 80% transparent, 10% purple
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cumples.length,
              itemBuilder: (_, i) => Center(
                child: CumpleCard(cumples[i]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
