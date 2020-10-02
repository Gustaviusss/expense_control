import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'curso de dart', amount: 25.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'conta dev google',
        amount: 105.33,
        date: DateTime.now()),
  ];
  // String titleInput;
  // String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child:
                  Card(elevation: 5, color: Colors.cyan, child: Text('CHART!')),
            ),
            Card(
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
                      // onChanged: (value) {
                      //   amountInput = value;
                      // },
                      controller: amountController,
                    ),
                    FlatButton(
                      onPressed: () {
                        print(titleController.text);
                      },
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.purple, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
                children: transactions.map((tx) {
              return Card(
                  child: Row(
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\R\$${tx.amount}', //tx.amount.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 18),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tx.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(tx.date),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ));
            }).toList())
          ],
        ));
  }
}
