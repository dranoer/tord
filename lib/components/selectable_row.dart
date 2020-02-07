import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'dart:math' as math;

class SelectableRow extends StatelessWidget {
  SelectableRow({this.name, this.imageRoot, this.color});

  final String imageRoot;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: TweenAnimationBuilder(
              duration: Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: 2 * math.pi),
              builder: (_, double angle, __) {
                return Transform.rotate(
                  angle: angle,
                  child: Image.asset('assets/images/$imageRoot.png'),
                );
              }),
//            padding: EdgeInsets.all(10.0),
//            child: Image.asset('assets/images/$imageRoot.png'),
//            height: 65.0,
//            decoration: BoxDecoration(
//                color: color, borderRadius: BorderRadius.circular(22.0)),
//          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          flex: 6,
          child: Text(translate('category.$name'),
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
        ),
        Expanded(
            flex: 4,
            child:
                Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 22.0))
      ],
    );
  }
}
