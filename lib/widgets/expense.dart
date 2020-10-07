import 'package:Expense/data/models/expense.dart';
import 'package:Expense/providers/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseWidget extends StatelessWidget {
  final Expense expense;

  ExpenseWidget({this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 10),
      margin: EdgeInsets.only(left: 17, right: 17, top: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: _buildColumn(context),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildAmountDisplay(context),
        _buildItemDisplay(context),
        _buildDateDisplay(context),
      ],
    );
  }

  Widget _buildAmountDisplay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${expense.amount}",
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(71, 8, 154, 1),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 7, left: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "RS",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 50.0,
            padding: EdgeInsets.only(bottom: 7, left: 7),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: expense.tags.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(label: Text(expense.tags[index])),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemDisplay(BuildContext context) {
    final _expensesProvider = Provider.of<Expenses>(context);
    return Container(
      margin: EdgeInsets.only(top: 2),
      width: double.infinity,
      child: Row(
        children: [
          Text(
            "${expense.itemDescription}",
            textAlign: TextAlign.justify,
            style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            )),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.save_alt, color: Color.fromRGBO(71, 8, 154, 1),),
            ),
            onTap: () => _expensesProvider.storeExpense(expense),
          ),
        ],
      ),
    );
  }

  Widget _buildDateDisplay(BuildContext context) {
    var newDt = DateFormat.yMMMEd().format(expense.time);
    var newDtHour = DateFormat.jm().format(expense.time);
    return Container(
      margin: EdgeInsets.only(top: 9),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(71, 8, 154, 1).withOpacity(0.8),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              "$newDtHour $newDt",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
