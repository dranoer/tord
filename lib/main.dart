import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'models/player_data.dart';
import 'screens/cat_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/name_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/scratcher_screen.dart';
import 'screens/spinning_screen.dart';
import 'screens/game_screen.dart';
import 'screens/result_screen.dart';
import 'screens/add_screen_truth.dart';
import 'screens/add_screen_dare.dart';

void main() async {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // Localization
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US', 'fa', 'tr'],
  );

  runApp(LocalizedApp(delegate, TruthDare()));
}

class TruthDare extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _TruthDareState createState() => _TruthDareState();
}

class _TruthDareState extends State<TruthDare> {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: ChangeNotifierProvider(
        create: (context) => PlayerData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
//            GlobalWidgetsLocalizations.delegate, // Disable for Farsi
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (context) => SplashScreen(),
            MenuScreen.id: (context) => MenuScreen(),
            CatScreen.id: (context) => CatScreen(),
            ScratcherScreen.id: (context) => ScratcherScreen(),
            NameScreen.id: (context) => NameScreen(),
            SpinningScreen.id: (context) => SpinningScreen(),
            GameScreen.id: (context) => GameScreen(),
            ResultScreen.id: (context) => ResultScreen(),
            AddScreenTruth.id: (context) => AddScreenTruth(),
            AddScreenDare.id: (context) => AddScreenDare(),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            fontFamily: 'Kalam',
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}
