import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) _removeTransaction;

  TransactionList(this.transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 50),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            Transaction transaction = transactions[index];
            return Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 4,
                    ),
                    child: FittedBox(
                      child: Text(
                          '\$${(transaction.amountInPennies / 100).toStringAsFixed(2)}'),
                    ),
                  ),
                ),
                title: Text(
                  transaction.title,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                subtitle: Text(
                  '${DateFormat.MMMMEEEEd().format(transaction.date)}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    _removeTransaction(transaction.id);
                  },
                ),
              ),
            );
          },
          itemCount: transactions.length,
        ),
      ),
    );
  }
}
