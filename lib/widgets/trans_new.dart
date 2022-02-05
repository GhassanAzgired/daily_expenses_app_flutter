import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';

class TransNew extends StatefulWidget {
  final Function _transNew;

  TransNew(this._transNew);

  @override
  _TransNewState createState() => _TransNewState();
}

class _TransNewState extends State<TransNew> {
  bool isFocused = false;
  final _amountInput = TextEditingController();
  final _titleInput = TextEditingController();
  DateTime _pickedDate = DateTime(2020);

  void _submitData() {
    if (_amountInput.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleInput.text;
    final eneteredAmount = double.parse(_amountInput.text);

    if (enteredTitle.isEmpty ||
        eneteredAmount < 0 ||
        _pickedDate == DateTime(2020)) {
      return;
    }
    widget._transNew(
      enteredTitle,
      eneteredAmount,
      _pickedDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  const Color(0xFFFFC95B),
                ),
              ),
            ),
            fontFamily: 'Quicksand',
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF2C0540),
              primaryContainer: const Color(0xff3700b3),
              secondary: const Color(0xFFFFC95B),
              secondaryContainer: const Color(0xff018786),
              surface: Colors.white,
              background: Colors.white,
              error: const Color(0xffb00020),
              onPrimary: const Color(0xFFFFC95B),
              onSecondary: Colors.black,
              onSurface: Colors.black,
              onBackground: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light,
            ),
          ),
          child: child as Widget,
        );
      },
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(),
                ),
                controller: _titleInput,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  labelText: 'Amount',
                  labelStyle: TextStyle(),
                ),
                keyboardType:
                    TextInputType.number /* WithOptions(decimal:true) */,
                controller: _amountInput,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _pickedDate == DateTime(2020)
                            ? 'No date is chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_pickedDate)}',
                        style: TextStyle(
                            // color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Quicksand'),
                      ),
                    ),
                    AdaptiveFlatButton(
                      'Choose Date',
                      _datePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Theme.of(context).colorScheme.primary;
                      return Theme.of(context).colorScheme.secondary;
                    },
                  ),
                ),
                onPressed: () {
                  _submitData();
                },
                child: Text(
                  'Add Transaction',

                  // style: TextStyle(
                  //   color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
