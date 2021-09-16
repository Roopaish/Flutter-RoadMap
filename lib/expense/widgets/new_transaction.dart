import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; // return when title is empty or amount is negative
    }
    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (val) => titleInput = val,
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (val) => amountInput = val,
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    DateFormat.yMd().format(_selectedDate),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    child: Text(
                      "Pick A Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
