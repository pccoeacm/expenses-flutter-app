import 'package:Expense/data/models/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const String DATABASE_NAME = 'expenses.db';
  static const int DATABASE_VERSION = 1;

  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: _onCreate,
      version: DATABASE_VERSION,
    );
  }

  Future cleanDB() async {
    final db = await database;
    [EXPENSE_TABLE].forEach((table) {
      db.delete(table);
    });
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $EXPENSE_TABLE
      (
        idLocal INTEGER PRIMARY KEY,
        id INTEGER, 
        amount REAL, 
        itemDescription VARCHAR(555),
        time INTEGER, 
        tags TEXT  
      )
    ''');
  }
}
