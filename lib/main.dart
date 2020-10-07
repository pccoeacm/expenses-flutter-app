import 'package:Expense/pages/home.dart';
import 'package:Expense/providers/expenses.dart';
import 'package:Expense/providers/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Expenses()),
        ChangeNotifierProvider(create: (_) => Search()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter",
        home: HomePage(),
      ),
    );
  }
}
