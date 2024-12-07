import 'package:local_stograge/sqflite/init_database.dart';
import 'package:local_stograge/sqflite/model.dart';

class ControllerDatabase {
  final _init = InitDatabase();

  Future<void> insertData({required Model model}) async {
    final db = await _init.initDatabase();
    await db.insert(_init.table, model.toJson());
  }

  Future<List<Model>> getData() async {
    final db = await _init.initDatabase();
    List<Map<String, dynamic>> list = await db.query(_init.table);
    return list.map((e) => Model.fromJson(e)).toList();
  }

  Future<void> editData({required Model model}) async {
    final db = await _init.initDatabase();
    await db.update(_init.table, model.toJson(),
        where: 'id=?', whereArgs: [model.id]);
  }

  Future<void> deleteData({required int id}) async {
    final db = await _init.initDatabase();
    await db.delete(_init.table, where: 'id=?', whereArgs: [id]);
  }
}
