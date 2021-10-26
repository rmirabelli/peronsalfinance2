import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        final xactions = recentTransactions.where((element) =>
            element.date.day == weekDay.day &&
            element.date.month == weekDay.month &&
            element.date.year == weekDay.year);
        final int sum = xactions.fold(
            0,
            (previousValue, element) =>
                previousValue + element.amountInPennies);
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': sum / 100,
        };
      },
    ).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final int grandTotal = recentTransactions.fold(
        0, (previousValue, element) => previousValue + element.amountInPennies);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (e) => Bar(e['day'] as String, (e['amount'] as double),
                    grandTotal / 100),
              )
              .toList()),
    );
  }
}
