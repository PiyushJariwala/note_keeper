import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHalper {
  Database? database;

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await creatDB();
    }
  }

  Future<Database> creatDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, "note.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT, read INTEGER)";
        db.execute(query);
      },
    );
  }

  void insertData(String note, int readed) async {
    database = await checkDB();
    database!.insert("note", {"note": note, "read": readed});
  }

  void updateData(int id, String note, int readed) async {
    database = await checkDB();
    database!.update("note", {"note": note, "read": readed},
        where: "id = ?", whereArgs: [id]);
  }

  void completedRead(int id, int read) async {
    database = await checkDB();
    database!.update("note", {"read":read},where: "id = ?",whereArgs: [id]);
  }

  void deleteData(int id) async {
    database = await checkDB();
    database!.delete("note", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> readData() async {
    database = await checkDB();

    String query = "SELECT * FROM note";
    List<Map<String, dynamic>> list = await database!.rawQuery(query);

    return list;
  }
}
