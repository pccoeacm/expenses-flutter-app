class Expense {
  double amount;
  String itemDescription;
  DateTime time;
  List<String> tags;

  Expense({this.amount, this.itemDescription, this.time, this.tags = const []});
}