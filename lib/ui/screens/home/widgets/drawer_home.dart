import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/ui/providers/theme_provider.dart';
import 'package:agenda_cumples/ui/providers/cumple_provider.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';

class DrawerHome extends StatelessWidget {
  DrawerHome({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Color _color = const Color(0xFFa492f8);


  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

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
            leading: const Icon(Icons.add_circle),
            text: 'Nuevo cumple',
            color: _color,
            onClick: () => selectedItem(context, 1),
          ),
          const SizedBox(height: 20),
          MenuItemTile(
            leading: const Icon(Icons.cake),
            text: 'Cumpleaños',
            color: _color,
            onClick: () => selectedItem(context, 2),
          ),
          const SizedBox(height: 20),
          MenuItemTile(
            leading: const Icon(Icons.insert_chart_outlined),
            text: 'Estadísticas',
            color: _color,
            onClick: () => selectedItem(context, 3),
          ),
          const SizedBox(height: 20),
          Divider(color: _color),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.wb_sunny_outlined, color: Theme.of(context).iconTheme.color),
            title: Text('Tema', style: Theme.of(context).textTheme.labelMedium),
            trailing: CupertinoSwitch(
              value: theme.isDark,
              onChanged: (value) => theme.isDark ? theme.setTheme =  'light' : theme.setTheme = 'dark',
            ),
          ),
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    // Cierra el Drawer antes de navegar
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(context, CustomPageRoute(child: const HomeScreen()));
        break;
      case 1:
        Provider.of<CumpleProvider>(context, listen: false).clearCumple();
        Navigator.push(context, CustomPageRoute(child: const CumpleEditScreen()));
        break;
      case 2:
        Navigator.push(context, CustomPageRoute(child: const CumplesScreen()));
        break;
      case 3:
        Navigator.push(context, CustomPageRoute(child: const EstadisticasScreen()));
        break;
      default:
        Navigator.push(context, CustomPageRoute(child: const HomeScreen()));
    }
  }
}
