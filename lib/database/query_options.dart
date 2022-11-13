import '../utils/mixin.dart';

class QueryOptions<T> {
  final String tableName;

  final bool? distinct;
  final String? whereCondition;
  final List<dynamic>? whereArgs;

  final List<Model<T>?>? data;
  final Model<T>? fromModel;
  final T? Function(Map<String, dynamic>)? toModel;
  final List<String>? columns;
  final String? orderBy;
  final int? offset;
  final int? pageSize;

  QueryOptions(
      {required this.tableName,
      this.distinct = false,
      this.whereCondition,
      this.data,
      this.fromModel,
      this.toModel,
      this.whereArgs,
      this.columns,
      this.orderBy,
      this.offset,
      this.pageSize});

  factory QueryOptions.delete(String tableName, String? whereCondition, List<dynamic>? whereArgs) {
    return QueryOptions(
      tableName: tableName,
      whereArgs: whereArgs,
      whereCondition: whereCondition,
    );
  }

  factory QueryOptions.truncate(String tableName) {
    return QueryOptions(
      tableName: tableName,
    );
  }

  factory QueryOptions.update(
    String tableName,
    String whereCondition,
    List<dynamic>? whereArgs, [
    Model<T>? fromModel,
    List<String>? columns,
  ]) {
    return QueryOptions(tableName: tableName, whereArgs: whereArgs, whereCondition: whereCondition, fromModel: fromModel, columns: columns);
  }

  factory QueryOptions.select(
    String tableName, [
    bool? distinct,
    String? whereCondition,
    List<dynamic>? whereArgs,
    Model<T>? fromModel,
    List<String>? columns,
    String? orderBy,
  ]) {
    return QueryOptions(
        tableName: tableName,
        distinct: distinct,
        whereArgs: whereArgs,
        whereCondition: whereCondition,
        fromModel: fromModel,
        columns: columns,
        orderBy: orderBy);
  }
}
