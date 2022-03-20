import 'package:flutter/material.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage('https://64.media.tumblr.com/4fbb812fbad16085366148fa1005800f/a3dd7b1595f9b809-b2/s1280x1920/c7d0af53899af7d8e5f37d49b83c3296cbeeb9fc.jpg'),
        ),
        SizedBox(height: 10),
        Text(
          'Jhon Jairo Aristizábal',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          'Desarrollador web',
          style: TextStyle(fontSize: 16, color: Colors.black54),
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
            onPressed: () {},
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: const Icon(Icons.notes_sharp, color: Colors.black87),
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, right: 20),
          child: Card(
            color: const Color(0xFFe5e0fd),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              icon: const Icon(Icons.edit, color: Color(0xFFa492f8)),
            ),
          ),
        ),
      ],
    );
  }
}
