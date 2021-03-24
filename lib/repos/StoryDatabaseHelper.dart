import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StoryDatabaseHelper {
  static final _databaseName = 'storyDatabase.db';
  static final _databaseVersion = 1;

  static final table = 'story_table';

  static final columnStoryUid = 'storyUid';
  static final columnTitle = 'storyTitle';
  static final columnBody = 'body';
  static final columnUseruid = 'userUid';

  StoryDatabaseHelper._privateConstructor();

  static final StoryDatabaseHelper instance =
      StoryDatabaseHelper._privateConstructor();

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
            $columnStoryUid TEXT PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnBody TEXT NOT NULL,
            $columnUseruid TEXT NOT NULL
          )
    ''');
  }

  Future<int> insertStoryData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllStory() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $table"));
  }

  Future<int> updateStory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String storyUid = row[columnStoryUid];
    return await db.update(table, row,
        where: '$columnStoryUid = ?', whereArgs: [storyUid]);
  }

  Future<int> deleteStory(String storyUid) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '$columnStoryUid = ?', whereArgs: [storyUid]);
  }
}
