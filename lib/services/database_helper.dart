
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Mengakses database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('profile_app.db');
    return _database!;
  }

  // Membuat database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Membuat tabel
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE activity_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        activity TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  // Menambahkan log aktivitas
  Future<int> insertLog(String activity) async {
    final db = await database;

    return await db.insert('activity_logs', {
      'activity': activity,
      'timestamp': DateTime.now().toString(),
    });
  }

  // Mengambil semua riwayat log
  Future<List<Map<String, dynamic>>> getLogs() async {
    final db = await database;

    return await db.query(
      'activity_logs',
      orderBy: 'id DESC',
    );
  }

  // Menutup database
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
