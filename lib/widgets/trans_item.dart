// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransItem extends StatefulWidget {
  final Function delete;
  final Transaction transaction;
  final int index;

  const TransItem({
    required this.delete,
    required this.transaction,
    required Key key,
    required this.index,
  }) : super(key: key);

  @override
  _TransItemState createState() => _TransItemState();
}

class _TransItemState extends State<TransItem> {
  static const _bgColor = [
    Color(0xFF2C0540),
    Color(0xFFFFC95B),
  ];
  Widget _buildCircleAvatar() {
    return CircleAvatar(
      radius: 27,
      backgroundColor: widget.index.isEven ? _bgColor[0] : _bgColor[1],
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: FittedBox(
          child: Text(
            '${widget.transaction.amount.toStringAsFixed(0)}tl',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 4,
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ListTile(
          trailing: MediaQuery.of(context).size.width > 450
              ? TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor,
                  ),
                  onPressed: () {
                    widget.delete(widget.transaction.id);
                  },
                  icon: Icon(Icons.delete),
                  label: const Text('Delete'),
                )
              : IconButton(
                  color: Theme.of(context).errorColor,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.delete(widget.transaction.id);
                  },
                ),
          leading: _buildCircleAvatar(),
          title: Text(
            '${widget.transaction.title}',
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transaction.date),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
