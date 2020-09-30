import 'package:Expense/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses with ChangeNotifier {

  List<Expense> _expenseList = [
    Expense(amount: 1800, itemDescription: "Grocery Items",time:DateTime.now() ),
    Expense(amount: 120, itemDescription: "Stationary Items",time:DateTime.now() ),
    
  ];

  List<Expense> get expenseList => _expenseList ;

  void addToList(double amount, String itemDescription, {DateTime time}) {
    _expenseList.add(Expense(amount: amount,itemDescription: itemDescription, time: DateTime.now()));
    notifyListeners();
  }

}