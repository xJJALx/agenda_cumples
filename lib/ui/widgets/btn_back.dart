import 'package:flutter/material.dart';

class BtnBack extends StatelessWidget {
  const BtnBack({Key? key, this.color = Colors.white}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
          child: Icon(Icons.arrow_back_outlined, color: color),
        ),
      ),
    );
  }
}
