import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  const MyAppBar({Key? key, required this.title, required this.actions})
      : super(key: key);
  @override
  Size get preferredSize {
    return Size.fromHeight(50.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      elevation: 10,
      backgroundColor: Colors.purple.shade300,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/logo.png"),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
