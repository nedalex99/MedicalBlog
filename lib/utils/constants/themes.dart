import 'package:flutter/material.dart';
import 'package:medical_blog/utils/constants/colors.dart';

final kEnrollmentTheme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
  appBarTheme: AppBarTheme(elevation: 0, color: kBackgroundColor),
  scaffoldBackgroundColor: kBackgroundColor,
  accentColor: kBlueButtonColor,
  primaryColor: Colors.black,
  unselectedWidgetColor: Colors.grey,
);
