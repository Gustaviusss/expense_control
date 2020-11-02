import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  // [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastos Pessoais',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  bool _showChart = true;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1', title: 'curso de dart', amount: 25.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'conta dev google',
    //     amount: 105.33,
    //     date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget _buildAppbar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Gastos Pessoais'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction,
              )
            ]))
        : AppBar(
            title: Text('Gastos Pessoais'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddNewTransaction(context))
            ],
          );
  }

  Widget _buildLandscape() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'Mostrar Card',
        style: Theme.of(context).textTheme.title,
      ),
      Switch(
        value: widget._showChart,
        onChanged: (value) {
          setState(() {
            widget._showChart = value;
          });
        },
      ),
    ]);
  }

  List<Widget> _buildPortrait(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  Widget _buildScaffold(Widget bodyContent, Widget appBar) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyContent,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyContent,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppbar();

    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: TransactionList(_userTransaction, _deleteTransaction));
    final bodyContent = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape) _buildLandscape(),
          if (!isLandscape) ..._buildPortrait(mediaQuery, appBar, txListWidget),
          if (isLandscape)
            widget._showChart == true
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : txListWidget
        ],
      ),
    ));

    return _buildScaffold(bodyContent, appBar);
  }
}
