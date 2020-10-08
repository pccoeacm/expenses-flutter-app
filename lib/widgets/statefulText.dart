import 'package:flutter/material.dart';

class StatefulText extends StatefulWidget {
  final value;
  final bool isAmount;

  StatefulText({this.value, this.isAmount});

  @override
  _StatefulTextState createState() =>
      _StatefulTextState(value: value, isAmount: isAmount);
}

class _StatefulTextState extends State<StatefulText> {
  final value;
  final isAmount;

  final _textController = TextEditingController();

  _StatefulTextState({this.value, this.isAmount});

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showEditDialog(context, isAmount);
      },
      child: Text(
        isAmount ? '${value.amount}' : '${value.itemDescription}',
        style: TextStyle(
          fontSize: isAmount ? 38 : 17,
          fontWeight: FontWeight.w600,
          color: isAmount
              ? Color.fromRGBO(71, 8, 154, 1)
              : Colors.black.withOpacity(0.8),
        ),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, bool isAmount) {
    var edit = isAmount ? 'Amount' : 'Description';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change $edit?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current $edit is ${isAmount ? value.amount : value.itemDescription}',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              TextField(
                controller: _textController,
                keyboardType: isAmount
                    ? TextInputType.numberWithOptions(decimal: true)
                    : TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter New $edit',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes, change.'),
              color: Colors.greenAccent,
              textColor: Colors.black87,
              onPressed: () {
                setState(() {
                  if (isAmount) {
                    value.amount = double.parse(_textController.text);
                  } else {
                    value.itemDescription = _textController.text;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No, keep.'),
              color: Colors.redAccent,
              textColor: Colors.black87,
              onPressed: () {
                Navigator.of(context).pop();
                _textController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
