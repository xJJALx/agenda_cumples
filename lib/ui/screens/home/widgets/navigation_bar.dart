import 'package:agenda_cumples/ui/providers/providers.dart';
import 'package:agenda_cumples/ui/routes/routes.dart';
import 'package:agenda_cumples/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class NavigationBarHome extends StatelessWidget {
  const NavigationBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final isDark = context.watch<ThemeProvider>().isDark;

    return Container(
      margin: const EdgeInsets.all(10),
      // height: 100,
      // width: size.width * 0.95,
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.secondary : Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, CustomPageRoute(child: const CumplesScreen())),
                child: const ButtonBarBig(
                  title: 'Cumples',
                  icon: Icons.cake_outlined,
                  color: Color.fromARGB(255, 16, 20, 61),
                  colorIcon: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<CumpleProvider>(context, listen: false).clearCumple();
                  Navigator.push(context, CustomPageRoute(child: const CumpleEditScreen()));
                },
                child:  ButtonBar(
                  title: '',
                  icon: Icons.add,
                  color: isDark ? Theme.of(context).colorScheme.secondary : Colors.white,
                  colorIcon: isDark ?  Colors.white70 : const Color.fromARGB(255, 16, 20, 61),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, CustomPageRoute(child: const EstadisticasScreen())),
                child: ButtonBar(
                  title: '',
                  icon: Icons.insert_chart_outlined_outlined,
                  color: isDark ? Theme.of(context).colorScheme.secondary : Colors.white,
                  colorIcon: isDark ?  Colors.white70 : const Color.fromARGB(255, 16, 20, 61),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, CustomPageRoute(child: const ProfileScreen())),
                child: ButtonBar(
                  title: '',
                  icon: Icons.perm_contact_cal_rounded,
                  color: isDark ? Theme.of(context).colorScheme.secondary : Colors.white,
                  colorIcon:  isDark ?  Colors.white70 : const Color.fromARGB(255, 16, 20, 61),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonBarBig extends StatelessWidget {
  const ButtonBarBig({
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
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      width: 130,
      child: Card(
        elevation: 10,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorIcon, size: 20),
            const SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorIcon.withOpacity(1)),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonBar extends StatelessWidget {
  const ButtonBar({
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
      height: 55,
      width: 55,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorIcon, size: 40),
            // const SizedBox(height: 5),
            // Text(
            //   title,
            //   style: Theme.of(context).textTheme.labelMedium?.copyWith(color: colorIcon.withOpacity(0.7)),
            // ),
          ],
        ),
      ),
    );
  }
}
