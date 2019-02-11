import 'dart:async';
import 'dart:io';

import 'package:privacy_of_animal/resources/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  static SharedPreferences _sharedPreferences;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<SharedPreferences> get sharedPreferences async {
    if(_sharedPreferences == null){
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await _initializeDatabase();
    }
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + userDB;

    Database database = await openDatabase(path, version: 1, onCreate: _createDB);
    return database;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(tagTableCreationSQL);
    await db.execute(realProfileTableCreationSQL);
    await db.execute(fakeProfileTableCreationSQL);
    await db.execute(celebrityUrlTableCreationSQL);
  }
}