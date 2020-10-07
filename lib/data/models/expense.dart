const String EXPENSE_TABLE = "expense";

class Expense {
  String id;
  double amount;
  String itemDescription;
  DateTime time;
  List<String> tags;

  Expense({this.amount, this.itemDescription, this.time, this.tags = const []});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'amount': amount,
      'itemDescription': itemDescription,
      'time': time.microsecondsSinceEpoch,
      'tags': tags.join(','),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Expense.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    amount = map['amount'];
    itemDescription = map['itemDescription'];
    time = DateTime.fromMicrosecondsSinceEpoch(map['time']);
    tags = (map['tags'] as String)?.split(',') ?? null;
  }
}
