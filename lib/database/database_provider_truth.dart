import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:truth_or_dare/models/truth.dart';

class DBProviderTruth {
  DBProviderTruth._();

  static final DBProviderTruth db = DBProviderTruth._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TruthDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Truth ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT"
          ")");
    });
  }

  newClient(Truth newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Truth");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Truth (id,title)"
        " VALUES (?,?)",
        [id, newClient.title]);
    return raw;
  }

  blockOrUnblock(Truth client) async {
    final db = await database;
    Truth blocked = Truth(id: client.id, title: client.title);
    var res = await db.update("Truth", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Truth newClient) async {
    final db = await database;
    var res = await db.update("Truth", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Truth", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Truth.fromMap(res.first) : null;
  }

  Future<List<Truth>> getBlockedClients() async {
    final db = await database;

    print("workssstruth");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Truth", where: "blocked = ? ", whereArgs: [1]);

    List<Truth> list =
        res.isNotEmpty ? res.map((c) => Truth.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Truth>> getAllClients() async {
    final db = await database;
    var res = await db.query("Truth");
    List<Truth> list =
        res.isNotEmpty ? res.map((c) => Truth.fromMap(c)).toList() : [];
    return list;
  }

  getLenght() async {
    final db = await database;
    var res = await db.query("Truth");
    List<Truth> list =
        res.isNotEmpty ? res.map((c) => Truth.fromMap(c)).toList() : [];
    int count = list.length;
    return count;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Truth", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Truth");
  }
}
