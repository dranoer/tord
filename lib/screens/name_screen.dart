import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/models/player.dart';
import 'package:truth_or_dare/screens/spinning_screen.dart';
import 'package:truth_or_dare/database/database_provider_player.dart';
import 'package:truth_or_dare/components/custom_appbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truth_or_dare/components/round_botton.dart';

class NameScreen extends StatefulWidget {
  static const String id = 'name_screen';

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  Size get size => Size(MediaQuery.of(context).size.width * 0.8,
      MediaQuery.of(context).size.width * 0.8);

  final messageTextController = TextEditingController();
  int playerCount;

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomAppBar('add_player_title'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.only(left: 40.0, right: 40.0),
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 30.0, left: 30.0, bottom: 10.0),
                        child: TextField(
                          controller: messageTextController,
                          autofocus: false,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          showCursor: true,
                          decoration: InputDecoration(
                              hintText: translate('hint.enter_name').toString(),
                              hintStyle: TextStyle(
                                  color: Colors.deepPurple[100],
                                  fontSize: 18.0)),
                          style: TextStyle(color: Colors.white),
                          onSubmitted: (text) async {
                            messageTextController.clear();
                            if (text != null) {
                              Player newPlayer =
                                  Player(name: text, color: 'red', wins: 0);
                              await DBProvider.db.newClient(newPlayer);
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
                height: size.height * 1.2,
                width: size.width * 0.9,
                child: FutureBuilder<List<Player>>(
                  future: DBProvider.db.getAllClients(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Player>> snapshot) {
                    if (snapshot.hasData) {
                      playerCount = snapshot.data.length;
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(color: kLightGrey);
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Player item = snapshot.data[index];
                          return ListTile(
                            title: Text(
                              item.name,
                              style:
                                  TextStyle(fontSize: 20.0, color: kLightGrey),
                            ),
                            trailing: Column(
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.delete_forever,
                                        color: kLightGrey),
                                    onPressed: () {
                                      DBProvider.db.deleteClient(item.id);
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(110.0, 0.0, 110.0, 40.0),
            child: RoundButton(
                text: 'start',
                color: Colors.blue,
                onPress: () {
                  if (playerCount > 1) {
                    Navigator.pushNamed(context, SpinningScreen.id,
                        arguments: ScreenArguments(
                          range: args.range,
                          userTruth: args.userTruth,
                          userDare: args.userDare,
                          advancedPlayer: args.advancedPlayer,
                          soundHandler: args.soundHandler,
                        ));
                  } else {
                    Fluttertoast.showToast(
                      msg: translate('error.player_number').toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
