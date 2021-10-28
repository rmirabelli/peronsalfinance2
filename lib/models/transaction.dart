import 'package:flutter/material.dart';

class Transaction {
  String id;
  String title;
  int amountInPennies;
  DateTime date;

  void printTransaction() {
    debugPrint('${id} ${title}');
  }

  Transaction({
    this.id = "",
    this.title = "",
    this.amountInPennies = 0,
    required this.date,
  });
}
