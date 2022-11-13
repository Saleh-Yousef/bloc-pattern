import '../database/database_helper.dart';

class DatabaseConstants {
  static const String DB_NAME = 'nafith.db';
  static const String loginTableName = 'tbl_login';

  static const String loginColumnID = 'id';

  static final Map<String, SqlColumnDefinition> loginTable = {
    DatabaseConstants.loginColumnID: SqlColumnDefinition(key: 'PRIMARY KEY', value: '', type: 'INTEGER'),
    'jsonlogin': SqlColumnDefinition(value: 'NOT NULL', type: 'TEXT'),
  };
}
