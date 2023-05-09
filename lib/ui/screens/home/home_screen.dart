import 'package:agenda_cumples/data/models/cumple_model.dart';
import 'package:agenda_cumples/ui/screens/home/widgets/navigation_bar.dart';
import 'package:agenda_cumples/ui/utils/gradient_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:agenda_cumples/ui/providers/providers.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';

import 'package:agenda_cumples/ui/screens/home/widgets/drawer_home.dart';
import 'package:agenda_cumples/ui/screens/home/widgets/action_item.dart';
import 'package:agenda_cumples/ui/widgets/cumple_card.dart';

import '../../widgets/cumple_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CumpleProvider>(context, listen: false).getCumples();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(child: _Home()),
        ],
      ),
      // Scaffold(
      //   body: PageView(
      //     controller: _controller,
      //     children: const [
      //       _Home(),
      //       EstadisticasScreen(tipo: 'pageView'),
      //     ],
      //   ),
      drawer: DrawerHome(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SafeArea(child: HomeHeader()),
        CumplesSection(),
        _BottomOptions(),
      ],
    );
  }
}

class _BottomOptions extends StatelessWidget {
  const _BottomOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.13,
      child: const NavigationBarHome(),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 40, right: 20, left: 20),
      height: size.height * 0.2,
      child: Column(
        children: const [
          // Profile(),
          _HeaderSearch(),
          // MenuActions(),
        ],
      ),
    );
  }
}

class _HeaderSearch extends StatelessWidget {
  const _HeaderSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cumple = context.watch<CumpleProvider>().nearCumples;
    var colores = [Colors.black, Colors.red];
    if (cumple.isNotEmpty) {
      colores = [
        gradientColorsTypeOne[cumple[0].date.month - 1],
        gradientColorsTypeOne[cumple[0].date.month]
      ];
    }
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 18),
          height: 150,
          width: 5,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight, colors: colores,
              // tileMode: TileMode.clamp,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' Find',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromARGB(255, 16, 20, 61),
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                ' a Special',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromARGB(255, 16, 20, 61),
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                ' B-Day',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromARGB(255, 16, 20, 61),
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // SizedBox(width: 80),
        GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icon/lupa_main.png'),
          ),
        )
      ],
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
    final size = MediaQuery.of(context).size;
    final cumplesProvider = context.watch<CumpleProvider>().nearCumples;
    Map<Cumple, bool> cumples = {};

    for (var cumple in cumplesProvider) {
      cumples.putIfAbsent(cumple, () => false);
    }
    return Column(
      children: [
        // const Text(
        //   'Próximos cumpleaños',
        //   style: TextStyle(
        //     color: Color.fromARGB(255, 16, 20, 61),
        //   ),
        // ),
        SizedBox(
          height: size.height * 0.35,
          child: CumpleCardSwiper(cumples: cumples),
        ),
      ],
    );
  }
}

// class _Cumples extends StatelessWidget {
//   const _Cumples({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final cumples = Provider.of<CumpleProvider>(context).nearCumples;

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Text(
//             'Próximos cumpleaños',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Expanded(
//           child: ShaderMask(
//             shaderCallback: (Rect rect) {
//               return const LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.red, Colors.transparent],
//                 stops: [0.0, 0.15], // 10% purple, 80% transparent, 10% purple
//               ).createShader(rect);
//             },
//             blendMode: BlendMode.dstOut,
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: cumples.length,
//               itemBuilder: (_, i) => Center(
//                 child: FadeInUp(
//                   duration: const Duration(milliseconds: 1350),
//                   child: CumpleCard(cumples[i]),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
