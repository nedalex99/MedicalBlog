import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSheet({
  @required BuildContext context,
  @required Widget child,
  @required VoidCallback onClicked,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        child,
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Done'),
        onPressed: onClicked,
      ),
    ),
  );
}

int daysInMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(firstDayThisMonth.year,
      firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}
