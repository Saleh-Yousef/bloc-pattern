import 'dart:io';

import 'package:sqflite/sqflite.dart';

import '../constants/db_constans.dart';

class DatabaseHelper {
  //change the int to the new version number
  int databaseVersion = 1;

  Database? _database;
  Future<Database?> get database async {
    if (_database == null) {
      _database = await _databaseFactory();
    }
    return _database;
  }

  _databaseFactory() async {
    List initScript = [
      // always should have the latest tabels
      _createTable(DatabaseConstants.loginTableName, DatabaseConstants.loginTable),
    ];

    List migrationScriptsDBVersion_2 = [];

    final databasesPath = await getDatabasesPath();
    // NOTE: to make sure that the path is exist,
    try {
      await Directory(databasesPath).create(recursive: true);
    } on Exception catch (_) {}

    // NOTE: the full path will be implictly inserted
    return openDatabase(DatabaseConstants.DB_NAME, version: databaseVersion, onCreate: (database, version) async {
      initScript.forEach((script) async => await database.execute(script));
    }, onUpgrade: (database, oldVersion, newVersion) async {
      // if (oldVersion == 1 && newVersion == 2) {
      //    migrationScriptsDBVersion_2.forEach((script) async => await database.execute(script));

      // }
    });
  }

  _createTable(String tableName, Map<String, SqlColumnDefinition> columns) {
    String statement = '';
    int index = -1;
    columns.forEach((key, column) {
      index++;
      String _statement = '$key ${column.type} ${column.key} ${column.value}';
      _statement = _statement.trim();
      if ((index + 1) != columns.length) {
        _statement += ', ';
      }
      statement += _statement;
    });
    return 'CREATE TABLE $tableName ($statement)';
  }
}

_dropTable(String tableName) {
  return 'DROP TABLE IF EXISTS $tableName';
}

class SqlColumnDefinition {
  final String type;
  final String value;
  final String key;
  SqlColumnDefinition({required this.type, required this.value, this.key = ''});
}
