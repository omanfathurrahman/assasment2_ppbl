import 'package:assasment2_ppbl/models/tukang_ojek.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE tukangojek ( id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT NOT NULL, nopol TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertTukangOjek(List<TukangOjek> daftarTukangOjek) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var tukangojek in daftarTukangOjek) {
      result = await db.insert('tukangojek', tukangojek.toMap());
    }
    return result;
  }

  Future<List<TukangOjek>> retrieveTukangOjek() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('tukangojek');
    return queryResult.map((e) => TukangOjek.fromMap(e)).toList();
  }
}
