import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './user_transactions.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function addTx;

  NewTransaction(this.addTx);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addTx(titleController.text, double.parse(amountController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
              // onChanged: (value) {
              //   amountInput = value;
              // },
              onSubmitted: (_) => submitData(),
              controller: amountController,
            ),
            FlatButton(
              onPressed: submitData,
              child: Text(
                'Salvar',
                style: TextStyle(color: Colors.purple, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
