import 'package:flutter/material.dart';
import 'package:truth_or_dare/components/category_item.dart';
import 'package:truth_or_dare/components/custom_appbar.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/database/database_provider_dare.dart';
import 'package:truth_or_dare/database/database_provider_truth.dart';
import 'package:truth_or_dare/models/dare.dart';
import 'package:truth_or_dare/models/truth.dart';
import 'package:truth_or_dare/screens/name_screen.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/components/selectable_row.dart';

class CatScreen extends StatefulWidget {
  static const String id = 'cat_screen';

  @override
  _CatScreenState createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  List<Dare> dareList;

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: <Widget>[
            CustomAppBar('category_title'),
            CategoryItem(args: args, range: 0, name: 'kid', imageName: 'kid'),
            CategoryItem(args: args, range: 1, name: 'teen', imageName: 'teen'),
            CategoryItem(args: args, range: 2, name: 'adult', imageName: 'hot'),
            CategoryItem(args: args, range: 3, name: 'hot', imageName: 'adult'),
            Container(
              // Local Truth
              child: FutureBuilder<List<Truth>>(
                  future: DBProviderTruth.db.getAllClients(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Truth>> snapshot) {
                    List<Truth> truthList = snapshot.data;
                    if (snapshot.hasData && snapshot.data.length >= 2) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 60.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, NameScreen.id,
                                arguments: ScreenArguments(
                                  range: 4,
                                  userTruth: truthList,
                                  userDare: dareList,
                                  advancedPlayer: args.advancedPlayer,
                                  soundHandler: args.soundHandler,
                                ));
                          },
                          child: SelectableRow(
                            name: 'user',
                            imageRoot: 'yours',
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(width: 0.0, height: 0.0);
                    }
                  }),
            ),
            Container(
              // Local Dare
              child: FutureBuilder<List<Dare>>(
                  future: DBProviderDare.db.getAllClients(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Dare>> snapshot) {
                    if (snapshot.hasData) {
                      dareList = snapshot.data;
                      return SizedBox(width: 0.0, height: 0.0);
                    } else {
                      return SizedBox(width: 0.0, height: 0.0);
                    }
                  }),
            ),
          ],
        ));
  }
}
