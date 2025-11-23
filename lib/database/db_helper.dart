import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _db;

  DBHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "cashwise.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute("""
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,        -- stored as ISO string
        label TEXT,
        type TEXT NOT NULL         -- 'income' or 'expense'
      );
    """);

    await db.execute("""
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL
      );
    """);
  }

  // INSERT TRANSACTION
  Future<int> addTransaction(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("transactions", data);
  }

  // FETCH ALL TRANSACTIONS
  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final db = await database;
    return await db.query("transactions", orderBy: "date DESC");
  }

  // TOTAL INCOME
  Future<double> getTotalIncome() async {
    final db = await database;
    final result = await db.rawQuery("""
      SELECT SUM(amount) AS total FROM transactions WHERE type='income'
    """);

    return result.first["total"] == null
        ? 0.0
        : result.first["total"] as double;
  }

  // TOTAL EXPENSE
  Future<double> getTotalExpense() async {
    final db = await database;
    final result = await db.rawQuery("""
      SELECT SUM(amount) AS total FROM transactions WHERE type='expense'
    """);

    return result.first["total"] == null
        ? 0.0
        : result.first["total"] as double;
  }

  // CURRENT BALANCE
  Future<double> getBalance() async {
    double income = await getTotalIncome();
    double expense = await getTotalExpense();
    return income - expense;
  }
}
