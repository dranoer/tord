import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/constants.dart';
import 'dart:math';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:truth_or_dare/database/database_provider_player.dart';
import 'package:truth_or_dare/models/player.dart';
import 'package:truth_or_dare/models/player_data.dart';
import 'package:truth_or_dare/screens/add_screen_dare.dart';
import 'package:truth_or_dare/screens/add_screen_truth.dart';
import 'package:truth_or_dare/screens/game_screen.dart';
import '../components/spinner/board_view.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truth_or_dare/components/AdHelper.dart';

class SpinningScreen extends StatefulWidget {
  static const String id = 'spinning_screen';

  @override
  _SpinningScreenState createState() => _SpinningScreenState();
}

class _SpinningScreenState extends State<SpinningScreen>
    with SingleTickerProviderStateMixin {
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;
  List<Player> finalPlayer;
  int pCount;
  bool isTouched;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isTouched = true;

    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Center(
              child: Container(
                  child: AnimatedBuilder(
                      animation: _ani,
                      builder: (context, child) {
                        final _value = _ani.value;
                        final _angle = _value * this._angle;
                        return FutureBuilder<List<Player>>(
                          future: DBProvider.db.getAllClients(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Player>> snapshot) {
                            if (snapshot.data != null) {
                              pCount = snapshot.data
                                  .length; // putting it inside snapshot.hasData will prevent showing dialog
                            }
                            if (snapshot.hasData) {
                              finalPlayer = snapshot.data;
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  BoardView(
                                      items: snapshot.data,
                                      current: _current,
                                      angle: _angle),
                                  _buildGo(),
                                ],
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      }))),
        ));
  }

  _buildGo() {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: Text(
            translate('button.go'),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () async {
          if (isTouched) {
            _animation();

            Future.delayed(const Duration(milliseconds: 6000), () {
              setState(() async {
                try {
                  final _value = _ani.value;
                  final _base = (2 * pi / pCount / 2) / (2 * pi);
                  final _index =
                      (((_base + (_value * _angle + _current)) % 1) * pCount)
                          .floor();

                  // finding the Current Player
                  final Player currentPlayer =
                      await DBProvider.db.getClient(_index + 1);
                  final String cpName = currentPlayer
                      .name; // Current Player Name, can not use directly from currentPlayer.name

                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WillPopScope(
                      onWillPop: () {},
                      child: AssetGiffyDialog(
                        image: Image.asset('assets/images/pickme.gif',
                            fit: BoxFit.cover),
                        title: Text(
                          cpName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                        description: Text(translate('dialog.spinning.content'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0)),
                        buttonOkColor: Colors.blue,
                        buttonCancelColor: kLightGrey,
                        buttonOkText: Text(translate('button.truth')),
                        buttonCancelText: Text(translate('button.dare')),
                        onOkButtonPressed: () {
                          Navigator.of(context).pop(true);
                          if (args.range != 4) {
                            // Questions comes from server
                            Navigator.pushNamed(context, GameScreen.id,
                                    arguments: ScreenArguments(
                                        player: currentPlayer,
                                        choice: true,
                                        range: args.range,
                                        userTruth: args.userTruth,
                                        userDare: args
                                            .userDare)) /*.then((value) {
                              Ads.showBannerAd();
                            })*/
                                ;
                          } else {
                            // Questions comes from local database
                            if (args.userTruth.length > 1) {
                              // Check for null empty truths
                              Navigator.pushNamed(context, GameScreen.id,
                                      arguments: ScreenArguments(
                                          player: currentPlayer,
                                          choice: true,
                                          range: args.range,
                                          userTruth: args.userTruth,
                                          userDare: args
                                              .userDare)) /*.then((value) {
                                Ads.showBannerAd();
                              })*/
                                  ;
                            } else {
                              Fluttertoast.showToast(
                                msg: translate('error.truth_count').toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.pushNamed(context, AddScreenTruth.id,
                                  arguments: ScreenArguments(
                                      userTruth: args.userTruth,
                                      userDare: args.userDare));
                            }
                          }
                        },
                        onCancelButtonPressed: () {
                          Navigator.of(context).pop(true);
                          if (args.range != 4) {
                            Navigator.pushNamed(context, GameScreen.id,
                                    arguments: ScreenArguments(
                                        player: currentPlayer,
                                        choice: false,
                                        range: args.range,
                                        userTruth: args.userTruth,
                                        userDare: args
                                            .userDare)) /*.then((value) {
                              Ads.showBannerAd();
                            })*/
                                ;
                          } else {
                            if (args.userDare.length > 1) {
                              // Check for null empty dares
                              Navigator.pushNamed(context, GameScreen.id,
                                      arguments: ScreenArguments(
                                          player: currentPlayer,
                                          choice: false,
                                          range: args.range,
                                          userTruth: args.userTruth,
                                          userDare: args
                                              .userDare)) /*.then((value) {
                                Ads.showBannerAd();
                              })*/
                                  ;
                            } else {
                              Fluttertoast.showToast(
                                msg: translate('error.dare_count').toString(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.pushNamed(context, AddScreenDare.id,
                                  arguments: ScreenArguments(
                                      userTruth: args.userTruth,
                                      userDare: args.userDare));
                            }
                          }
                        },
                      ),
                    ),
                  );
                } catch (e) {
                  print('error >>' + e);
                }
              });
            });
          }
        },
      ),
    );
  }

  Future _animation() {
    if (!_ctrl.isAnimating) {
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
        _ctrl.reset();
      });
    }

    isTouched = false;
  }

  Future<int> _buildResult(_value) async {
    final playerData = Provider.of<PlayerData>(context);
    var _base = (2 * pi / pCount / 2) / (2 * pi);
    var _index =
        (((_base + (_value * _angle + _current)) % 1) * pCount).floor();

    final String _name = playerData.players[_index].name;
    final int idd = playerData.players[_index].id;
    return idd;
  }
}
