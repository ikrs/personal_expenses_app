import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

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
              //onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              //onChanged: (value) => amountInput = value,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () => addNewTransaction(
                titleController.text,
                double.parse(amountController.text), // text in to double/float
              ),
            ),
          ],
        ),
      ),
    );
  }
}
