import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/ui/providers/theme_provider.dart';
import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/widgets/custom_snackbar.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:agenda_cumples/ui/utils/format_date.dart';

class CumpleEditScreen extends StatelessWidget {
  const CumpleEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/blueGeometricHorizontal.png"),
          colorFilter: isDark ? ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken) : null,
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
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
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

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context, listen: false);
    final cumple = cumpleProvider.cumple;

    if (cumple.name.isNotEmpty) {
      nameController.text = cumple.name;
      cumpleController.text = formatDate(cumple.date);
    }

    // https://github.com/flutter/flutter/issues/23195
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((cumpleProvider.countCumples() < 5 || (cumpleProvider.countCumples() % 7 == 0)) && cumpleController.text.isEmpty) {
        _showTip('No olvides elegir el a??o de nacimiento ;)');
      }
    });

    return Form(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
            child: TextFormField(
              controller: nameController,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16),
              decoration: InputDecorations.inputCumple(hintText: 'Miku...', labelText: 'Nombre'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
            child: TextFormField(
              controller: cumpleController,
              enabled: false,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16),
              decoration: InputDecorations.inputCumple(
                hintText: '18/02/2014',
                labelText: 'Cumplea??os',
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
                child: Text('ELEGIR FECHA', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white)),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 106, 145, 230),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  if (cumpleProvider.cumple.id == '') _addCumple(cumpleProvider);
                  if (cumpleProvider.cumple.id != '') _updateCumple(cumpleProvider);
                  FocusScope.of(context).unfocus();
                },
                child: Text('GUARDAR', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }


  _elegirFecha(BuildContext context, TextEditingController cumpleController) async {
    final List<String> date = cumpleController.text.isEmpty 
                              ? ['18','02','2014'] 
                              : cumpleController.text.split('/');

    final int day = int.parse(date[0]);
    final int month = int.parse(date[1]);
    final int year = int.parse(date[2]);

    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime(year, month, day),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (newDate != null) {
      selectedDate = newDate;
      cumpleController.text = formatDate(newDate);
    }
  }

  _addCumple(CumpleProvider cumpleProvider) {
    if (nameController.text.isNotEmpty && cumpleController.text.isNotEmpty) {
      final resp = cumpleProvider.addCumple(nameController.text, selectedDate);
      resp.toString() != '' ? _showConfirmation('Cumplea??os creado') : _showError('Ha ocurrido un error');
    } else {
      _showWarning();
    }
  }

  _updateCumple(CumpleProvider cumpleProvider) async {
    final List<String> date = cumpleController.text.split('/');
    final int day = int.parse(date[0]);
    final int month = int.parse(date[1]);
    final int year = int.parse(date[2]);

    if (nameController.text.isNotEmpty && cumpleController.text.isNotEmpty) {
      final resp = await cumpleProvider.updateCumple(nameController.text, DateTime(year, month, day));
      resp == true ? _showConfirmation('Cumplea??os actualizado') : _showError('Ha ocurrido un error');
    } else {
      _showWarning();
    }
  }

  _showTip(String message) {
    Future.delayed(
      const Duration(milliseconds: 650),
      (() => ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackbar(
              message: message,
              bgColor: const Color.fromARGB(255, 106, 145, 230),
            ),
          )),
    );
  }

  _showConfirmation(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar(
        message: message,
        bgColor: const Color.fromARGB(255, 165, 226, 178),
        textColor: Colors.black,
      ),
    );
  }

  _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar(
        title: 'Oh!',
        message: message,
        bgColor: Colors.redAccent,
        img: "assets/red-dragon.png",
      ),
    );
  }

  _showWarning() {
    const Color bgColor = Color.fromARGB(255, 255, 244, 142);
    const Color textColor = Colors.black87;
    const String img = "assets/yellow-dragon.png";

    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(
          title: 'Oh!',
          message: 'Debes a??adir un nombre',
          bgColor: bgColor,
          textColor: textColor,
          img: img,
        ),
      );
    } else if (nameController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(
          title: 'Oh!',
          message: 'No puedes guardar solo espacios',
          bgColor: bgColor,
          textColor: textColor,
          img: img,
        ),
      );
    }

    if (cumpleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(
          title: 'Oh!',
          message: 'Debes elegir una fecha de cumplea??os',
          bgColor: bgColor,
          textColor: textColor,
          img: img,
        ),
      );
    }
  }
}
