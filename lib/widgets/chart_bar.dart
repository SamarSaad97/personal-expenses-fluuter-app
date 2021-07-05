import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double totalSpending;
  final double prc;

  ChartBar(this.day, this.totalSpending, this.prc);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Column(
        children: [
          Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${totalSpending.toStringAsFixed(0)}'))),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          Container(
            width: 10,
            height: constrains.maxHeight * 0.6,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1.0)),
                ),
                FractionallySizedBox(
                  heightFactor: prc,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          Container(
              child: FittedBox(child: Text(day)),
              height: constrains.maxHeight * 0.15),
        ],
      );
    });
  }
}
