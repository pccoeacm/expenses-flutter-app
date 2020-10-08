import 'package:Expense/providers/expenses.dart';
import 'package:Expense/widgets/addExpense.dart';
import 'package:Expense/widgets/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  void addExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddExpenseWidget();
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      )),
      enableDrag: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Container(
      height: double.infinity,
      width: MediaQuery
          .of(context)
          .size
          .width / 1.4,
      decoration: BoxDecoration(
        color: Color.fromRGBO(20, 20, 20, 1),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(71, 8, 154, 1),
      title: Text(
        'Expenses',
        style: TextStyle(fontSize: 17),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(Icons.mode_edit),
            onPressed: () {
              addExpense(context);
            })
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(10, 10, 10, 1),
      ),
      child: _buildListView(context),
    );
  }

  Widget _buildListView(context) {
    final _expenseListProvider = Provider.of<Expenses>(context);
    final List _expenseList = _expenseListProvider.expenseList;
    return ListView.builder(
        itemCount: _expenseList.length,
        itemBuilder: (_, index) {
          return Dismissible(
            key: Key(_expenseList[index].toString()),
            onDismissed: (direction) {
              _expenseList.removeAt(index);
            },
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm'),
                    content: const Text(
                        'Are you sure you wish to delete this expense?'),
                    actions: <Widget>[
                      FlatButton(
                          color: Colors.greenAccent,
                          textColor: Colors.black87,
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes, delete.')),
                      FlatButton(
                        color: Colors.redAccent,
                        textColor: Colors.black87,
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No, keep.'),
                      ),
                    ],
                  );
                },
              );
            },
            child: ExpenseWidget(
              expense: _expenseList[index],
            ),
          );
        });
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        addExpense(context);
      },
      backgroundColor: Color.fromRGBO(71, 8, 154, 1),
      child: Center(
        child: Icon(Icons.add_box),
      ),
    );
  }
}
