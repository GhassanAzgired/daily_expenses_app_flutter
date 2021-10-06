import 'package:intl/intl.dart';

import './chart_bars.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get grpTransVals {
    return List.generate(7, (index) {
      var totalAmount = 0.0;
      final weekDays = DateTime.now().subtract(Duration(days: index));
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDays.day &&
            recentTransactions[i].date.month == weekDays.month &&
            recentTransactions[i].date.year == weekDays.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return {
        'days': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return recentTransactions.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      padding: const EdgeInsets.all(8),
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: grpTransVals.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBars(
                  (data['days'] as String),
                  (data['amount'] as double),
                  totalSpending == 0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
