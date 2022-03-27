import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/presentation/providers/cumple_provider.dart';
import 'package:agenda_cumples/presentation/widgets/custom_snackbar.dart';
import 'package:agenda_cumples/presentation/widgets/widgets.dart';

class CumpleEditScreen extends StatelessWidget {
  const CumpleEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: const [
          Background(),
          BottomModal(),
          BtnBack(),
        ],
      ),
      // bottomSheet: CumpleForm(),
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.35,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/blueGeometricHorizontal.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class BottomModal extends StatelessWidget {
  const BottomModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        ),
        child: const CumpleForm(),
      ),
    );
  }
}

class CumpleForm extends StatefulWidget {
  const CumpleForm({Key? key}) : super(key: key);

  @override
  State<CumpleForm> createState() => _CumpleFormState();
}

class _CumpleFormState extends State<CumpleForm> {
  final TextEditingController cumpleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool nuevo = true;

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context, listen: false);
    final cumple = cumpleProvider.cumple;

    if (cumple.name.isNotEmpty) {
      nameController.text = cumple.name;
      String monthWithZero = '0${cumple.date.month}';
      String dayWithZero = '0${cumple.date.day}';
      cumpleController.text = '${cumple.date.day < 10 ? dayWithZero : cumple.date.day}/${cumple.date.month < 10 ? monthWithZero : cumple.date.month}/${cumple.date.year}';

      nuevo = false;
    }



    return Form(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecorations.inputCumple(hintText: 'Miku...', labelText: 'Nombre'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
            child: TextFormField(
              controller: cumpleController,
              enabled: false,
              decoration: InputDecorations.inputCumple(
                hintText: '18/02/2014',
                labelText: 'Cumpleaños',
              ),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onPressed: () => _elegirFecha(context, cumpleController),
                child: const Text('Elegir una fecha'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 106, 145, 230),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  if (nuevo) _addCumple(cumpleProvider);

                  if (!nuevo) {
                    _updateCumple(cumpleProvider);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ToDo: confirmacion de guardado
  _addCumple(CumpleProvider cumpleProvider) {
    if (nameController.text.isNotEmpty && cumpleController.text.isNotEmpty) {
      cumpleProvider.addCumple(nameController.text, selectedDate);
      print('GUARDANDO');
    } else {
      if (nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(message: 'Debes añadir un nombre'));
      } else if (nameController.text.trim() == '') {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(message: 'No puedes guardar solo espacios'));
      }

      if (cumpleController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(message: 'Debes elegir una fecha de cumpleaños'));
      }
    }
  }

    _updateCumple(CumpleProvider cumpleProvider) {
      final List<String> date = cumpleController.text.split('/');
      final int day = int.parse(date[0]);
      final int month = int.parse(date[1]);
      final int year = int.parse(date[2]);

      cumpleProvider.updateCumple(nameController.text, DateTime(year, month, day));
    }
  _elegirFecha(BuildContext context, TextEditingController cumpleController) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (newDate != null) {
      selectedDate = newDate;

      String monthWithZero = '0${newDate.month}';
      String dayWithZero = '0${newDate.day}';
      cumpleController.text = '${newDate.day < 10 ? dayWithZero : newDate.day}/${newDate.month < 10 ? monthWithZero : newDate.month}/${newDate.year}';
    }
  }
}
