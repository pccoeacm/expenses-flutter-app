import 'package:Expense/pages/home.dart';
import 'package:Expense/providers/expenses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>Expenses(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter",
        home: HomePage(),
      ),
    );
  }
}
