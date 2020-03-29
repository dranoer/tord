import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:truth_or_dare/components/selectable_row_premium.dart';
import 'package:truth_or_dare/services/game_package.dart';

import '../../constants.dart';

class OfferTab extends StatelessWidget {
  const OfferTab({@required this.premiumGame});

  final Future<List<GamePackage>> premiumGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
          padding: EdgeInsets.only(top: 80.0),
          child: FutureBuilder<List<GamePackage>>(
            future: premiumGame,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    // Get Category by name
                    String categoryName =
                        getCategory(snapshot.data[index].category_id);
                    return SelectableRowPremium(
                      packageName: snapshot.data[index].package_name,
                      categoryName: categoryName,
                      imageRoot: snapshot.data[index].package_image,
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              } else if (snapshot.hasError) {
//                    return Text('Error > ' + "${snapshot.error}");
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(translate('error.offline_error'),
                          style: TextStyle(fontSize: 22.0, color: Colors.red)),
                      SizedBox(height: 16.0),
                      Image.asset('assets/images/sadsimpsone0.gif'),
                    ],
                  ),
                );
              }

              return CircularProgressIndicator();
            },
          )),
    );
  }

  String getCategory(String age) {
    String category;

    if (age == '10') {
      category = 'kid';
    }
    if (age == '13') {
      category = 'teen';
    }
    if (age == '18') {
      category = 'adult';
    }
    if (age == '30') {
      category = 'hot';
    }

    return category;
  }
}
