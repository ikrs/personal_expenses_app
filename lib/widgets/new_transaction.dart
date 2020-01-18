import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // button to the right
          children: <Widget>[
            TextField(
              controller: _titleController,
              // flutter automatically connects controllers to our text inputs and this
              //   controllers listen to user inputs and save the user input
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  // expanded takes as much free space as it can get
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date choosen!'
                          : 'Picked Date : ${DateFormat('d.MM.y').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount =
        double.parse(_amountController.text); // text to double/float

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    //inherit function passed to constructor from parent StateFull widget
    widget.addNewTransaction(enteredTitle, enteredAmount);

    // close model popup after submit
    Navigator.of(context).pop();
  }

  // implementing date picker
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}
