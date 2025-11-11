import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'product.dart';

class DatabaseHelper {
  //create database instances
  static Database? _database;
  static DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    //create database
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, "products.db");

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return _database!;
  }

  // Create table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        quantity INTEGER,
        price REAL
      )
    ''');
  }

  // Insert product
  Future<int> insertProduct(Product p) async {
    Database db = await instance.database;
    return await db.insert("products", p.toMap());
  }

  // Get all products
  Future<List<Product>> getProducts() async {
    Database db = await instance.database;
    var rows = await db.query("products");
    return rows.map((e) => Product.fromRow(e)).toList();
  }
}
