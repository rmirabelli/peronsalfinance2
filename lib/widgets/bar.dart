import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String label;
  final double dailyAmount;
  final double totalAmount;

  Bar(this.label, this.dailyAmount, this.totalAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Flexible(
      fit: FlexFit.tight,
      child: Column(
        children: [
          Text('$label'),
          SizedBox(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1)),
                ),
                FractionallySizedBox(
                  heightFactor:
                      totalAmount == 0.0 ? 0 : dailyAmount / totalAmount,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ),
          FittedBox(
            child: Text(
              '\$$dailyAmount',
              style: TextStyle(fontSize: 9),
            ),
          ),
        ],
      ),
    ));
  }
}
