import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:truth_or_dare/constants.dart';

class ScratcherScreen extends StatelessWidget {
  static const String id = 'scratcher_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Scratch To Win!',
            style: TextStyle(
              fontSize: 30.0,
//            fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.amber[700],
            ),
          ),
          SizedBox(height: 50.0),
          Container(
            color: kBackgroundColor,
            child: Scratcher(
              brushSize: 40,
              threshold: 50,
              color: Colors.grey[850],
              onChange: (value) {
                print("Scratch progress: $value%");
              },
              onThreshold: () {
                print("Threshold reached, you won!");
              },
              child: Image(
                height: 300,
                width: 300,
                image: AssetImage('assets/images/youwin.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
