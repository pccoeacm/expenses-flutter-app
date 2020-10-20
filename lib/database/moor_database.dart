import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Expenses extends Table{
  IntColumn get id=> integer().autoIncrement()();
  RealColumn get amount=>real()();
  DateTimeColumn get time=>dateTime()();
  TextColumn get description=>text()();
}
@UseMoor(tables: [Expenses])
class AppDatabase extends _$AppDatabase{
  AppDatabase()
  : super(FlutterQueryExecutor.inDatabaseFolder(path: "db.sqlite"));

  @override
  int get schemaVersion=>1;

  Stream<List<Expense>> watchAllExpense()=>select(expenses).watch();
  Future<List<Expense>> getAllExpense()=>select(expenses).get();
  Future insertExpense(Expense expen)=>into(expenses).insert(expen);
}