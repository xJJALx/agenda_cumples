import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:animate_do/animate_do.dart';
import 'package:agenda_cumples/ui/providers/providers.dart';

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
        AnimatedContainer(
          width: _editMode ? 50 : 70,
          height: _editMode ? 50 : 70,
          curve: Curves.easeOutBack,
          duration: const Duration(milliseconds: 900),
          child: FadeInDown(
              duration: const Duration(milliseconds: 850),
              delay: const Duration(milliseconds: 350),
              child: _editMode
                  ? GestureDetector(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        if(image != null) Provider.of<UserProvider>(context, listen: false).updateImage(image.path);
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(UserProvider.usuario.profilePicture),
                          ),
                          const Positioned(right: 0, bottom: 0, child: Icon(Icons.camera_alt_outlined, size: 22, color: Color(0xFFa492f8))),
                        ],
                      ),
                    )
                : CircleAvatar(
                backgroundColor: const Color(0xFFa492f8),
                radius: 35,
                backgroundImage: const AssetImage('assets/loading.gif'),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(UserProvider.usuario.profilePicture),
                ),
              ),
                  
          ),
        ),
        _editMode ? _UserEditData() : const _UserData()
      ],
    );
  }
}

class _UserEditData extends StatelessWidget {
  _UserEditData({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ocupacionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = UserProvider.usuario.displayName;
    ocupacionController.text = UserProvider.usuario.ocupacion;

    return Form(
      child: Column(
        children: [
          SizedBox(
            width: 180,
            child: TextFormField(
              controller: nameController,
              autofocus: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16),
              onChanged: (text) => UserProvider.usuario.displayName = text,
            ),
          ),
          SizedBox(
            width: 180,
            child: TextFormField(
              controller: ocupacionController,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16),
              onChanged: (text) => UserProvider.usuario.ocupacion = text,
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
    final user = Provider.of<UserProvider>(context);

    return FadeIn(
      duration: const Duration(milliseconds: 1650),
      delay: const Duration(milliseconds: 700),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            user.displayName.isEmpty ? 'Miku' : user.displayName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 5),
          Text(
            user.ocupacion.isEmpty ? 'Sobrecualificad@' : user.ocupacion,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
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
            onPressed: () {
              Provider.of<CumpleProvider>(context, listen: false).clearSearchCumple();
              Scaffold.of(context).openDrawer();
            },
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

  // TODO: controlar transacciones BBDD innecesarias, comparando textController con valor del usuario. Al estar en widgets diferentes se podria buscar una forma de pasar el textconroller
  onEditMode(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    bool isEditMode = userProvider.isEditMode;
    userProvider.setEditMode = !isEditMode;

    if (isEditMode) {
      UserProvider.usuario.docId.isEmpty ? userProvider.addInfoUser() : userProvider.updateInfoUser();
    }
  }
}
