import 'package:sqflite/sqlite_api.dart';
import 'package:todo/repositories/database_connection.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    //* Initialize Database Connection
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //* Inserting data to the Table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  //* Read Data from the Table
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  //* Read Data by Id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //* Update Data from the Table
  updateData(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //* Delete data from the Table
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  //* Read data from table by Column Name
  readDataByColumnName(table, columnName, columnValue) async {
    var connection = await database;
    return await connection
        .query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}
