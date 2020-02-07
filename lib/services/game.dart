import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

class Game {
  Game(
      {this.id,
      this.content,
      this.like_count,
      this.dislike_count,
      this.game_type,
      this.min_age});

  final int id;
  final String content;
  final int like_count;
  final int dislike_count;
  final int game_type;
  final String min_age;

  // Converting JSON
  factory Game.fromJson(Map<String, dynamic> json) => new Game(
        id: json['id'],
        content: json['content'],
        like_count: json['like_count'],
        dislike_count: json['dislike_count'],
        game_type: json['game_type'],
        min_age: json['min_age'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "like_count": like_count,
        "dislike_count": dislike_count,
        "game_type": game_type,
        "min_age": min_age,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["content"] = content;
    map["like_count"] = like_count;
    map["dislike_count"] = dislike_count;
    map["game_type"] = game_type;
    map["min_age"] = min_age;

    return map;
  }
}

// PGP == Premium Game Packages
List<Game> gameByPackage(String str) {
  final jsonData = json.decode(str);
  return new List<Game>.from(jsonData.map((x) => Game.fromJson(x)));
}
