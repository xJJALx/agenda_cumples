import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:agenda_cumples/ui/providers/providers.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:agenda_cumples/ui/widgets/widgets.dart';
import 'package:agenda_cumples/data/models/models.dart';

class DrawerHome extends StatelessWidget {
  DrawerHome({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cumples = Provider.of<CumpleProvider>(context).searchCumples;

    return Drawer(
      key: _scaffoldKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            const _Items(),
            if (cumples.isNotEmpty) const _Sugerencias(),
          ],
        ),
      ),
    );
  }
}

class _Items extends StatelessWidget {
  const _Items({Key? key}) : super(key: key);

  final Color _color = const Color(0xFFa492f8);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        // DrawerHeader(
        //   decoration: BoxDecoration(color: Colors.blue),
        //   child: Text('Drawer Header'),
        // ),
        const SizedBox(height: 20),
        _Buscador(),

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
            onChanged: (value) => theme.isDark ? theme.setTheme = 'light' : theme.setTheme = 'dark',
          ),
        ),

        Expanded(child: Container()),
        MenuItemTile(
          leading: const Icon(Icons.exit_to_app_outlined),
          text: 'Sign Out',
          color: _color,
          onClick: () => FirebaseAuth.instance.signOut(),
        ),
      ],
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

class _Buscador extends StatelessWidget {
  _Buscador({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cumpleProvider = Provider.of<CumpleProvider>(context);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 15, right: 40),
      width: double.infinity,
      child: TextField(
        controller: _searchController,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16),
        cursorColor: const Color(0xFFa492f8),
        onChanged: (text) => cumpleProvider.searchCumple(text),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: theme.iconTheme.color,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFa492f8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 117, 85, 255)),
          ),
        ),
      ),
    );
  }
}

class _Sugerencias extends StatelessWidget {
  const _Sugerencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cumples = Provider.of<CumpleProvider>(context).searchCumples;
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 90),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme.scaffoldBackgroundColor,
            ),
            child: ListView.builder(
              itemCount: cumples.length,
              itemBuilder: (_, i) {
                Cumple cumple = cumples[i];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop(); // Cierra el drawer
                    Provider.of<CumpleProvider>(context, listen: false).cumple = cumple;
                    Navigator.push(context, CustomPageRoute(child: const CumpleDetailsScreen()));
                  },
                  leading: Icon(
                    Icons.celebration,
                    color: theme.iconTheme.color,
                  ),
                  title: Text(
                    cumple.name,
                    style: theme.textTheme.labelMedium?.copyWith(fontSize: 14),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
