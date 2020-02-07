import 'dart:convert';

Player clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Player.fromMap(jsonData);
}

String clientToJson(Player data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Player {
  Player({this.id, this.name, this.color, this.wins});

  /*final */ int id;
  /*final */ String name;
  /*final */ String color;
  int wins;

  factory Player.fromMap(Map<String, dynamic> json) => new Player(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        wins: json["wins"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "color": color,
        "wins": wins,
      };
}
