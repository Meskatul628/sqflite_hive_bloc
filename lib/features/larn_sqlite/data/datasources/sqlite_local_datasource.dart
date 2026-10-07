import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/sqlite_item_model.dart';

abstract class SqliteLocalDataSource {
  Future<List<SqliteItemModel>> getItems();
  Future<int> addItem(SqliteItemModel item);
  Future<int> updateItem(SqliteItemModel item);
  Future<int> deleteItem(int id);
}

class SqliteLocalDataSourceImpl implements SqliteLocalDataSource {
  static Database? _database;
  static const String tableName = 'notes_table';
  static const String dbName = 'larn_sqlite.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // SQLite Table তৈরি করা
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // 📖 READ (SELECT * FROM table)
  @override
  Future<List<SqliteItemModel>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'id DESC',
    );
    return maps.map((e) => SqliteItemModel.fromMap(e)).toList();
  }

  // ➕ CREATE (INSERT INTO table)
  @override
  Future<int> addItem(SqliteItemModel item) async {
    final db = await database;
    return await db.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ✏️ UPDATE (UPDATE table WHERE id = ?)
  @override
  Future<int> updateItem(SqliteItemModel item) async {
    final db = await database;
    return await db.update(
      tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // ❌ DELETE (DELETE FROM table WHERE id = ?)
  @override
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
