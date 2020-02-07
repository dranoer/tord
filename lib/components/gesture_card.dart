import 'package:flutter/material.dart';

class GestureCard extends StatelessWidget {
  GestureCard(
      {this.cardText,
      this.color,
      this.icon,
      this.corners,
      this.margins,
      this.height,
      this.onTap});

  final Function onTap;
  final String cardText;
  final Color color;
  final IconData icon;
  final List<double> corners;
  final double height;
  final List<double> margins;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: EdgeInsets.only(
            top: margins[0], left: margins[1], right: margins[2]),
//        child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 36.0, color: Colors.deepPurple[100]),
            SizedBox(width: 6.0),
            Text('$cardText',
                style: TextStyle(fontSize: 22.0, color: Colors.white)),
          ],
        ),
//        ),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(corners[0]),
                topRight: Radius.circular(corners[1]),
                bottomLeft: Radius.circular(corners[2]),
                bottomRight: Radius.circular(corners[3]))),
      ),
    );
  }
}
