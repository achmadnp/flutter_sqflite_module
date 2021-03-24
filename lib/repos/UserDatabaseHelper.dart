import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabaseHelper {
  static final _databaseName = 'userDatabase.db';
  static final _databaseVersion = 1;

  static final table = 'user_table';

  static final columnUid = 'uid';
  static final columnUsername = 'username';

  UserDatabaseHelper._privateConstructor();

  static final UserDatabaseHelper instance =
      UserDatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE $table (
              $columnUid TEXT PRIMARY KEY,
              $columnUsername TEXT NOT NULL
            )
    ''');
  }

  Future<int> insertUserData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> querryAllUserData() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $table"));
  }

  Future<int> updateUserData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String uid = row[columnUid];
    return await db
        .update(table, row, where: '$columnUid = ?', whereArgs: [uid]);
  }

  Future<int> deleteUser(String uid) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnUid = ?', whereArgs: [uid]);
  }
}
