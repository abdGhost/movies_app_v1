import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        poster TEXT NOT NULL,
        imdbId TEXT NOT NULL
      )
    ''');
  }

  Future<int> addFavorite(Map<String, dynamic> movie) async {
    final db = await instance.database;
    return await db.insert('favorites', movie);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await instance.database;
    return await db.query('favorites');
  }

  Future<int> removeFavorite(int id) async {
    final db = await instance.database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
