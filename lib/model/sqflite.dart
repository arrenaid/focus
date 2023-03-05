import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "focusStorage.db";
  static const _databaseVersion = 1;
  static const table = "dayList";
  static const columnId = "id";
  static const columnDay = "day";
  static const columnPomodoroCount = "pomodoro";
  static const columnShortCount = "short";
  static const columnLongCount = "long";
  static const columnTag = "tag";

  //singleton
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(
        path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database database, int version) async {
    await database.execute(
        """
      CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY,
      $columnDay TEXT NOT NULL,
      $columnPomodoroCount INTEGER NOT NULL,
      $columnShortCount INTEGER NOT NULL,
      $columnLongCount INTEGER NOT NULL,
      $columnTag TEXT)
      """
    );
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.update(table, row, where: '$columnId = ${row[columnId]}');
  }


  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: "$columnId = ?", whereArgs: [id]);
  }
}