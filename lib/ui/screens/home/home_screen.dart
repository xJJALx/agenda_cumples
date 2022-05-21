import 'package:agenda_cumples/ui/screens/home/widgets/drawer_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';

import 'package:agenda_cumples/ui/screens/home/widgets/action_item.dart';
import 'package:agenda_cumples/ui/screens/home/widgets/profile.dart';
import 'package:agenda_cumples/ui/widgets/cumple_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          _Home(),
          EstadisticasScreen(tipo: 'pageView'),
        ],
      ),
      drawer: DrawerHome() ,
    );
  }
}


class _Home extends StatelessWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HomeHeader(),
        SizedBox(height: 50),
        Expanded(child: CumplesSection()),
      ],
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
          onTap: () => Navigator.push(context, CustomPageRoute(child: const EstadisticasScreen())),
          child: const ActionItem(
            title: 'estadísticas',
            icon: Icons.insert_chart_outlined_outlined,
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
      children:  [
        Expanded(
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: Theme.of(context).colorScheme.secondary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            ),
            child: const _Cumples(),
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
            style: Theme.of(context).textTheme.headline4,
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
