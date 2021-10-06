import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './trans_item.dart';

class TransList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;

  TransList(this.transactions, this.delete);

  Widget _buildLandScapeMode(BuildContext context, BoxConstraints constrains) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: constrains.maxHeight * 0.36,
        ),
        Text(
          'No transactions added yet!',
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  Widget _buildPortraitMode(BuildContext context, BoxConstraints constrains) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'No transactions added yet!',
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: constrains.maxHeight * 0.50,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constrains) {
                return Container(
                  // width: double.infinity,
                  // height: 280,
                  child: (_isLandScape)
                      ? _buildLandScapeMode(context, constrains)
                      : _buildPortraitMode(context, constrains),
                );
              },
            )
          : Container(
              width: double.infinity,
              height: 450,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return TransItem(
                    key: ValueKey(transactions[index].id),
                    delete: delete,
                    transaction: transactions[index],
                    index: index,
                  );
                },
              ),
            ),
    );
  }
}
