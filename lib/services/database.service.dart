import '../constants/db_constans.dart';
import '../database/database_provider.dart';
import '../database/query_options.dart';
import '../locator.dart';

/// contains a misc methods to facilitate the access to database including error handling
class DatabaseService {
  final DatabaseProvider? databaseProvider = locator<DatabaseProvider>();

  Future<int> delete(QueryOptions queryOptions) async {
    final response = await databaseProvider!.delete(queryOptions);
    return Future.value(response);
  }

  Future<int> count(String tableName) async {
    return await databaseProvider!.count(tableName);
  }

  Future<int> countByCoulmn(QueryOptions queryOptions) async {
    return await databaseProvider!.countByCoulmn(queryOptions);
  }

  Future<void> clear(String tableName) {
    return databaseProvider!.delete(QueryOptions.delete(tableName, null, null));
  }

  Future<void> insert(QueryOptions queryOptions) async {
    try {
      await databaseProvider!.insert(queryOptions);
    } catch (error) {
      throw DataBaseException(error.toString());
    }
  }

  Future<List<T?>> select<T>(QueryOptions queryOptions) async {
    try {
      return await databaseProvider!.select<T>(queryOptions as QueryOptions<T>);
    } catch (error) {
      throw DataBaseException(error.toString());
    }
  }

  Future<List<T>?> rawSelect<T>(QueryOptions queryOptions) async {
    try {
      return await databaseProvider!.rawSelect<T>(queryOptions as QueryOptions<T>);
    } catch (error) {
      throw DataBaseException(error.toString());
    }
  }

  Future<void> rawDelete(QueryOptions queryOptions) async {
    try {
      return await databaseProvider!.rawDelete(queryOptions);
    } catch (error) {
      throw DataBaseException(error.toString());
    }
  }

  Future<void> insertMany(QueryOptions queryOptions) async {
    try {
      await databaseProvider!.insertMany(queryOptions);
    } catch (error) {
      throw DataBaseException(error.toString());
    }
  }

  Future<void> update(QueryOptions queryOptions) async {
    final response = await databaseProvider!.update(queryOptions);

    if (response == 0) {
      throw DataBaseException('trying to update undefined row');
    }
  }

  Future<void> clearAll() async {
    try {
      await databaseProvider!.rawDelete(QueryOptions.truncate(DatabaseConstants.loginColumnID));
    } catch (error) {
      throw DataBaseException(error.toString());
    }
  }
}

class DataBaseException implements Exception {
  final String message;
  DataBaseException(this.message);
  @override
  String toString() => message;
}
