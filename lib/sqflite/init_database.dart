import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class InitDatabase {
  final table = "dating_note";

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String location = directory.path;

    String path = "$location/database.db";
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await _onCreateTable(
          db.batch(),
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );
  }

  Future<void> _onCreateTable(Batch batch) async {
    batch.execute(
        "CREATE TABLE $table(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT,date_time TEXT)");
    await batch.commit();
  }
}
