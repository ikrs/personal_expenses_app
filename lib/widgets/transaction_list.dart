import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

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
              return TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction);
            },
            // how many items should be loaded = how many times itemBuilder will run
            itemCount: transactions.length,
          );
  }
}
