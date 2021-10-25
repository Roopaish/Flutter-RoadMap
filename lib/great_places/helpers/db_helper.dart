import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath =
        await sql.getDatabasesPath(); // finds path for both ios and android
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)'); // run query
    }, version: 1);
    // opens or create
    // onCreate runs frst time

    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql
          .ConflictAlgorithm.replace, // overwrite existing entries for same id
    );
  }
}
