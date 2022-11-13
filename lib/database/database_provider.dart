import 'dart:async';

import 'package:bloc_poc/database/query_options.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

/// contains database default operation with ORM like style,
/// think of this class as it was the database it self
/// NOTE: please refer to `DatabaseService` for the additional methods
class DatabaseProvider extends DatabaseHelper {
  Future<int> count(String tableName) async {
    final db = await (database);
    int? count = Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $tableName'));
    return Future.value(count);
  }

  Future<int> countByCoulmn(QueryOptions queryOptions) async {
    final db = await (database);
    var rawList = await db!.query(
      queryOptions.tableName,
      where: queryOptions.whereCondition,
      whereArgs: queryOptions.whereArgs,
      columns: queryOptions.columns,
      orderBy: queryOptions.orderBy,
      distinct: queryOptions.distinct,
    );
    return Future.value(rawList.length);
  }

  Future<int> delete(QueryOptions queryOptions) async {
    final db = await (database);
    return await db!.delete(
      queryOptions.tableName,
      where: queryOptions.whereCondition,
      whereArgs: queryOptions.whereArgs,
    );
  }

  Future<int> deleteMany(QueryOptions queryOptions) async {
    final db = await (database);
    return db!.delete(
      queryOptions.tableName,
      where: queryOptions.whereCondition,
      whereArgs: queryOptions.whereArgs,
    );
  }

  Future<void> insertMany(QueryOptions queryOptions) async {
    final db = await (database);

    db!.transaction((txn) async {
      Batch batch = txn.batch();
      for (var row in queryOptions.data!) {
        batch.insert(queryOptions.tableName, row!.toDatabaseRow());
      }
      batch.commit();
    });
  }

  Future<void> insert(QueryOptions queryOptions) async {
    final db = await (database);
    await db!.insert(queryOptions.tableName, queryOptions.fromModel!.toJson());
  }

  Future<List<T?>> select<T>(QueryOptions<T> queryOptions) async {
    final db = await (database);
    var result = await db!.query(
      queryOptions.tableName,
      where: queryOptions.whereCondition,
      whereArgs: queryOptions.whereArgs,
      columns: queryOptions.columns,
      orderBy: queryOptions.orderBy,
      distinct: queryOptions.distinct,
    );
    return result.map((row) => queryOptions.toModel!(row)).toList();
  }

  Future<List<T>?> rawSelect<T>(QueryOptions<T> queryOptions) async {
    final db = await database;
    var result;
    if (queryOptions.whereCondition == null || queryOptions.whereCondition!.isEmpty) {
      result = await db!.rawQuery(
          'SELECT * FROM ${queryOptions.tableName} ORDER BY ${queryOptions.orderBy} LIMIT ${queryOptions.pageSize} OFFSET ${queryOptions.offset}');
    } else {
      result = await db!.rawQuery(
          'SELECT * FROM ${queryOptions.tableName} WHERE ${queryOptions.whereCondition} ORDER BY ${queryOptions.orderBy} LIMIT ${queryOptions.pageSize} OFFSET ${queryOptions.offset}',
          queryOptions.whereArgs);
    }

    return result.map((row) => queryOptions.toModel!(row)).toList();
  }

  Future<void> rawDelete<T>(QueryOptions<T> queryOptions) async {
    final db = await (database);

    db!.transaction((txn) async {
      Batch batch = txn.batch();
      batch.rawDelete('DELETE FROM ${queryOptions.tableName}');
      batch.commit();
    });
  }

  Future<int> update(QueryOptions queryOptions) async {
    final db = await (database);
    return db!.update(
      queryOptions.tableName,
      queryOptions.fromModel!.toDatabaseRow(),
      whereArgs: queryOptions.whereArgs,
      where: queryOptions.whereCondition,
    );
  }
}
