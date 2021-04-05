import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_blog/utils/constants/routes.dart';
import 'package:get/get.dart';
import 'package:medical_blog/utils/constants/strings.dart';
import 'package:medical_blog/utils/network/auth_service.dart';
import 'package:medical_blog/utils/user_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PreferencesUtils _preferencesUtils = Get.find();
  AuthService _authService = Get.find();

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

  startTime() async {
    String keepMeAuthFlag =
        await _preferencesUtils.getKeepMeAuthFlag(kKeepMeAuthFlag, "");
    String tutorialFlag =
        await _preferencesUtils.getTutorialFlag(kTutorialFlagKey, 'false');

    if (tutorialFlag == 'false' || tutorialFlag == null) {
      Get.offAllNamed(kTutorialRoute);
    } else if (keepMeAuthFlag != null && keepMeAuthFlag == 'true') {
      if (_authService.getUser() != null) {
        Get.offAllNamed(kDashboardRoute);
      } else {
        Get.offAllNamed(kLoginRoute);
      }
    } else {
      Get.offAllNamed(kLoginRoute);
    }
    // return Timer(Duration(seconds: 2), () async {
    //   String tutorialFlag =
    //       await _preferencesUtils.getTutorialFlag(kTutorialFlagKey, 'false');
    //
    //   if (tutorialFlag == 'false' || tutorialFlag == null) {
    //     Get.offAllNamed(kTutorialRoute);
    //   } else {
    //     Get.offAllNamed(kLoginRoute);
    //   }
    // });
  }
}
