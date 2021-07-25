import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';

class TransacationList extends StatelessWidget {
  late List<Transactions> transactions;
  final Function deleteTransaction;

  TransacationList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 400,
                  child: Image(image: AssetImage('assets/images/waiting.png'))),
            ],
          )
        : Container(
            height: 400,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 50,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Rs.',
                              style: TextStyle(fontSize: 11),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '${transactions[index].amount}',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        )),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTransaction(transactions[index].id);
                      },
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          );
  }
}
