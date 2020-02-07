import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

class UserGame {
  UserGame({this.id, this.content, this.game_type});

  final int id;
  final String content;
  final int game_type;

  // Converting JSON
  factory UserGame.fromJson(Map<String, dynamic> json) => new UserGame(
        id: json['id'],
        content: json['content'],
        game_type: json['game_type'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "game_type": game_type,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["content"] = content;
    map["game_type"] = game_type;

    return map;
  }
}
