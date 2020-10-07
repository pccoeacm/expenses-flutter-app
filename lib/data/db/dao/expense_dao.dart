import 'package:Expense/data/models/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqlite_api.dart';

import '../app_database.dart';

class ExpenseDao {
  Future<Database> _db;

  ExpenseDao(AppDatabase appDatabase) {
    _db = appDatabase.database;
  }

  Future<List<Expense>> getAll() async {
    final db = await _db;
    final result = await db.query(EXPENSE_TABLE);
    return compute(parseList, result);
  }

  Future removeAll() async {
    final db = await _db;
    await db.delete(EXPENSE_TABLE);
  }

  Future insertAll(List<Expense> expenses) async {
    final db = await _db;
    final batch = db.batch();
    expenses.forEach((m) {
      batch.insert(EXPENSE_TABLE, m.toMap());
    });
    return await batch.commit(noResult: true);
  }

  Future insert(Expense expense) async {
    final db = await _db;
    final batch = db.batch();
    batch.insert(EXPENSE_TABLE, expense.toMap());
    return await batch.commit(noResult: true);
  }
}

List<Expense> parseList(List<Map<String, dynamic>> results) => results.map((x) => Expense.fromMap(x)).toList();
