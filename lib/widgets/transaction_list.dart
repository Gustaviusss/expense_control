import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transaction.isEmpty
            ? Column(
                children: <Widget>[
                  Text('Sem Gastos por enquanto',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(height: 20),
                  Container(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColorLight,
                                    width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '\R\$${transaction[index].amount.toStringAsFixed(2)}', //tx.amount.toString(),
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 18),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(transaction[index].title,
                                style: Theme.of(context).textTheme.title),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(transaction[index].date),
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: transaction.length,
              ));
  }
}
