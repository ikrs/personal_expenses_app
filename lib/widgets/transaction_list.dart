import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: <Widget>[
              Text(
                'No Transactions added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              //adding spaceing
              SizedBox(
                height: 20,
              ),
              //adding image
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        })
        // adding scroll to the transaction with ListView, must use Container with defined height
        // better then SingleChildScrollView
        // ListView(children:[]) loads all list items
        // ListView.builder() loads only whats visible = BETTER PERFORMANCE FOR LONG LISTS
        : ListView.builder(
            // children: transactions.map((transaction) // ListView(children: [])
            itemBuilder: (context, index) {
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
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat('d.MM.y').format(
                      transactions[index].date,
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
                    onPressed: () => deleteTransaction(transactions[index].id),
                  ) :  IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTransaction(transactions[index].id),
                  ),
                ),
              );
            },
            // how many items should be loaded = how many times itemBuilder will run
            itemCount: transactions.length,
          );
  }
}
