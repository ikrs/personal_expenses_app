import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('d.MM.y').format(
            transaction.date,
          ),
        ),
        // shows Delete icon at the end of list tile, display button label 
        // text based on available width
        trailing: MediaQuery.of(context).size.width > 460 ? FlatButton.icon(
          textColor: Theme.of(context).errorColor,
          // this will never change, it will always display Delete, so we tell flutter 
          // that he does not need to rebuild this widget
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
          onPressed: () => deleteTransaction(transaction.id),
        ) :  IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}