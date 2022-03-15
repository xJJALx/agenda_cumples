import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputCumple({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.deepPurple) : null,
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo)),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo, width: 2)),
    );
  }
}
