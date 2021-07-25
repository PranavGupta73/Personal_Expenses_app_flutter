import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;
  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate = DateTime(2020);

  void submitData() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate==DateTime(2020)) {
      return;
    }
    widget.newTransaction(enteredTitle, enteredAmount,selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDayPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });

      //print(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == DateTime(2020)
                        ? 'No date chosen!'
                        : 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FlatButton(
                    padding: EdgeInsets.all(18),
                    onPressed: () {
                      _presentDayPicker();
                    },
                    child: Text(
                      'Choose Date',
                      style: Theme.of(context).textTheme.headline6,
                    )),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
                //style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  submitData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Transaction',
                    style: Theme.of(context).textTheme.button,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
