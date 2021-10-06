import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/transaction.dart';
import './trans_list.dart';
import './trans_new.dart';
import './chart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    // //   id: 't1',
    // //   title: 'Screen',
    // //   amount: 170,
    // //   date: DateTime.now(),
    // // ),
    // // Transaction(
    // //   id: 't2',
    // //   title: 'Keyboard',
    // //   amount: 110,
    // //   date: DateTime.now(),
    // // )
  ];
  bool _showChart = true;

  List<Transaction> get _recentTrans {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String xTitle, double xAmount, DateTime xDate) {
    final tx = Transaction(
      title: xTitle,
      amount: xAmount,
      date: xDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactions.add(tx);
    });
  }

  void _startAddNewInput(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      // backgroundColor: Theme.of(context).primaryColor,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: TransNew(_addNewTransaction),
          ),
        );
      },
    );
  }

  void _deletElement(String xId) {
    setState(() {
      _transactions.removeWhere((element) => element.id == xId);
    });
  }

  List<Widget> _buildLandScapeMode(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget xTransList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTrans),
            )
          : xTransList,
    ];
  }

  List<Widget> _buildPortraitMode(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget xTransList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTrans),
      ),
      xTransList
    ];
  }

  PreferredSizeWidget _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      middle: Text('Daily Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _startAddNewInput(context),
            child: const Icon(CupertinoIcons.add),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildMaterialAppBar() {
    return AppBar(
      title: const Text('Daily Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewInput(context),
          icon: const Icon(
            Icons.add_box,
            color: const Color(0xFFFFC95B),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar =
        Platform.isIOS ? _buildCupertinoAppBar() : _buildMaterialAppBar();

    final xTransList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransList(_transactions, _deletElement),
    );
    final pageApp = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandScape)
              ..._buildLandScapeMode(
                mediaQuery,
                appBar,
                xTransList,
              ),
            if (!_isLandScape)
              ..._buildPortraitMode(
                mediaQuery,
                appBar,
                xTransList,
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget?,
            child: pageApp,
          )
        : Scaffold(
            appBar: appBar,
            body: pageApp,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS || (_showChart && _isLandScape)
                ? Container()
                : FloatingActionButton(
                    child: Icon(
                      Icons.add_box,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => _startAddNewInput(context),
                    splashColor: Theme.of(context).colorScheme.primary,
                  ),
          );
  }
}
