import 'package:audioplayers/audioplayers.dart';
import 'package:truth_or_dare/models/dare.dart';
import 'package:truth_or_dare/models/player.dart';
import 'package:truth_or_dare/models/truth.dart';
import 'package:truth_or_dare/services/game.dart';

class ScreenArguments {
  ScreenArguments(
      {this.player,
      this.choice,
      this.range,
      this.freeGameList,
      this.userTruth,
      this.userDare,
      this.advancedPlayer,
      this.soundHandler});

  final Player player;
  final bool choice; // true == truth, false == dare
  final int range; // 0 == kid, 1 == teen, 2 == adult, 3 == hot
  final Future<List<Game>> freeGameList;
  final List<Truth> userTruth;
  final List<Dare> userDare;
  final AudioPlayer advancedPlayer;
  /*final */ bool soundHandler;
}
