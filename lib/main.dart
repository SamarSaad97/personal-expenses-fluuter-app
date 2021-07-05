import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/user_transactions.dart';
import './models/Transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purple[200],
          fontFamily: 'openSans'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [
    // Transaction(
    //     amount: 22.3, date: DateTime.now(), id: 't1', title: 'gas money'),
    // Transaction(
    //     amount: 50.3, date: DateTime.now(), id: 't2', title: 'food money'),
    // Transaction(
    //     amount: 15.3, date: DateTime.now(), id: 't3', title: 'food money again')
  ];
  _addNewTransaction(String txtTitle, double txtAnount, DateTime myDate) {
    Transaction newTransaction = Transaction(
        amount: txtAnount,
        date: myDate,
        id: DateTime.now().toString(),
        title: txtTitle);

    setState(() {
      transactions.add(newTransaction);
    });
    print(newTransaction.title);
  }

  _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddingNewTransaction(BuildContext cntx) {
    showModalBottomSheet(
        context: cntx,
        builder: (_) {
          return UserTransactions(_addNewTransaction);
        });
  }

  List<Transaction> get _recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    final bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: Text(
          'Flutter App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      appBar = AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddingNewTransaction(context))
        ],
        title: Text(
          'Flutter App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    final txList = Container(
        child: TransactionList(transactions, _deleteTransaction),
        height: MediaQuery.of(context).size.height * 0.7 -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top);
    // for (var i = 0; i < _recentTransaction.length; i++) {
    //   print(_recentTransaction[i].title);
    // }
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                  child: Chart(_recentTransaction),
                  height: MediaQuery.of(context).size.height * 0.3 -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top),
            if (!isLandScape) txList,
            if (isLandScape)
              _showChart
                  ? Container(
                      child: Chart(_recentTransaction),
                      height: MediaQuery.of(context).size.height * 0.7 -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top)
                  : txList
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: const CupertinoNavigationBar(
              middle: Text(
                'Flutter App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddingNewTransaction(context),
                    child: Icon(
                      Icons.add,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ));
  }
}
