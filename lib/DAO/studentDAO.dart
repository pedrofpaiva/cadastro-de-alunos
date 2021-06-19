// Importamos o pacote sqflite
import 'package:sqflite/sqflite.dart';

class StudentDAO {
  static const _nomeDodatabase = "database.db";

  static Future<Database> _getConexao() async {
    // Buscamos o caminho padrão para databases de dados
    String databasesPath = await getDatabasesPath();
    // Unimos a String de caminho com o nome do database de dados
    String path = "$databasesPath $_nomeDodatabase";
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // Criamos a table 'datas'
      await db.execute(
          'CREATE TABLE students (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT)');
    });
    return database;
  }

  static Future<int> insertRecord(
      String table, Map<String, dynamic> data) async {
    Database database = await StudentDAO._getConexao();
    int result = await database.insert(table, data);
    print(result);
    return result;
  }

  static Future<int> updateRecord(
      String table, Map<String, dynamic> data) async {
    Database database = await StudentDAO._getConexao();
    int result = await database
        .update(table, data, where: "id=?", whereArgs: [data["id"]]);
    return result;
  }

  static Future<int> removeRecord(
      String table, Map<String, dynamic> data) async {
    Database database = await StudentDAO._getConexao();
    int result =
        await database.delete(table, where: "id=?", whereArgs: [data["id"]]);
    return result;
  }

  static Future<List<Map<String, dynamic>>> searchRecord(String table,
      {required String condition, required List<String> parameters}) async {
    Database database = await StudentDAO._getConexao();
    return await database.query(table, where: condition, whereArgs: parameters);
  }

  static Future<List<Map<String, dynamic>>> listRecords(String table) async {
    Database database = await StudentDAO._getConexao();
    List<Map<String, dynamic>> datas = await database.query(table);
    return datas;
  }
}
