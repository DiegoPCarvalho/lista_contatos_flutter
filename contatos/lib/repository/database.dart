import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class SQLiteDataBase {
  static Database? db;

  Future<Database> getDatabase() async {
    if (db == null) {
      return await iniciarBancoDados();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBancoDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]);
      }
    });
    return db;
  }
}

Map<int, String> scripts = {
  1: '''CREATE TABLE contatos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeCompleto TEXT,
        telefone TEXT,
        email TEXT,
        fotoUrl TEXT
      );'''
};
