import 'package:crud_using_sqlite/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Repository {
  //from import 'package:crud_using_sqlite/db_helper/database_connection.dart';

  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await DatabaseConnection().setDatabase();
      return _database;
    }
  }
  //insert user

  insertData(table, data) async {
    var connection = await database;

    return await connection?.insert(table, data);
  }

  //read data

  readData(table) async {
    var connection = await database;

    return await connection?.query(table);
  }

  //read single data

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

//update data

  UpdateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //delete userdata

  deletedata(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id $itemId=");
  }
}
