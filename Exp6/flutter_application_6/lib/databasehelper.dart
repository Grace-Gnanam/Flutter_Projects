// databasehelper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'formula.dart'; // <-- CHANGED: Import formula.dart

class DatabaseHelper {
  static Database? _database;
  static DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, "formulas.db"); // <-- CHANGED: Database file name
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // <-- CHANGED: SQL command
        String sql = """
          CREATE TABLE formulas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            formula TEXT,
            category TEXT
          )
          """;
        await db.execute(sql);
      },
    );
    return _database!;
  }

  // <-- CHANGED: Method to insert a Formula
  Future<int> insertFormula(Formula formula) async {
    Database db = await instance.database;
    return await db.insert('formulas', {
      'name': formula.name,
      'formula': formula.formula,
      'category': formula.category,
    });
  }

  // <-- CHANGED: Method to read all Formulas
  Future<List<Formula>> readAllFormulas() async {
    Database db = await instance.database;
    final records = await db.query("formulas"); // <-- CHANGED: Table name
    return records.map((record) => Formula.fromRow(record)).toList();
  }

  // <-- CHANGED: Method to clear the table
  Future<int> resetFormulas() async {
    final db = await instance.database;
    return await db.delete("formulas"); // <-- CHANGED: Table name
  }
}