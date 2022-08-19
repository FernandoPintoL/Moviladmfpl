import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async' show Future;
class DatabaseHelper{
  static const _databaseName = "admfpl.db";
  static const _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE empresa (id INTEGER PRIMARY KEY, nombre TEXT NOT NULL, url TEXT NOT NULL, url)');
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    Database db = await instance.database;
    return await db.insert(table, values);
  }

  Future<int> update(String table, Map<String, dynamic> values, String where, dynamic whereArgs) async {
    Database db = await instance.database;
    // int id = row[columnId];
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }
  Future<int> delete(String table, String id, dynamic idValues) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$id = ?', whereArgs: [idValues]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }
}
