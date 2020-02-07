import 'package:flutter/material.dart';
import 'package:truth_or_dare/models/player_data.dart';
import 'package:provider/provider.dart';
import 'package:truth_or_dare/widgets/player_tile.dart';

class PlayerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerData>(builder: (context, playerData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final player = playerData.players[index];

          return PlayerTile(
            taskTitle: player.name,
            selectedPlayer: player,
//            isChecked: player.isDone,
//            checkboxCallback: (checkboxState) {
//              playerData.updateTask(player);
//            },
            longPressCallback: () {
              playerData.deletePlayer(player);
            },
          );
        },
        itemCount: playerData.playerCount,
      );
    });
  }
}
