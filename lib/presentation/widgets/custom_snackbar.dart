import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    Key? key,
    required String message,
    String btnLabel = 'OK',
    Color bgColor = Colors.redAccent,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onOk,
  }) : super(
          key: key,
          content: Text(message),
          duration: duration,
          backgroundColor: bgColor,
          action: SnackBarAction(
            textColor: textColor,
            label: btnLabel,
            onPressed: () {
              if (onOk != null) onOk();
            },
          ),
        );
}
