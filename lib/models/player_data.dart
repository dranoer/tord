import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:truth_or_dare/services/game.dart';
import 'dare.dart';
import 'player.dart';
import 'package:truth_or_dare/models/truth.dart';

class PlayerData extends ChangeNotifier {
  List<Player> _player = [
//    Player(name: 'Nazi', color: Colors.accents[9], wins: 0),
//    Player(name: 'Nightmare', color: Colors.accents[1], wins: 0),
  ];

  UnmodifiableListView<Player> get players {
    return UnmodifiableListView(_player);
  }

  int get playerCount {
    return _player.length;
  }

  void addPlayer(String newPlayer, String newColor, int truthCount) {
    final player = Player(name: newPlayer, color: newColor, wins: truthCount);
    _player.add(player);
    notifyListeners();
  }

  void deletePlayer(Player player) {
    _player.remove(player);
    notifyListeners();
  }

  void updatePlayer(Player player) {
    player.wins = player.wins + 1;
  }

  /* TRUTH */
  List<Game> _game = [
    Game(content: 'text from internal, text from internal, text from internal'),
  ];

  UnmodifiableListView<Game> get games {
    return UnmodifiableListView(_game);
  }

  int get truthCount {
    return _game.length;
  }

  void addTruth(String newGame) {
    final game = Game(content: newGame);
    _game.add(game);
    notifyListeners();
  }

  void deleteTruth(Game game) {
    _game.remove(game);
    notifyListeners();
  }

  /* DARE */
  List<Dare> _dare = [
    Dare(
        title:
            'dare 0 Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
    Dare(
        title:
            'dare 1 Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
    Dare(
        title:
            'dare 2 Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
  ];

  UnmodifiableListView<Dare> get dares {
    return UnmodifiableListView(_dare);
  }

  int get dareCount {
    return _dare.length;
  }

  void addDare(String newDare) {
    final dare = Dare(title: newDare);
    _dare.add(dare);
    notifyListeners();
  }

  void deleteDare(Dare dare) {
    _dare.remove(dare);
    notifyListeners();
  }

  /* Free Games */
  List<Game> _freeGames = [];

  UnmodifiableListView<Game> get freeGames {
    return UnmodifiableListView(_freeGames);
  }

  int get freeGameCount {
    return _freeGames.length;
  }
}
