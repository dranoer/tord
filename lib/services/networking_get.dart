import 'package:http/http.dart' as http;
import 'package:truth_or_dare/services/game.dart';
import 'dart:convert';

import 'package:truth_or_dare/services/game_package.dart';

// Make network request.
// http().get returns a Future that contains Response.
/*
Future<Game> fetchGame() async {
  final response = await http.get('http://10.0.2.2:8080/demo/premiumpackages');

  if (response.statusCode == 200) {
    // Convert the response body into a JSON Map
    // Convert the JSON Map into a Game
    return Game.fromJason(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
*/

//const String api = "http://10.0.2.2:8080/"; Emulator
//const String api = "http://192.168.1.40:8080/"; My Device
const String api = "http://37.152.178.33:8080/"; // Server

Future<List<GamePackage>> fetchPremiumPackages() async {
  final response = await http.get(api + 'demo/premiumpackages');

  if (response.statusCode == 200) {
    return allPGPFromJson(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Game>> fetchGames() async {
  final response = await http.get(api + 'demo/freepackages');

  if (response.statusCode == 200) {
    return gameByPackage(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
