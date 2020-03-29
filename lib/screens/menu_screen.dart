import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truth_or_dare/components/AdHelper.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:truth_or_dare/screens/tabs/game_tab.dart';
import 'package:truth_or_dare/screens/tabs/offer_tab.dart';
import 'package:truth_or_dare/screens/tabs/setting_tab.dart';
import 'package:truth_or_dare/services/game_package.dart';
import 'package:truth_or_dare/services/networking_get.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
                  SystemNavigator.pop();
                },
                child: new Text(translate('button.yes')),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    premiumGame = fetchPremiumPackages();
  }

  @override
  void dispose() {
    super.dispose();
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
    switch (page) {
      case 1: // Game Page
        return GameTab(size: size, context: context);
      case 2: // Offers Page
        return OfferTab(premiumGame: premiumGame);
      default: // Setting PAge
        return SafeArea(
          child: SettingTab(context: context),
        );
    }
  }
}
