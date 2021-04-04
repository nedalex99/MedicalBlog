import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerCupertino extends StatelessWidget {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildDatePicker(),
      ),
    );
  }

  Widget buildDatePicker() => CupertinoDatePicker(
        initialDateTime: dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) => this.dateTime = dateTime,
      );
}
