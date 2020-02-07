import 'dart:convert';

Truth clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Truth.fromMap(jsonData);
}

String clientToJson(Truth data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Truth {
  Truth({this.id, this.title});

  int id;
  String title;

  factory Truth.fromMap(Map<String, dynamic> json) => new Truth(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
      };
}
