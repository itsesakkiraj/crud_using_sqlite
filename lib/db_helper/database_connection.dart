import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

//first step to createv db

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_sqlitecrud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createdatabase);
    return database;
  }

  Future<void> _createdatabase(Database database, int version) async {
    String sql =
        " CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, contact TEXT, address TEXT);";

    await database.execute(sql);
  }
}
