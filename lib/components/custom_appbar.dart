import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:truth_or_dare/constants.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar(this.title);

  final String title;
  final double barHeight = 100.0; // change this for different heights

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: new Text(
          translate('app_bar.$title'),
          style: new TextStyle(
              fontSize: 30.0,
              color: Colors.grey,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
