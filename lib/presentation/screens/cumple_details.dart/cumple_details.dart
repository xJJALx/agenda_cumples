import 'package:agenda_cumples/data/models/models.dart';
import 'package:agenda_cumples/presentation/providers/cumple_provider.dart';
import 'package:agenda_cumples/presentation/routes/routes.dart';
import 'package:agenda_cumples/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/presentation/widgets/btn_back.dart';

class CumpleDetailsScreen extends StatelessWidget {
  const CumpleDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          BtnBack(
            color: Colors.redAccent,
          ),
          Text(cumpleProvider.cumple.name),
          Text(cumpleProvider.cumple.date.toString())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 243, 129, 158),
        onPressed: () => Navigator.push(context, CustomPageRoute(child: const CumpleEditScreen())),
        child: const Icon(Icons.edit, color: Color.fromARGB(255, 209, 10, 60)),
      ),
    );
  }
}
