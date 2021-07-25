import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';

class ChartBar extends StatelessWidget {
  String label;
  double spendingAmount;
  double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(child: Text('Rs.$spendingAmount'))),
        SizedBox(
          height: 4,
        ),
        Container(
          //margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          height: 100,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade800, width: 1.0),
                    color: Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child:Container(decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),)
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
