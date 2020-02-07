import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/components/custom_appbar.dart';
import 'package:truth_or_dare/components/gesture_card.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/database/database_provider_dare.dart';
import 'package:truth_or_dare/database/database_provider_player.dart';
import 'package:truth_or_dare/database/database_provider_truth.dart';
import 'package:truth_or_dare/models/dare.dart';
import 'package:truth_or_dare/models/player.dart';
import 'package:truth_or_dare/models/player_data.dart';
import 'dart:math';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/components/round_botton.dart';
import 'package:truth_or_dare/models/truth.dart';

import 'package:truth_or_dare/screens/result_screen.dart';
import 'package:truth_or_dare/services/game.dart';
import 'package:truth_or_dare/services/networking_get.dart';
import 'package:like_button/like_button.dart';
import 'package:truth_or_dare/services/networking_post.dart';

class GameScreen extends StatefulWidget {
  static const String id = 'truthdare_screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Size get size => Size(MediaQuery.of(context).size.width * 0.8,
      MediaQuery.of(context).size.width * 0.8);

  Future<List<Game>> freeGame;
  final List<String> question = []; // A list just for truths or dares
  int favorite;
  double _fontSize = 20;

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    Game newGame = new Game(
      id: favorite,
      content: "",
      like_count: null,
      dislike_count: null,
      game_type: null,
      min_age: "",
    );

    /// send your request here
    final bool success = await gameLike(favorite, body: newGame.toMap());

    /// if failed, you can do nothing
    return success ? !isLiked : isLiked;

