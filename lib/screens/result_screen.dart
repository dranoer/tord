import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/components/AdHelper.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/database/database_provider_player.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/models/player.dart';
import 'package:truth_or_dare/models/player_data.dart';
import 'package:truth_or_dare/components/custom_appbar.dart';
import 'package:truth_or_dare/screens/spinning_screen.dart';
import 'package:truth_or_dare/components/round_botton.dart';
import 'menu_screen.dart';
import 'package:truth_or_dare/screens/menu_screen.dart';

class ResultScreen extends StatefulWidget {
  static const String id = 'result_screen';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Size get size => Size(MediaQuery.of(context).size.width * 0.8,
      MediaQuery.of(context).size.width * 0.8);

  @override
  void dispose() {
    super.dispose();
    Ads.hideBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Consumer<PlayerData>(builder: (context, playerData, child) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Column(
            children: <Widget>[
              CustomAppBar('result_title'),
              Expanded(
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(),
                  padding:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                  child: FutureBuilder<List<Player>>(
                      future: DBProvider.db.getAllClients(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Player>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(color: kLightGrey);
                            },
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              Player item = snapshot.data[index];
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(color: Colors.red),
                                child: ListTile(
                                    title: Text(
                                      item.name,
                                      style: TextStyle(
                                          fontSize: 20.0, color: kLightGrey),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            child: Text(
                                          '${item.wins}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: kLightGrey),
                                        ))
                                      ],
                                    )),
                              );
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RoundButton(
                      text: translate('home_page'),
                      color: kDarkGrey800,
                      onPress: () {
                        Navigator.of(context).pop(true);
                        Navigator.pushNamed(context, MenuScreen.id,
                            arguments: ScreenArguments(
                              advancedPlayer: args.advancedPlayer,
                              soundHandler: args.soundHandler,
                            ));
//                        args.advancedPlayer.pause();
                      },
                    ),
                    RoundButton(
                      text: translate('play_again'),
                      color: Colors.blue,
                      onPress: () {
                        Navigator.pushNamed(context, SpinningScreen.id,
                            arguments: ScreenArguments(
                              range: args.range,
                              userTruth: args.userTruth,
                              player: args.player,
                              freeGameList: args.freeGameList,
                              choice: args.choice,
                            ));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
