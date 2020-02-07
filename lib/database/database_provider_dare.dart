import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:truth_or_dare/models/dare.dart';
import 'package:truth_or_dare/models/truth.dart';

class DBProviderDare {
  DBProviderDare._();

  static final DBProviderDare db = DBProviderDare._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "DareDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Dare ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT"
          ")");
    });
  }

  newClient(Dare newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Dare");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Dare (id,title)"
        " VALUES (?,?)",
        [id, newClient.title]);
    return raw;
  }

  blockOrUnblock(Dare client) async {
    final db = await database;
    Dare blocked = Dare(id: client.id, title: client.title);
    var res = await db.update("Dare", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Dare newClient) async {
    final db = await database;
    var res = await db.update("Dare", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Dare", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Dare.fromMap(res.first) : null;
  }

  Future<List<Dare>> getBlockedClients() async {
    final db = await database;

    print("worksssdare");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Dare", where: "blocked = ? ", whereArgs: [1]);

    List<Dare> list =
        res.isNotEmpty ? res.map((c) => Dare.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Dare>> getAllClients() async {
    final db = await database;
    var res = await db.query("Dare");
    List<Dare> list =
        res.isNotEmpty ? res.map((c) => Dare.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Dare", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Dare");
  }
}
