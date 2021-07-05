import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserTransactions extends StatefulWidget {
  final Function newTransInput;

  UserTransactions(this.newTransInput);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final titleController = TextEditingController();
  DateTime userPickedDate = DateTime.now();
  final amountController = TextEditingController();

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          userPickedDate = value;
        });
      }
    });
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = amountController.text;

    if (enteredTitle.isEmpty || double.parse(enteredAmount) <= 0) {
      return;
    }
    print('title: ' + enteredTitle);
    print('cost: ' + enteredAmount);
//widget.function to accepet a function from outside the state class and use it in state class
    widget.newTransInput(
        enteredTitle, double.parse(enteredAmount), userPickedDate);
    //to close bottom sheet after submitting automatically
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController),
              Container(
                height: 70,
                child: Row(
                  children: [
                    userPickedDate == null
                        ? Text('No Date Chosen!')
                        : Text(DateFormat.yMMMEd().format(userPickedDate)),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _pickDate,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: submitData,
                  child: Text(
                    'Add transaction',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
