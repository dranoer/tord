import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

class GamePackage {
  GamePackage(
      {this.id,
      this.sku,
      this.ispremium,
      this.category_id,
      this.package_name,
      this.package_image});

  final int id;
  final String sku;
  final bool ispremium;
  final String category_id;
  final String package_name;
  final String package_image;

  // Converting JSON
  factory GamePackage.fromJason(Map<String, dynamic> json) => new GamePackage(
        id: json['id'],
        ispremium: json['ispremium'],
        category_id: json['category_id'],
        package_name: json['package_name'],
        package_image: json['package_image'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ispremium": ispremium,
        "category_id": 'category_id',
        "package_name": 'package_name',
        "package_image": 'package_image',
      };
}

// PGP == Premium Game Packages
List<GamePackage> allPGPFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<GamePackage>.from(
      jsonData.map((x) => GamePackage.fromJason(x)));
}
