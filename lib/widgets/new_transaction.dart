import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(titleController.text, double.parse(amountController.text));

    Navigator.of(context).pop();
  }

  FocusNode myFocus;

  @override
  void initState() {
    super.initState();

    myFocus = FocusNode();
  }

  void dispose() {
    myFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        margin: EdgeInsets.only(
          top: 0,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration:
                  InputDecoration(labelText: 'Título'), // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleController,
              onSubmitted: (context) {
                return myFocus.requestFocus();
              },
            ),
            TextField(
              focusNode: myFocus,
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
