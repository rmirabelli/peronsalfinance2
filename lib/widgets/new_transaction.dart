import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, int) addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
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
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'amount'),
              controller: amountController,
              onSubmitted: (_) {
                _submitTransaction();
              },
            ),
            FlatButton(
              child: Text('addTransaction'),
              onPressed: _submitTransaction,
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }

  void _submitTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = (double.parse(amountController.text) * 100).toInt();

    if (enteredTitle.isEmpty || enteredAmount < 0) return;
    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }
}
