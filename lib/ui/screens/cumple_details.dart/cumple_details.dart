import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';



class CumpleDetailsScreen extends StatelessWidget {
  const CumpleDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String img = randomImg();
    final cumpleProvider = Provider.of<CumpleProvider>(context);
    final cumple = cumpleProvider.cumple;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$img.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              // Todo: Deshabilitar touch en esta pantalla
              child:  CumpleCard(cumple),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  cumple.name,
                  style: GoogleFonts.play(fontSize: 45, color: Colors.black, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Text(
                  cumple.date.year.toString(),
                  style: GoogleFonts.play(fontSize: 45, color: Colors.black, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Text(
                  '${cumpleProvider.getAge()} años',
                  style: GoogleFonts.play(fontSize: 45, color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 243, 129, 158),
        onPressed: () => Navigator.push(context, CustomPageRoute(child: const CumpleEditScreen())),
        child: const Icon(Icons.edit, color: Color.fromARGB(255, 209, 10, 60)),
      ),
    );
  }

  String randomImg() {
    int max = 5;
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
      default:
        img = 'four';
    }
    print(num);
    return img;
  }
}
