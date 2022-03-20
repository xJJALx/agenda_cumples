import 'package:agenda_cumples/presentation/providers/cumple_provider.dart';
import 'package:flutter/material.dart';
import 'package:agenda_cumples/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

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

    return Form(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
            // Todo: provider con el nombre del cumpleañero
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
              // Todo: evaluar si hay fecha es porq se selecionó cumpleañero
              decoration: InputDecorations.inputCumple(
                hintText: '',
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

  _addCumple(CumpleProvider cumpleProvider) {
    if (nameController.text.isNotEmpty && cumpleController.text.isNotEmpty) {
      cumpleProvider.addCumple(nameController.text, selectedDate);
      print('GUARDANDO');
    } else {
      if (nameController.text.isEmpty) {
        print('**************** NO HAY NOMBRE ***************');
      }
      if (cumpleController.text.isEmpty) {
        print('**************** NO HAY CUMPLE ***************');
      }
    }
  }

  _updateCumple(CumpleProvider cumpleProvider) {
    cumpleProvider.updateCumpleTest();
  }

  _elegirFecha(BuildContext context, TextEditingController cumpleController) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (newDate != null) selectedDate = newDate;
    cumpleController.text = '${newDate!.day}/${newDate.month}/${newDate.year}';
  }
}
