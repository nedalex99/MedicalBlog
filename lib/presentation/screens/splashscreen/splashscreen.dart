import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_blog/presentation/screens/tutorial/tutorial_page_view.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/user_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PreferencesUtils _preferencesUtils = Get.find();

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('Splashscreen'),
      ),
    );
  }

  startTime() {
    return Timer(Duration(seconds: 2), () async {
      String tutorialFlag =
          await _preferencesUtils.getTutorialFlag(kTutorialFlagKey, 'false');

      if (tutorialFlag == 'false' || tutorialFlag == null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          tutorialRoute,
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          loginRoute,
          (Route<dynamic> route) => false,
        );
      }
    });
  }
}
