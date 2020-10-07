import 'dart:math';

import 'package:Expense/data/db/dao/expense_dao.dart';
import 'package:Expense/data/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses with ChangeNotifier {
  final ExpenseDao _dao;

  List<Expense> _expenseList = mockList();

  Expenses(this._dao);

  List<Expense> get expenseList => _expenseList;

  List<Expense> getExpenseListFiltered(Set<String> queryTags) {
    if (queryTags.isEmpty) {
      return expenseList;
    } else {
      return _expenseList.where((element) => element.tags.any((element) => queryTags.contains(element))).toList();
    }
  }

  void addToList(double amount, String itemDescription, {DateTime time}) {
    _expenseList.add(Expense(amount: amount, itemDescription: itemDescription, time: DateTime.now()));
    notifyListeners();
  }

  Future storeExpense(Expense expense) async {
    await _dao.insert(expense);
  }

  Future loadStoredExpenses() async {
    final results = await _dao.getAll();
    _expenseList = results;
    notifyListeners();
  }

  void loadMockExpenseList() {
    _expenseList = mockList();
    notifyListeners();
  }
}

/// Mock data
List<Expense> mockList() => List.generate(10, (index) {
      List<String> tags = ["food", "weekend", "shopping", "monthly", "night_life", "travel", "furniture"]..shuffle();
      return Expense(
          amount: Random().nextInt(1800).toDouble(), itemDescription: "Expense $index", time: DateTime.now(), tags: tags.sublist(0, index % tags.length));
    });
