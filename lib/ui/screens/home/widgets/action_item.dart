import 'package:flutter/material.dart';

class ActionItem extends StatelessWidget {
  const ActionItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.colorIcon,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color color, colorIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 110,
      height: 110,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorIcon, size: 40),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
