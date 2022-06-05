import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    Key? key,
    required String message,
    String title = '',
    String btnLabel = 'OK',
    Color bgColor = Colors.black,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    String img = '',
    VoidCallback? onOk,
  }) : super(
          key: key,
          margin: const EdgeInsets.all(35),
          duration: duration,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          content: Stack(
            children: [
              if(img.isNotEmpty)
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: img.isNotEmpty ? const EdgeInsets.only(left: 112) : null,
                height: img.isNotEmpty? 100 : 80,            
                child: Padding(
                  padding: img.isNotEmpty ? const EdgeInsets.symmetric(vertical: 10) : const EdgeInsets.symmetric(vertical: 0),
                  child: Column(                  
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 20, color: textColor)),
                      const SizedBox(height: 8),
                      Text(message, style: TextStyle(fontSize: 14, color: textColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            textColor: textColor,
            label: btnLabel,
            onPressed: () {
              if (onOk != null) onOk();
            },
          ),
        );
}
