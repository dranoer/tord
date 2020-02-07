import 'dart:convert';

Dare clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Dare.fromMap(jsonData);
}

String clientToJson(Dare data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Dare {
  Dare({this.id, this.title});

  int id;
  String title;

  factory Dare.fromMap(Map<String, dynamic> json) => new Dare(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
      };
}
