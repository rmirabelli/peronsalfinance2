import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, int, DateTime) addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate = null;

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
            Container(
              height: 70,
              child: Row(children: [
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : DateFormat.MEd().format(_selectedDate!),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                FlatButton(
                  child: Text('Choose Date'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _presentDatePicker,
                ),
              ]),
            ),
            RaisedButton(
                child: Text('addTransaction'),
                onPressed: _submitTransaction,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button?.color)
          ],
        ),
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((newDate) {
      if (newDate == null) {
        return;
      }

      setState(() {
        _selectedDate = newDate;
      });
    });
  }

  void _submitTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = (double.parse(amountController.text) * 100).toInt();

    if (enteredTitle.isEmpty || enteredAmount < 0) return;
    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate ?? DateTime.now(),
    );

    Navigator.of(context).pop();
  }
}
