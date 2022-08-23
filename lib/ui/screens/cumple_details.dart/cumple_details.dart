import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:agenda_cumples/ui/providers/theme_provider.dart';

import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:agenda_cumples/data/models/models.dart';

class CumpleDetailsScreen extends StatelessWidget {
  const CumpleDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    String img = randomImg();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$img.png"),
            colorFilter: isDark ? ColorFilter.mode(Colors.white.withOpacity(0.75), BlendMode.modulate) : null,
            fit: BoxFit.cover,
          ),
        ),
        child: const _Cumple(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 243, 129, 158),
        onPressed: () => Navigator.push(context, CustomPageRoute(child: const CumpleEditScreen())),
        child: const Icon(Icons.edit, color: Color.fromARGB(255, 209, 10, 60)),
      ),
    );
  }

  String randomImg() {
    int max = 6;
    int num = Random().nextInt(max);
    String img;

    switch (num) {
      case 1:
        img = 'one';
        break;
      case 2:
        img = 'two';
        break;
      case 3:
        img = 'three';
        break;
      case 4:
        img = 'four';
        break;
      case 5:
        img = 'five';
        break;
      default:
        img = 'four';
    }
    return img;
  }
}

class _Cumple extends StatefulWidget {
  const _Cumple({Key? key}) : super(key: key);

  @override
  State<_Cumple> createState() => _CumpleState();
}

class _CumpleState extends State<_Cumple> {
  bool _isDragged = false;
  bool _isDeleted = false;

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context);
    final cumple = cumpleProvider.cumple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Draggable<Cumple>(
          data: cumple,
          onDragStarted: () => setState(() => _isDragged = true),
          onDragEnd: (value) => setState(() => _isDragged = false),
          feedback: Padding(padding: const EdgeInsets.only(top: 50), child: CumpleCard(cumple)),
          childWhenDragging: const SizedBox(width: 250, height: 320),
          child: _SplashCumpleCard(_isDeleted),
        ),
        _InfoCumple(_isDeleted),
        _isDragged
            ? DragTarget(
                onAccept: (data) async {
                  final deleted = await cumpleProvider.deleteCumple(cumple.id);

                  if (deleted) {
                    setState(() => _isDeleted = true);
                    Future.delayed(const Duration(milliseconds: 2200), (() {
                      Navigator.pop(context);
                      Navigator.push(context, CustomPageRoute(child: const HomeScreen()));
                    }));
                  }
                },
                builder: (context, _, __) => Center(
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 450),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 3, color: Colors.redAccent),
                          ),
                          child: ZoomIn(
                            child: const Icon(
                              Icons.delete_forever,
                              size: 35,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        const Text(
                          'Arrastrar aquí para eliminar',
                          style: TextStyle(color: Colors.redAccent),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class _SplashCumpleCard extends StatelessWidget {
  const _SplashCumpleCard(this.isDeleted, {Key? key}) : super(key: key);
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    final cumple = Provider.of<CumpleProvider>(context).cumple;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Stack(
        children: [
          AbsorbPointer(
            absorbing: true,
            child: isDeleted 
              ? CumpleCard(cumple, shadow: false) 
              : CumpleCard(cumple),
          ),
          isDeleted 
            ? FadeIn(duration: const Duration(milliseconds: 1250), child: const LineBreak()) 
            : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.cyanAccent,
              borderRadius: BorderRadius.circular(20),
              hoverColor: Colors.transparent,
              child: Ink(
                width: double.infinity,
                height: 196,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCumple extends StatelessWidget {
  const _InfoCumple(this.isDeleted, {Key? key}) : super(key: key);

  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context);
    final cumple = cumpleProvider.cumple;

    var info = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            cumple.name,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          cumple.date.year.toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 20),
        Text(
          '${cumpleProvider.getAge()} años',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: isDeleted
          ? ZoomOut(
              duration: const Duration(milliseconds: 1250),
              child: info,
            )
          : info,
    );
  }
}

class LineBreak extends StatelessWidget {
  const LineBreak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;

    return SizedBox(
      height: 0,
      width: 0,
      child: CustomPaint(
        painter: _LineBreakPainter(isDark),
      ),
    );
  }
}

class _LineBreakPainter extends CustomPainter {
  const _LineBreakPainter(this.isDark);
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = ui.PointMode.polygon;
    final points = [
      const Offset(135, 21),
      const Offset(250, 150),
      const Offset(260, 130),
      const Offset(320, 199),
    ];

    final paint = Paint()
      ..color = isDark ? const Color.fromARGB(255, 40, 40, 40) : const Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
