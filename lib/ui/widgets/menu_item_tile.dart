import 'package:flutter/material.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({
    Key? key,
    required this.text,
    required this.leading,
    this.color = const Color.fromARGB(222, 222, 222, 222),
    this.onClick,
  }) : super(key: key);

  final String text;
  final Icon leading;
  final Color color;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      focusColor: color,
      hoverColor: color.withOpacity(0.5),
      leading: leading, iconColor: Theme.of(context).iconTheme.color,
      title: Text(text, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
