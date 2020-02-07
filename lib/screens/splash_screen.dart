import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/screens/menu_screen.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  var height = 100.0;

  AudioPlayer advancedPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  @override
  void initState() {
    super.initState();
    loadAnimation();
    loadData();
    loadMusic();
  }

  Future loadMusic() async {
    advancedPlayer = await AudioCache().loop("sound/bxcat.mp3");
  }

  Future<Timer> loadAnimation() async {
    return new Timer(Duration(milliseconds: 1), onStartLoading);
  }

  onStartLoading() async {
    setState(() {
      height = 500.0;
    });
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 1, milliseconds: 500), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pop(true);
    Navigator.pushNamed(context, MenuScreen.id,
        arguments: ScreenArguments(
          advancedPlayer: advancedPlayer,
          soundHandler: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 2),
            width: 180.0,
            height: height,
            child: Image(image: AssetImage('assets/images/nightmareinc.png')),
          ),
        ],
      ),
    );
  }
}
