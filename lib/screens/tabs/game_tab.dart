import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:truth_or_dare/models/arguments.dart';

import '../add_screen_dare.dart';
import '../add_screen_truth.dart';
import '../cat_screen.dart';

class GameTab extends StatelessWidget {
  const GameTab({@required this.size, @required this.context});

  final Size size;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: size.height),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                      child: Image.asset('assets/images/movingcircle.gif')),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CatScreen.id);
                    },
                    child: Container(
                      child: Text(translate('button.start'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold)),
                      margin: EdgeInsets.symmetric(
                          vertical: size.height / 3,
                          horizontal: size.height / 3),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AddScreenTruth.id,
                        arguments: ScreenArguments(choice: true));
                  },
//                      child: Hero(
//                        tag: 'addtruth',
                  child: Text(
                    translate('button.add_truth'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        decoration: TextDecoration.none),
                  ),
//                      ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AddScreenDare.id,
                        arguments: ScreenArguments(choice: false));
                  },
                  child: Hero(
                    tag: 'adddare',
                    child: Text(
                      translate('button.add_dare'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