//    return isLiked;
  }

  Future<bool> onDisLikeButtonTapped(bool isLiked) async {
    Game newPost = new Game(
      id: favorite,
      content: "",
      like_count: null,
      dislike_count: null,
      game_type: null,
      min_age: "",
    );

    /// send your request here
    final bool success =
        await await gameDislike(favorite, body: newPost.toMap());

    /// if failed, you can do nothing
    return success ? !isLiked : isLiked;

//    return isLiked;
  }

  @override
  void initState() {
    super.initState();
    freeGame = fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Consumer<PlayerData>(builder: (context, data, child) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomPadding: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints.expand(height: size.height),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            child:
                                Image.asset('assets/images/movingcircle1.gif'),
                          ),
                          GestureDetector(
                            child: Container(
                              child: Text(args.choice ? 'Truth' : 'Dare',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35.0)),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.height / 3,
                                  horizontal: size.height / 3),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 40.0, right: 40.0, bottom: 70.0),
                        child: Container(
                          child: FutureBuilder<List<Game>>(
                            future: freeGame,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && args.range != 4) {
                                if (args.choice == true) {
                                  // if User chooses Truth
                                  if (args.range == 0) {
                                    // check if user chooses truth
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 1) {
                                        // getting only the truths
                                        if (snapshot.data[i].min_age == '10') {
                                          question.add(snapshot.data[i]
                                              .content); // adding only the truths to the list
                                        }
                                      }
                                    }
                                  }
                                  if (args.range == 1) {
                                    // check if user chooses truth
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 1) {
                                        if (snapshot.data[i].min_age == '13') {
                                          question
                                              .add(snapshot.data[i].content);
                                        }
                                      }
                                    }
                                  }
                                  if (args.range == 2) {
                                    // check if user chooses truth
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 1) {
                                        if (snapshot.data[i].min_age == '18') {
                                          question
                                              .add(snapshot.data[i].content);
                                        }
                                      }
                                    }
                                  }
                                  if (args.range == 3) {
                                    // check if user chooses truth
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 1) {
                                        if (snapshot.data[i].min_age == '30') {
                                          question
                                              .add(snapshot.data[i].content);
                                        }
                                      }
                                    }
                                  }
                                }
                                //////////////////////////////////////// D A R E
                                // if User chooses Dare
                                if (args.choice == false) {
                                  if (args.range == 0) {
                                    // check if user choose dare
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 0) {
                                        if (snapshot.data[i].min_age == '10') {
                                          question
                                              .add(snapshot.data[i].content);
                                        }
                                      }
                                    }
                                  }
                                  if (args.range == 1) {
                                    // check if user chooses truth
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 0) {
                                        if (snapshot.data[i].min_age == '13') {
                                          question
                                              .add(snapshot.data[i].content);
                                        }
                                      }
                                    }
                                  }
                                  if (args.range == 2) {
                                    // check if user chooses truth
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 0) {
                                        if (snapshot.data[i].min_age == '18') {
                                          question
                                              .add(snapshot.data[i].content);
                                        }
                                      }
                                    }
                                  }
                                  if (args.range == 3) {
                                    // check if user chooses truth
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      if (snapshot.data[i].game_type == 0) {
                                        if (snapshot.data[i].min_age == '30') {
                                          question
                                              .add(snapshot.data[i].content);
                                        }
                                      }
                                    }
                                  }
                                }

                                // Setup data for showing to User
                                final random =
                                    Random().nextInt(question.length);
                                final int r = random;
                                // id for like/dislike
                                final int id = snapshot.data[r].id;
                                favorite = id; // <--
                                return Text(question[r],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: _fontSize,
                                        color: Colors.white));
                              }
                              if (snapshot.hasError && args.range != 4) {
//                            return Text('Error > ' + "${snapshot.error}");
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Text(translate('error.offline'),
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.red)),
                                );
                              }
                              if (args.range == 4) {
                                // Check for data from Internal Database
                                if (args.choice == true) {
                                  // Add truths from args
                                  for (int j = 0;
                                      j < args.userTruth.length;
                                      j++) {
                                    question.add(args.userTruth[j].title);
                                  }
                                }
                                if (args.choice == false) {
                                  // Add dares from args
                                  for (int j = 0;
                                      j < args.userDare.length;
                                      j++) {
                                    question.add(args.userDare[j].title);
                                  }
                                }

                                // Setup data for showing to User
                                final random =
                                    Random().nextInt(question.length);
                                final int r = random;
                                return Text(question[r],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: _fontSize,
                                        color: Colors.white));
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            LikeButton(
                              onTap: onLikeButtonTapped,
                              size: 30.0,
                              circleColor: CircleColor(
                                  start: Color(0xffef5350),
                                  end: Color(0xfff43336)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xffef5350),
                                dotSecondaryColor: Color(0xffef5350),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.favorite /*thumb_up*/,
                                  color: isLiked
                                      ? Colors.redAccent[700]
                                      : Colors.grey,
                                  size: 30.0,
                                );
                              },
                              likeCount: 0 /*favorite*/,
                              countBuilder:
                                  (int count, bool isLiked, String text) {
                                var color = isLiked ? Colors.red : Colors.grey;
                                Widget result;
                                if (count == 0) {
                                  result = Text(
                                    "",
//                              "like",
                                    style: TextStyle(color: color),
                                  );
                                } else
                                  result = Text(
                                    "",
//                              text,
                                    style: TextStyle(color: color),
                                  );
                                return result;
                              },
                            ),
                            /*SizedBox(width: 10.0),
                            LikeButton(
                              onTap: onDisLikeButtonTapped,
                              size: 30.0,
                              circleColor: CircleColor(
                                  start: Color(0xFF2962FF),
                                  end: Color(0xFF448AFF)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xFF82B1FF),
                                dotSecondaryColor: Color(0xFF82B1FF),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.thumb_down,
                                  color: isLiked
                                      ? Colors.blueAccent[700]
                                      : Colors.grey,
                                  size: 30.0,
                                );
                              },
                              likeCount: favorite,
                              countBuilder:
                                  (int count, bool isLiked, String text) {
                                var color = isLiked ? Colors.blue : Colors.grey;
                                Widget result;
                                if (count == 0) {
                                  result = Text(
//                              "dislike",
                                    "",
                                    style: TextStyle(color: color),
                                  );
                                } else
                                  result = Text(
                                    "",
//                              text,
                                    style: TextStyle(color: color),
                                  );
                                return result;
                              },
                            ),*/
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: RoundButton(
                        text: translate('fail'),
                        color: kDarkGrey,
                        onPress: () async {
                          Navigator.of(context).pop(true);
                          Navigator.pushNamed(context, ResultScreen.id,
                              arguments: ScreenArguments(
                                range: args.range,
                                userTruth: args.userTruth,
                                player: args.player,
                                freeGameList: args.freeGameList,
                                choice: args.choice,
                                advancedPlayer: args.advancedPlayer,
                                soundHandler: args.soundHandler,
                              ));
                        },
                      ),
                    ),
                    SizedBox(width: 70.0),
                    Expanded(
                      child: RoundButton(
                        text: translate('done'),
                        color: Colors.blue,
                        onPress: () {
                          Navigator.of(context).pop(true);

                          Player currentPlayer = Player(
                              id: args.player.id,
                              name: args.player.name,
                              color: args.player.color,
                              wins: args.player.wins + 1);

                          DBProvider.db.updateClient(currentPlayer);

                          Navigator.pushNamed(context, ResultScreen.id,
                              arguments: ScreenArguments(
                                range: args.range,
                                userTruth: args.userTruth,
                                player: args.player,
                                freeGameList: args.freeGameList,
                                choice: args.choice,
                                advancedPlayer: args.advancedPlayer,
                                soundHandler: args.soundHandler,
                              ));
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
