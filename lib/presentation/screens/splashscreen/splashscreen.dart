import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_blog/utils/constants/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(
          'Splashscreen'
        ),
      ),
    );
  }

  startTime() async {
    return Timer(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        tutorialRoute,
            (Route<dynamic> route) => false,
      );
    });
  }
}
