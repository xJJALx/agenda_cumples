import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_cumples/ui/providers/providers.dart';

// TODO animacion del avatar al cambiar a modo edit
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            MenuIcon(),
            Avatar(),
            EditIcon(),
          ],
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _editMode = Provider.of<UserProvider>(context).isEditMode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('assets/WinterMask.jpeg'),
        ),
        _editMode 
        ? const _UserEditData() 
        : const _UserData()
      ],
    );
  }
}

class _UserEditData extends StatelessWidget {
  const _UserEditData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(
            width: 200,
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'Enter your username',
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(labelText: 'Enter your username'),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          Provider.of<UserProvider>(context).displayName,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 5),
        Text(
          Provider.of<UserProvider>(context).ocupacion,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class MenuIcon extends StatelessWidget {
  const MenuIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, left: 20),
          child: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: const Icon(Icons.notes_sharp),
          ),
        ),
      ],
    );
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final bool isEditMode = Provider.of<UserProvider>(context).isEditMode;

    final _editBtn = Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, right: 20),
          child: Card(
            color: const Color(0xFFe5e0fd),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () => onEditMode(context),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              icon: isEditMode 
                    ? const Icon(Icons.check, color: Color(0xFFa492f8)) 
                    : const Icon(Icons.edit, color: Color(0xFFa492f8)),
            ),
          ),
        ),
      ],
    );

    if (!isDark) {
      return _editBtn;
    } else {
      return Opacity(opacity: 0.7, child: _editBtn);
    }
  }

  onEditMode(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    bool isEditMode = userProvider.isEditMode;
    userProvider.setEditMode = !isEditMode;

    UserProvider.usuario.docId.isEmpty ? userProvider.addInfoUser() : userProvider.updateInfoUser();
  }
}
