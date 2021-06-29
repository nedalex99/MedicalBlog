import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

String handleSecondsFromTimestamp(int seconds) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  int years = DateTime.now().year - time.year;
  int months = DateTime.now().month - time.month;
  int days = DateTime.now().day - time.day;
  int hours = DateTime.now().hour - time.hour;
  int minutes = DateTime.now().minute - time.minute;
  if (years > 0) {
    return '$years' + 'y';
  } else if (months > 0 && months <= 12) {
    return '$months' + 'mo';
  } else if (days > 0 && days <= daysInMonth(DateTime.now())) {
    return '$days' + 'd';
  } else if (hours > 0 && hours <= 24) {
    return '$hours' + 'h';
  } else if (minutes == 0) {
    return '1m';
  } else {
    return '$minutes' + 'm';
  }
}

String handleMillisecondsFromTimestamp(int seconds) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(seconds);
  int years = DateTime.now().year - time.year;
  int months = DateTime.now().month - time.month;
  int days = DateTime.now().day - time.day;
  int hours = DateTime.now().hour - time.hour;
  int minutes = DateTime.now().minute - time.minute;
  if (years > 0) {
    return '$years' + 'y';
  } else if (months > 0 && months <= 12) {
    return '$months' + 'mo';
  } else if (days > 0 && days <= daysInMonth(DateTime.now())) {
    return '$days' + 'd';
  } else if (hours > 0 && hours <= 24) {
    return '$hours' + 'h';
  } else if (minutes == 0) {
    return '1m';
  } else {
    return '$minutes' + 'm';
  }
}

String parseDate(String date) {
  DateTime dateTime = DateFormat("yyyy-MM-dd").parse(date);
  var x = dateTime.millisecondsSinceEpoch.toString();
  return x;
}

List<String> getWordsToSearch({String text}) {
  List<String> caseSearchList = [];
  String caseSearch = "";
  for (int i = 0; i < text.length; i++) {
    caseSearch += text[i].toLowerCase();
    caseSearchList.add(caseSearch);
  }
  return caseSearchList;
}

Future<String> getPhoto({String id}) async {
  String url;
  try {
    final ref = FirebaseStorage.instance
        .ref(id)
        .child("images/$id");
    url = await ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    print(e.code);
    return null;
  }
}
