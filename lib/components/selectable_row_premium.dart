import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectableRowPremium extends StatelessWidget {
  SelectableRowPremium({this.packageName, this.categoryName, this.imageRoot});

  final String packageName;
  final String categoryName;
  final String imageRoot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 70.0, bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          Fluttertoast.showToast(
            msg: translate('error.unavailable').toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image.network(imageRoot),
              height: 65.0,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(22.0)),
            ),
            SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$packageName',
                    style: TextStyle(fontSize: 22.0, color: Colors.white)),
                Text(translate('category.$categoryName'),
                    style: TextStyle(fontSize: 18.0, color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
