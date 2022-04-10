import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    Key? key,
    required String message,
    String btnLabel = 'OK',
    Color bgColor = Colors.black,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onOk,
  }) : super(
          key: key,
          content: Text(
            message,
            style: TextStyle(color: textColor),
          ),
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
