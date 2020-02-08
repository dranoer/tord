import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:share/share.dart';
import 'package:truth_or_dare/components/AdHelper.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/screens/add_screen_dare.dart';
import 'package:truth_or_dare/screens/add_screen_truth.dart';
import 'package:truth_or_dare/screens/cat_screen.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:truth_or_dare/services/game_package.dart';
import 'package:truth_or_dare/services/networking_get.dart';
import 'package:truth_or_dare/components/selectable_row_premium.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;

class MenuScreen extends StatefulWidget {
  static const String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Size get size => Size(MediaQuery.of(context).size.width * 0.8,
      MediaQuery.of(context).size.width * 0.8);

  ScreenArguments get args => ModalRoute.of(context).settings.arguments;

  // Bottom Navigation ->
  int currentPage = 1;
  GlobalKey bottomNavigationKey = GlobalKey(); //<-

  Future<List<GamePackage>> premiumGame;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(translate('dialog.exit.title'),
                textAlign: TextAlign.center),
            content: new Text(translate('dialog.exit.content'),
                textAlign: TextAlign.center),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(translate('button.no')),
              ),
              new FlatButton(
                onPressed: () {
                  args.advancedPlayer.pause();
                  SystemNavigator.pop();
                },
                child: new Text(translate('button.yes')),
              ),
            ],
          ),
        )) ??
        false;
  }

  /*@override
  void dispose() {
    super.dispose();
    args.advancedPlayer.pause();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args.advancedPlayer.pause();
  }

  @override
  void deactivate() {
    super.deactivate();
    args.advancedPlayer.pause();
  }*/

  String _latestHardwareButtonEvent;

  StreamSubscription<HardwareButtons.VolumeButtonEvent>
      _volumeButtonSubscription;
  StreamSubscription<HardwareButtons.HomeButtonEvent> _homeButtonSubscription;
  StreamSubscription<HardwareButtons.LockButtonEvent> _lockButtonSubscription;

  @override
  void initState() {
    super.initState();
    premiumGame = fetchPremiumPackages();

    _volumeButtonSubscription =
        HardwareButtons.volumeButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = event.toString();
      });
    });

    _homeButtonSubscription = HardwareButtons.homeButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = 'HOME_BUTTON';
        args.advancedPlayer.pause();
      });
    });

    _lockButtonSubscription = HardwareButtons.lockButtonEvents.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = 'LOCK_BUTTON';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _volumeButtonSubscription?.cancel();
    _homeButtonSubscription?.cancel();
    _lockButtonSubscription?.cancel();
    Ads.hideBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: _getPage(currentPage),
          ),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(
              iconData: Icons.settings,
              title: "",
            ),
            TabData(
              iconData: Icons.accessibility_new,
              title: "",
              /*onclick: () {
                    final FancyBottomNavigationState fState =
                        bottomNavigationKey.currentState;
                    fState.setPage(2);
                  }*/
            ),
            TabData(iconData: Icons.card_giftcard, title: "")
          ],
          initialSelection: 1,
          key: bottomNavigationKey,
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
          activeIconColor: kLightGrey,
//        circleColor: Colors.green,
          textColor: kLightGrey,
          barBackgroundColor: kDarkGrey,
          inactiveIconColor: kLightBlue,
        ),
      ),
    );
  }

  // Tabs
  _getPage(int page) {
//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    switch (page) {
      case 1: // Game Page
        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: size.height),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                          child: Image.asset('assets/images/movingcircle.gif')),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, CatScreen.id,
                              arguments: ScreenArguments(
                                  advancedPlayer: args.advancedPlayer,
                                  soundHandler: args.soundHandler));
                        },
                        child: Container(
                          child: Text(translate('button.start'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold)),
                          margin: EdgeInsets.symmetric(
                              vertical: size.height / 3,
                              horizontal: size.height / 3),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AddScreenTruth.id,
                            arguments: ScreenArguments(
                              choice: true,
                              advancedPlayer: args.advancedPlayer,
                              soundHandler: args.soundHandler,
                            ));
                      },
//                      child: Hero(
//                        tag: 'addtruth',
                      child: Text(
                        translate('button.add_truth'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            decoration: TextDecoration.none),
                      ),
//                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AddScreenDare.id,
                            arguments: ScreenArguments(
                              choice: false,
                              advancedPlayer: args.advancedPlayer,
                              soundHandler: args.soundHandler,
                            ));
                      },
                      child: Hero(
                        tag: 'adddare',
                        child: Text(
                          translate('button.add_dare'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      case 2: // Offers Page
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
                              style:
                                  TextStyle(fontSize: 22.0, color: Colors.red)),
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
      default: // Setting PAge
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFEFEFF4),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 40.0),
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: translate('setting.common.title'),
                    tiles: [
                      SettingsTile(
                        title: translate('setting.common.language'),
                        subtitle: translate('setting.common.default'),
                        leading: Icon(Icons.language),
                        onTap: () {},
                      ),
                      SettingsTile.switchTile(
                        title: translate('setting.common.sound'),
                        leading: Icon(Icons.volume_up),
                        switchValue: args.soundHandler,
                        onToggle: (bool value) {
                          setState(() {
                            args.soundHandler = value;
                            if (args.soundHandler == true) {
                              args.advancedPlayer.resume();
                            }
                            if (args.soundHandler == false) {
                              args.advancedPlayer.pause();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: translate('setting.game.title'),
                    tiles: [
                      SettingsTile(
                        title: translate('setting.game.share'),
                        leading: Icon(Icons.share),
                        onTap: () {
                          Share.share(
                              'check out my new app at https://play.google.com/store/apps/details?id=com.nightmareinc.truth_or_dare',
                              subject: 'TorD');
                        },
                      ),
//                      SettingsTile(
//                        title: 'Rate',
//                        leading: Icon(Icons.star),
//                      ),
                    ],
                  ),
                  SettingsSection(
                    title: translate('setting.about.title'),
                    tiles: [
                      SettingsTile(
                        title: translate('setting.about.game_version_title'),
                        subtitle:
                            translate('setting.about.game_version_number'),
                        leading: Icon(Icons.android),
                      ),
                      SettingsTile(
                        title: translate('setting.about.contact'),
                        leading: Icon(Icons.email),
                        onTap: () {
                          showDialog(
//                            barrierDismissible: false,
                              context: context,
                              builder: (_) => WillPopScope(
                                    onWillPop: () {},
                                    child: AssetGiffyDialog(
                                      title: Text(
                                        '',
                                        style: TextStyle(fontSize: 1.0),
                                      ),
                                      image: Image.asset(
                                        'assets/images/catmusic.gif',
                                        fit: BoxFit.cover,
                                      ),
                                      entryAnimation:
                                          EntryAnimation.BOTTOM_RIGHT,
                                      description: Text(
                                        translate('dialog.share'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      buttonOkColor: kDarkGrey,
                                      buttonCancelColor: Colors.blue,
                                      buttonOkText:
                                          Text(translate('button.meow')),
                                      buttonCancelText: Text(
                                        translate('button.cool'),
//                                onOkButtonPressed: () {},
//                                onCancelButtonPressed: () {},
                                      ),
                                    ),
                                  ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
    }
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
