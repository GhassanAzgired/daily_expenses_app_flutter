import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String label;
  final double expAmount;
  final double expAmountPct;

  ChartBars(this.label, this.expAmount, this.expAmountPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.18,
              // width: 40,
              child: FittedBox(
                child: Text(
                  '${expAmount.toStringAsFixed(0)}tl',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.02,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1.5, color: Colors.grey),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: expAmountPct,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: Colors.grey),
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.04,
            ),
            Container(
              height: constraints.maxHeight * 0.16,
              child: FittedBox(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
