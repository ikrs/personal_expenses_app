import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
              controller: titleController,
              // flutter automatically connects controllers to our text inputs and this
              //   controllers listen to user inputs and save the user input
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount =
        double.parse(amountController.text); // text to double/float

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    //inherit function passed to constructor from parent StateFull widget
    widget.addNewTransaction(enteredTitle, enteredAmount);

    // close model popup after submit
    Navigator.of(context).pop();
  }
}
