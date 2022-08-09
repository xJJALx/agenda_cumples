import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:agenda_cumples/ui/providers/providers.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:agenda_cumples/data/models/models.dart';


class CumplesScreen extends StatelessWidget {
  const CumplesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isSelected = Provider.of<CumpleProvider>(context).isSelectedSwiper;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  BtnBack(color: Colors.black),
                  _Titulo(),
                ],
              ),
            ),
            _Cumples(swiperView: _isSelected),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ChoiceChip(
              selectedColor: const Color(0xFFe5e0fd),
              label: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.view_carousel_outlined,
                    color: Color(0xFFa492f8),
                  )),
              selected: _isSelected,
              onSelected: (value) => Provider.of<CumpleProvider>(context, listen: false).isSelectedSwiper = value),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: const Color(0xFFe5e0fd),
            onPressed: () {
              Provider.of<CumpleProvider>(context, listen: false).clearCumple();
              Navigator.push(context, CustomPageRoute(child: const CumpleEditScreen()));
            },
            child: const Icon(Icons.add, color: Color(0xFFa492f8)),
          ),
        ],
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Cumpleaños',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

// https://stackoverflow.com/questions/51216448/is-there-any-callback-to-tell-me-when-build-function-is-done-in-flutter
class _Cumples extends StatelessWidget {
  _Cumples({Key? key, required this.swiperView}) : super(key: key);

  final bool swiperView;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context);
    final cumples = cumpleProvider.allCumples;
    double _positionScroll = cumpleProvider.scrollNextCumple();

    void _animateToIndex() {
      _controller.animateTo(
        _positionScroll,
        duration: _positionScroll < 2500 ? const Duration(milliseconds: 1250) : const Duration(milliseconds: 2250),
        curve: Curves.easeInOut,
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients && _positionScroll > 600) {
        Future.delayed(const Duration(milliseconds: 100), (() => _animateToIndex()));
      }
    });

    if (cumples.isNotEmpty) {
      if (swiperView) {
        return Expanded(
          child: Center(
            child: CumpleCardSwiper(cumples: cumples),
          ),
        );
      } else {
        return Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            itemCount: cumples.length,
            itemBuilder: (_, i) {
              Cumple cumple = cumples.keys.elementAt(i);

              if (cumples.values.elementAt(i)) {
                return Center(child: CumpleCardTitle(cumple));
              } else {
                return Center(child: CumpleCard(cumple));
              }
            },
          ),
        );
      }
    } else {
      return const CircularProgressIndicator();
    }
  }
}

// ! Los meses se renderizan bien la primera vez pero si se hace scroll se redibuja
// ! y se pierde el titulo del primer cumple del mes
// VERSION LISTVIEW
//   class _Cumples extends StatelessWidget {
//   _Cumples({Key? key}) : super(key: key);

//   final ScrollController _controller = ScrollController();
//   int _positionScroll = 0;

//   void _animateToIndex() {
//     _controller.animateTo(
//       _positionScroll.toDouble(),
//       duration: const Duration(seconds: 3),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _animateToIndex();
//     });

//     final cumpleProvider = Provider.of<CumpleProvider>(context);
//     final cumple = cumpleProvider.allCumples;
//     int lastMonth = 0;

//     _positionScroll = cumpleProvider.goToActualMonth();

//     return Expanded(
//       child: ListView.builder(
//         controller: _controller,
//         itemCount: cumpleProvider.allCumples.length,
//         itemBuilder: (_, i) {
//           if (lastMonth != cumple[i].date.month) {
//             lastMonth = cumple[i].date.month;
//             return Center(child: CumpleCardTitle(cumple[i]));
//           } else {
//             return Center(child: CumpleCard(cumple[i]));
//           }
//         },
//       ),
//     );
//   }
// }

// VERSION LISTVIEW BUILDER SEPARATED
// https://stackoverflow.com/questions/51216448/is-there-any-callback-to-tell-me-when-build-function-is-done-in-flutter
// https://stackoverflow.com/questions/62204671/flutter-listview-separated-add-separator-at-beginning-and-end-of-list
// class _Cumples extends StatelessWidget {
//   _Cumples({Key? key}) : super(key: key);

//   final ScrollController _controller = ScrollController();
//   int _positionScroll = 0;

//   void _animateToIndex() {
//     _controller.animateTo(
//       _positionScroll.toDouble(),
//       duration: const Duration(seconds: 3),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _animateToIndex();
//     });

//     final cumpleProvider = Provider.of<CumpleProvider>(context);
//     const emptyBox = SizedBox.shrink();
//     int actualMonth = 0;

//     _positionScroll = cumpleProvider.goToActualMonth();

//     return Expanded(
//       child: ListView.separated(
//         controller: _controller,
//         itemCount: 1 + cumpleProvider.allCumples.length,
//         itemBuilder: (_, i) {
//           if (i == 0) return emptyBox;
//           return Center(child: CumpleCard(cumpleProvider.allCumples[i - 1]));
//         },
//         separatorBuilder: (_, i) {
//           var cumple = cumpleProvider.allCumples[i].date;

//           //Control para crear el titulo con el nombre del mes solo la primera vez
//           if (actualMonth != cumple.month) {
//             actualMonth = cumple.month;
//             return Padding(
//               padding: const EdgeInsets.only(top: 20, left: 40),
//               child: Text(getMonth(cumple.month), style: GoogleFonts.play(fontSize: 20)),
//             );
//           }

//           return emptyBox;
//         },
//       ),
//     );
//   }
// }
