import 'package:flutter/material.dart';

import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';

class DrawerHome extends StatelessWidget {
  DrawerHome({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _color = const Color(0xFFa492f8);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // DrawerHeader(
          //   decoration: BoxDecoration(color: Colors.blue),
          //   child: Text('Drawer Header'),
          // ),
          const SizedBox(height: 20),
          // TODO: cambiar search por input text
          MenuItemTile(
            leading: const Icon(Icons.search),
            text: 'Buscar',
            color: _color,
            onClick: () => selectedItem(context, 0),
          ),
          const SizedBox(height: 20),
          MenuItemTile(
            leading: const Icon(Icons.cake),
            text: 'Cumpleaños',
            color: _color,
            onClick: () => selectedItem(context, 1),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),
          MenuItemTile(
            leading: const Icon(Icons.cake),
            text: 'TEMA',
            color: _color,
            onClick: () => selectedItem(context, 2),
          ),
        ],
      ),
    );
  }

  // TODO: rutas
  void selectedItem(BuildContext context, int index) {
    // Cierra el Drawer antes de navegar
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(context, CustomPageRoute(child: const CumplesScreen()));
        break;
      default:
    }
  }
}
