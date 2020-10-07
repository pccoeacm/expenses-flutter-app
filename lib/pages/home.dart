import 'dart:ui';

import 'package:Expense/providers/expenses.dart';
import 'package:Expense/providers/search.dart';
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
        )
      ),
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
      width: MediaQuery.of(context).size.width/1.4,
      decoration: BoxDecoration(
        color: Color.fromRGBO(20, 20, 20, 1),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final _searchProvider = Provider.of<Search>(context);
    final _expensesProvider = Provider.of<Expenses>(context);
    return AppBar(
      backgroundColor: Color.fromRGBO(71, 8, 154, 1),
      title: Text(
        'Expenses',
        style: TextStyle(
          fontSize: 17
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () => _searchProvider.toggleSearch()),
        IconButton(icon: Icon(Icons.storage), onPressed: () => _expensesProvider.loadStoredExpenses()),
        IconButton(icon: Icon(Icons.cloud), onPressed: () => _expensesProvider.loadMockExpenseList()),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final _searchProvider = Provider.of<Search>(context);
    final _expensesProvider = Provider.of<Expenses>(context);
    final _expenseTagList = _expensesProvider.expenseList.expand((element) => element.tags).toSet();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(10, 10, 10, 1),
      ),
      child: Column(
        children: [
          _searchProvider.state != SearchState.Idle
              ? Expanded(
                  flex: 1,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _expenseTagList.length,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    separatorBuilder: (_, int index) => SizedBox(width: 8),
                    itemBuilder: (_, int index) {
                      String tag = _expenseTagList.elementAt(index);
                      return InkWell(
                        onTap: () => _searchProvider.tagSelected(tag),
                        child: Chip(
                          label: Text('#$tag'),
                          backgroundColor: Colors.black.withOpacity(_searchProvider.queryTags.contains(tag) ? 0.6 : 0.1),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(),
          Expanded(
            flex: 10,
            child: _buildListView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(context) {
    final _searchProvider = Provider.of<Search>(context);
    final _expenseListProvider = Provider.of<Expenses>(context);
    final List _expenseList = _expenseListProvider.getExpenseListFiltered(_searchProvider.queryTags);
    return ListView.builder(
        itemCount: _expenseList.length,
        itemBuilder: (_, index) => InkWell(
              onLongPress: () => _expenseListProvider.storeExpense(_expenseList[index]),
              child: ExpenseWidget(expense: _expenseList[index]),
            ));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        addExpense(context);
      }, 
      backgroundColor: Color.fromRGBO(71, 8, 154, 1),
      child: Center(
        child: Icon(Icons.add_box),
      ),
    );
  }

}