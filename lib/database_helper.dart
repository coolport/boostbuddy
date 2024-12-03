import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Singleton pattern
  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_state.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE settings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key TEXT UNIQUE,
            value TEXT
          )''',
        );
        await db.execute(
          '''CREATE TABLE habits (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isChecked INTEGER
          )''',
        );
        // Create a table for feedback
        await db.execute(
          '''CREATE TABLE feedback (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            feedback TEXT,
            timestamp TEXT
          )''',
        );
      },
      version: 1,
    );
  }

  // Get a setting value by key
  static Future<String?> getSetting(String key) async {
    final db = await database;
    var result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (result.isNotEmpty) {
      return result.first['value'] as String?;
    }
    return null;
  }

  // Insert a setting value
  static Future<void> insertSetting(String key, String value) async {
    final db = await database;
    await db.insert(
      'settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all habits
  static Future<List<Map<String, dynamic>>> getHabits() async {
    final db = await database;
    var result = await db.query('habits');
    return result;
  }

  // Insert a habit
  static Future<void> insertHabit(String title, bool isChecked) async {
    final db = await database;
    await db.insert(
      'habits',
      {'title': title, 'isChecked': isChecked ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Remove a habit by title
  static Future<void> removeHabit(String title) async {
    final db = await database;
    await db.delete(
      'habits',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  // Update a habit's checked state
  static Future<void> updateHabit(String title, bool isChecked) async {
    final db = await database;
    await db.update(
      'habits',
      {'isChecked': isChecked ? 1 : 0},
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  // Insert feedback into the database
  static Future<void> insertFeedback(String feedback) async {
    final db = await database;
    await db.insert(
      'feedback',
      {'feedback': feedback, 'timestamp': DateTime.now().toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

