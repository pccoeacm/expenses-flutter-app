import 'package:Expense/database/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseWidget extends StatefulWidget {

  @override
  _AddExpenseWidgetState createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  double amount = 0;

  String item = "Empty";

  @override
  Widget build(BuildContext context) {
    final _expenseListProvider = Provider.of<AppDatabase>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.only(top: 38,left: 28,right: 28, bottom: 28),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value){
                amount=double.parse(value);
              },
              onFieldSubmitted: (value){
                amount=double.parse(value);
                print(amount);
              },
              style: TextStyle(
                fontSize: 18,
              ),
              cursorColor: Color.fromRGBO(71, 8, 154, 1),
              cursorRadius: Radius.circular(18),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Amount",
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
                focusedBorder:UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(71, 8, 154, 1)
                  )
                ) 
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              onChanged: (value){
                item=value;
              },
              onFieldSubmitted: (value){
                item=value;
                print(item);
              },
              style: TextStyle(
                fontSize: 18,
              ),
              cursorColor: Color.fromRGBO(71, 8, 154, 1),
              cursorRadius: Radius.circular(18),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Item Description",
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
                focusedBorder:UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(71, 8, 154, 1)
                  )
                ) 
              ),
            ),
            Expanded(child: Container()),
            Material(
              color: Color.fromRGBO(71, 8, 154, 1),
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                onTap: (){
                  if (amount == 0 || item == 'Empty') {
                    _alertEmptyInput(amount == 0, item == 'Empty');
                  } else {
                    // amount,item
                    _expenseListProvider.insertExpense(new Expense(amount: amount, time: DateTime.now(), description: item));
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Center(
                    child: Text(
                      "Add Expense",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _alertEmptyInput(hasAmount, hasMessage) async {
    String empty = '';
    if (hasAmount) {
      empty = 'amount';
    } else {
      empty = 'message';
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bad Input'),
          content: Text('You cannot leave ' + empty + ' empty!'),
          actions: <Widget>[
            TextButton(
              child: Text('Understood'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}