import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.onPress, this.color, this.text});

  final Function onPress;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
//        margin: EdgeInsets.only(left: 100.0, right: 100.0, bottom: 40.0),
        padding: EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FlatButton(
          child: Text(
            translate('button.$text'),
            style: TextStyle(
                color: Colors.white, fontSize: 18.0, letterSpacing: 1.2),
          ),
          onPressed: onPress,
        ));
  }
}
