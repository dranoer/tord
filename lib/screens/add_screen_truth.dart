import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:truth_or_dare/components/round_botton.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/models/truth.dart';
import 'package:truth_or_dare/components/custom_appbar.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/database/database_provider_truth.dart';
import 'package:truth_or_dare/services/networking_post.dart';
import 'package:truth_or_dare/services/user_game.dart';

import 'menu_screen.dart';

class AddScreenTruth extends StatefulWidget {
  static const String id = 'add_screen_truth';

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreenTruth> {
  final messageTextController = TextEditingController();

  Size get size => Size(MediaQuery.of(context).size.width * 0.8,
      MediaQuery.of(context).size.width * 0.8);

  @override
  Widget build(BuildContext context) {
    String newDataTitle;
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
              /*Hero(tag: 'addtruth', child: */ CustomAppBar(
                  'add_truth_title') /*)*/,
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(15.0),
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
                              hintText: 'Enter a Truth',
                              hintStyle: TextStyle(
                                  color: Colors.deepPurple[100],
                                  fontSize: 18.0)),
                          style: TextStyle(color: Colors.white),
                          /*onChanged: (newData) {
                          newDataTitle = newData;
                        },*/
                          onSubmitted: (text) async {
                            messageTextController.clear();
                            if (text != null) {
                              // Add to Local Database
                              Truth newTruth = Truth(title: text);
                              await DBProviderTruth.db.newClient(newTruth);

                              // Add to Server Database
                              UserGame newGame = new UserGame(
                                id: null,
                                content: text,
                                game_type: 1,
                              );

                              final bool success =
                                  await postGame(body: newGame.toMap());
                              print(success);

                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                    /*FlatButton(
                    child: Icon(Icons.add, color: Colors.white, size: 32.0),
                    color: Colors.blue[600],
                    onPressed: () async {
                      messageTextController.clear();
                      if (newDataTitle != null) {
                        Truth newTruth = Truth(title: newDataTitle);
                        await DBProviderTruth.db.newClient(newTruth);

                        setState(() {});
                      }
                    },
                  ),*/
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
                height: size.height * 1.2,
                width: size.width * 0.9,
                child: FutureBuilder<List<Truth>>(
                  future: DBProviderTruth.db.getAllClients(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Truth>> snapshot) {
//              playerCount = snapshot.data.length;
                    if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(color: kLightGrey);
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Truth item = snapshot.data[index];
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(color: Colors.red),
                            child: ListTile(
                              title: Text(
                                item.title,
                                style: TextStyle(
                                    fontSize: 20.0, color: kLightGrey),
                              ),
                              trailing: Column(
                                children: <Widget>[
                                  Container(
                                    child: IconButton(
                                      icon: Icon(Icons.delete_forever,
                                          color: kLightGrey),
                                      onPressed: () {
                                        DBProviderTruth.db
                                            .deleteClient(item.id);
                                        setState(() {});
                                      },
                                    ),
                                  )
                                ],
                              ),
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
                text: 'home_page',
                color: Colors.blue,
                onPress: () {
                  Navigator.pushNamed(context, MenuScreen.id,
                      arguments: ScreenArguments(
//                          range: args.range,
                        userTruth: args.userTruth,
                        userDare: args.userDare,
                        advancedPlayer: args.advancedPlayer,
                        soundHandler: args.soundHandler,
                      ));
                }),
          )
        ],
      ),
    );
  }
}
