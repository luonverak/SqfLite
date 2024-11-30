import 'package:local_stograge/sqflite/init_database.dart';
import 'package:local_stograge/sqflite/model.dart';

class ControllerDatabase {
  final _init = InitDatabase();

  Future<void> insertData({required Model model}) async {
    final db = await _init.initDatabase();
    await db.insert(_init.table, model.toJson());
  }
}
