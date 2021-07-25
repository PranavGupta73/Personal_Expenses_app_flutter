import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> _recentTransactions;
  Chart(this._recentTransactions);
  //double totalSpending = 0;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (int i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.year == weekDay.year) {
          totalSum += _recentTransactions[i].amount;
        }
        //totalSpending += _recentTransactions[i].amount;
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + double.parse(element['amount'].toString());
    });
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionValues.map((data) {
          return 
          Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                data['day'].toString(),
                double.parse(data['amount'].toString()),
                totalSpending == 0
                    ? 0.0
                    : double.parse(data['amount'].toString()) / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
