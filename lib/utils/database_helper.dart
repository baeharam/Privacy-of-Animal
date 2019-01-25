import 'dart:async';
import 'dart:io';

import 'package:privacy_of_animal/model/real_profile_table_model.dart';
import 'package:privacy_of_animal/resources/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singletone
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + userDB;

    Database database = await openDatabase(path, version: 1, onCreate: _createDB);
    return database;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(tagTableCreationSQL);
    await db.execute(realProfileTableCreationSQL);
    await db.execute(fakeProfileTableCreationSQL);
  }
}