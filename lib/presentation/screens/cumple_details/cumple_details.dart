import 'package:flutter/material.dart';
import 'package:agenda_cumples/presentation/widgets/widgets.dart';

class CumpleDetailsScreen extends StatelessWidget {
  const CumpleDetailsScreen({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    TextEditingController cumpleController = TextEditingController();
    bool nuevo = false;

    return Form(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
            // Todo: provider con el nombre del cumpleañero
            child: TextFormField(
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            onPressed: () => _elegirFecha(context, cumpleController),
            child: const Text('Elegir una fecha'),
          ),
        ],
      ),
    );
  }

  void _elegirFecha(BuildContext context, TextEditingController cumpleController) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    cumpleController.text = '${newDate!.day}/${newDate.month}/${newDate.year}';
  }
}

// Forma 2: metiendo la logica en la funcion on Pressed

// class CumpleForm extends StatefulWidget {
//   const CumpleForm({Key? key}) : super(key: key);

//   @override
//   State<CumpleForm> createState() => _CumpleFormState();
// }

// class _CumpleFormState extends State<CumpleForm> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController cumpleController = TextEditingController();
//     bool nuevo = false;

//     return Form(
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
//             // Todo: provider con el nombre del cumpleañero
//             child: TextFormField(
//               decoration: InputDecorations.inputCumple(hintText: 'Miku...', labelText: 'Nombre'),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
//             child: TextFormField(
//               controller: cumpleController,
//               enabled: false,
//               // Todo: evaluar si hay fecha es porq se selecionó cumpleañero
//               decoration: InputDecorations.inputCumple(
//                 hintText: '',
//                 labelText: 'Cumpleaños',
//               ),
//             ),
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Colors.indigo,
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//               textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//             ),
//             onPressed: () async {
//               DateTime? newDate = await _elegirFecha(context);
//               cumpleController.text = '${newDate!.day}/${newDate.month}/${newDate.year}';
//             },
//             child: const Text('Elegir una fecha'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<DateTime?> _elegirFecha(BuildContext context) {
//     final DateTime initialDate = DateTime.now();

//     return showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//   }
// }
