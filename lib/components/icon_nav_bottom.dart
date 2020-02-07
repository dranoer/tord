import 'package:flutter/material.dart';

class IconNavBottom extends StatelessWidget {
  IconNavBottom({this.icon, this.press});

  final Icon icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: press,
      iconSize: 42.0,
      color: Colors.white,
    );
  }
}
