import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/constants.dart';
import 'package:truth_or_dare/models/player_data.dart';
import 'package:truth_or_dare/models/player.dart';

class PlayerTile extends StatelessWidget {
  PlayerTile(
      {
//        this.isChecked,
      this.taskTitle,
      this.selectedPlayer,
//      this.checkboxCallback,
      this.longPressCallback});

//  final bool isChecked;
  final String taskTitle;
  final Player selectedPlayer;
//  final Function checkboxCallback;
  final Function longPressCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0),
      child: Card(
        color: kDarkGrey,
        child: ListTile(
            onLongPress: longPressCallback,
//            leading: Icon(Icons.accessibility_new),
            title: Text(
              taskTitle,
              style: TextStyle(fontSize: 20.0, color: kLightGrey),
//        style: TextStyle(
//            decoration: isChecked ? TextDecoration.lineThrough : null),
            ),
            trailing: Column(
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(Icons.delete_forever, color: kLightGrey),
                    onPressed: () {
                      Provider.of<PlayerData>(context)
                          .deletePlayer(selectedPlayer);
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
